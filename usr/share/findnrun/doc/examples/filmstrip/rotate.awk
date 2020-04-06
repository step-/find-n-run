# Arguments {{{1
# -v MAXSLOT=<viewer slots>  [1..n]
# -v STEM=<filepath>
# -v RATE=<typing rate>
# -v ROTATE=+<down>|-<up> [1..m], typically ROTATE <= MAXSLOT
# -i lib.inc.awk

# Rotate records in memory {{{1
{ # Records to memory, 0-based index.
  a[NR - 1] = $0
}
END { # Then read records from 'start' round the NR-hour clock.
  start = ROTATE > 0 ?( ROTATE % NR ) :( NR + (ROTATE % NR) )
}

# Output rotated records to findnrun search list and to viewer component. {{{1
BEGIN { sent = 0 }
END {
  # Special case: don't rotate when there aren't enough images to fill the viewer.
  if(NR <= MAXSLOT) start = 0
  for(i = 0; i < NR; i++) {
    r = (i + start) % NR # index of rotated record
    split(a[r], b) # 3:label, 4:path, 5:comment, see format_fnr_record()
    if(sent < MAXSLOT) { # Send image to viewer component. {{{2
      make_links = make_links link_image(b[4], b[5], 0, sent) # TODO implement ymax>0
      ++sent
    }
    # Send output record to findnrun search list widget. {{{2
    print a[r]
#    printf "%2s > %2s %s\n", i, r, substr(a[r],1,70) >"/dev/stderr"
  }
}

#{{{1}}}
@include "epilogue.inc.awk"
@include "lib.inc.awk"

# vim: fdm=marker:
