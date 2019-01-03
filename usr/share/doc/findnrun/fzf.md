_Next: [Starting Findnrun](running.md)_

## Fzf Search Engine

[fzf](https://github.com/junegunn/fzf) is a versatile cross-platform
command-line fuzzy finder program.  Since version 4.0.0 findnrun integrates fzf
as a search engine alternative to its built-in fuzzy finder.

**Pros**

* Fzf is faster than the built-in search engine.
* Fzf's fuzzy search algorithm is smarter than the built-in one.
* Fzf's search syntax is more powerful than the built-in search syntax. Search
  for multiple terms (AND/OR), negate search terms, mix searching for fuzzy and
  exact terms, and more (refer to fzf's manual for details).
* With fzf installed, you can toggle search detail options (filename, comment
  and category) without needing to restart findnrun.
* Fzf (with full installation) can also be used outside findnrun, as a powerful
  tool to search for files, browse shell history, as an interactive alternative
  to grep, and much more.

**Cons**

* Fzf adds about 2 MB of disc space usage.
* Fzf doesn't support regular expressions, for which you can continue to use
  the built-in engine.
* Unlike the built-in fuzzy engine, Fzf doesn't underline the characters that
  matched your search term.

If additional disc space isn't a concern, we highly recommend installing fzf.
The pros far outweigh the cons.

### Installing Fzf

If command `fzf` is already installed in the shell `PATH`, fzf becomes the
default search engine automatically for both fuzzy and exact search. Fzf's
extended search syntax applies to both cases.

If `fzf` isn't found in `PATH`, findnrun displays a startup dialog that offers
to download and install fzf.

You can also install fzf by following the instructions found on
[fzf's website](https://github.com/junegunn/fzf). This full installation is
recommended for interactive shell use.

### Uninstalling Fzf

To disable fzf see [FNRSEARCHENGINE](running.md).

To uninstall fzf delete the binary file `/usr/share/findnrun/fzf` and the link
file `/usr/bin/fzf`. If you performed a full installation follow the
uninstallation instructions found on fzf's website.

_Next: [Starting Findnrun](running.md)_

