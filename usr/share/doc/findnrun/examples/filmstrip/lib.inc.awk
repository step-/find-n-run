#{{{1
function reference(y, x) # {{{2
{
  return(STEM "-y" y "x" x) # -v STEM="${INPUTSTEM}"
}

function link_image(path, caption, y, x,   ref) # {{{2
{
  ref = reference(y, x)
  print caption > (ref "c")
  close(ref "c")
  # Postpone actual linking to a single call of the system() function.
  return ("ln -sf \"" path "\" \"" ref "\";")
}

#TODO remove this block function blank_images(start, x, ref, make_links) # {{{2
#{
#  for(x = start; x < MAXSLOT; x++) {
#    make_links = make_links link_image(".blankimg", "", 0, x) # TODO implement ymax>0
#  }
#  return(make_links)
#}

