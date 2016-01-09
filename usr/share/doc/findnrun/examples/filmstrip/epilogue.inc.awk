# @INCLUDE this file.
END { #{{{1
  # Fill with blank images as needed. {{{2
  if(sent < MAXSLOT) {
    for(i = sent; i < MAXSLOT; i++) {
      make_links = make_links link_image(".blankimg", "", 0, i) # TODO implement ymax>0
    }
  }
  # Link image files then refresh the viewer component. {{{2
  system(make_links "date > \"" STEM "-refresh\"")
}

