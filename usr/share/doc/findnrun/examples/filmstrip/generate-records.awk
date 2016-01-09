# Arguments {{{1
# -v OUTF=<output file> which eventually will be sent to findnrun
# -v TERM=<search term>
# -v MAXREC=<max> return at most <max> lines to the search list
# -v MAXSLOT=<viewer slots>  [1..n]
# -v STEM=<filepath>
# -i lib.awk

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
{ # Send output record to findnrun seach list widget. {{{2
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
  na = split(abspath, a, /\//)
  label = na < 5 ?abspath :("/" a[2] "/.../" a[na-1] "/" a[na])
  # We use the caption for <comment>.
  if("" == caption) {
    caption = a[na] # picture filename as default caption
  } else {
    ; # CUSTOM_CAPTION
  }
  return("||" label "|" abspath "|" caption "|" NONE)
}

