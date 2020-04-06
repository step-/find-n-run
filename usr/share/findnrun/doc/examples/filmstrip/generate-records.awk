# Arguments {{{1
# -v OUTF=<output file> which eventually will be sent to findnrun
# -v TERM=<search term>
# -v BASEDIR=<SEARCH_IN path>   "" or !"" without trailing slash
# -v MAXREC=<max> return at most <max> lines to the search list
# -v MAXSLOT=<viewer slots>  [1..n]
# -v STEM=<filepath>
# -v RATE=<typing rate>
# -i lib.inc.awk

# Generate new records, and send image references to the viewer component. {{{1
BEGIN {
  matched = sent = 0
  printf "" > OUTF
}
{ # Match TERM literally and only within the filename part of the absolute path. {{{2
  # OR within the last '|'-separated field, if any.
#  print index(toupper($(NF)), toupper(TERM)),"find <" TERM "> in <"$(NF)">">"/dev/stderr"
  if(index(toupper($(NF)), toupper(TERM))) {++matched} else {next}
}
{ # Split pathname and caption. {{{2
  # <record> ::= <path>['|'<caption>]
  abspath = (p = index($0, "|")) ?substr($0, 1, p-1) :$0
  # Note that <caption> == $(NF) because IFS="[/|]" regex.
  caption = $(NF)

  # Undo forward-slash to division-slash replacement, see
  # exif_caption_abstract() in file 'taprc'
  gsub("\xe2\x88\x95", "/", caption)
}
matched && matched <= MAXSLOT { # Send image to viewer component. {{{2
  make_links = make_links link_image(abspath, caption, 0, matched-1) # TODO implement ymax>0
  ++sent
}
{ # Send output record to findnrun search list widget. {{{2
  print format_fnr_record(abspath, caption) > OUTF
}
{ # Exit on reaching the maximum output record count. {{{2
  if( matched >= MAXREC) exit
}
#{{{1}}}
@include "epilogue.inc.awk"
@include "lib.inc.awk"

function format_fnr_record(abspath, caption,   na, a, label, NONE) # {{{1
{
  # Out:   <icon-filename> | <tap-reserved> | <label> | <tap-data> | <comment> | <categories>

  # Format label as <1st>/.../<(N-1)th>/<Nth> path component
  # with 1st component relative to $FIND_IN path, and
  # "..." included only if there are more than 3 components.
  label = abspath
  if("" != BASEDIR) sub("^"BASEDIR"/", "", label)
  na = split(label, a, /\//)
  label = na < 5 ?label :("/" a[2] "/.../" a[na-1] "/" a[na])

  # Use caption for <comment>.
  if("" == caption) {
    caption = a[na] # use picture filename as default caption
  } else {
    ; # CUSTOM_CAPTION
  }
  return("||" label "|" abspath "|" caption "|" NONE)
}

# vim: fdm=marker:
