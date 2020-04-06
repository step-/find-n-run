# @INCLUDE this file.
# Globals:
# STEM=<filepath>
# RATE=<typing rate>
END { #{{{1
  # Fill with blank images as needed. {{{2
  if(sent < MAXSLOT) {
    for(i = sent; i < MAXSLOT; i++) {
      make_links = make_links link_image(".blankimg", "", 0, i) # TODO implement ymax>0
    }
  }
  # Link image files then refresh the viewer component. {{{2
  # Early implementations consisted of the following simple command:
  #   system(make_links "date > \"" STEM "-refresh\"")
  # which creates the symlinks then sends gtkdialog a refresh (pixmaps)
  # request.
  # While the command works in many cases, rightmost pixmaps aren't
  # updated when the user is typing too quickly the search term. In
  # that case all symbolic links *are* always created timely, and so
  # are refresh requests sent to gtkdialog. However, while gtkdialog
  # is processing a refresh request and another refresh request comes
  # in, the latter is lost.
  # So I changed the code to "debounce" refresh requests. By that I mean
  # that a process queue is created. Each process in the queue is a
  # pending refresh request with a timeout of RATE seconds. Any refresh
  # request is executed if no new requests come into the queue within
  # the timeout. A new request cancels all pending requests before it.
  # RATE, is the tuning parameter of viewer accuracy vs. user's
  # experience.  If RATE is set too low, the viewer will update
  # thumbnails inaccurately. The user experiences a RATE second lag
  # between the final typed character and the final thumbnail update -
  # intervening characters don't produce updates if they're typed faster
  # than RATE. RATE is a system-dependent value. It should be set to the
  # lowest possible value that balances accuracy and user experience.
  # RATE defaults to 0.6 s.

  tag="'@" STEM "@'"
  # Tested with /bin/bash, /bin/ash, '/bin/busybox sh'.
  sh="/bin/sh -s "tag # -x if you will
  request="date > '"STEM"-refresh';"

  print \
  "exec 1>&2;" \
  make_links \
  "(" \
    ": set -x;" \
    "trap '' TERM;   : disallow cancelling my process a.k.a. request;" \
    "pkill -f "tag"; : cancel all pending requests" \
    "trap - TERM;    : allow cancelling my request;" \
    "sleep "RATE";   : enter pending-request queue to...;" \
    request"         : refresh pixmaps unless next request cancels me;" \
  ") 1>/dev/null &" | sh # MUST redirect stdout else gawk blocks.

  close(sh)
}

# vim: fdm=marker:
