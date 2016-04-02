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
  # Change symlink target atomically, cf.
  # http://blog.moertel.com/posts/2005-08-22-how-to-change-symlinks-atomically.html
  return ("ln -s \"" path "\" \"" ref ".new\" && mv -Tf \"" ref ".new\" \"" ref "\";")
  # All shell commands are grouped in a single system() function call.
}
