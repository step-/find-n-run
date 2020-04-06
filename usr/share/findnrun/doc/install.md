_Next: [Fzf Search Engine](fzf.md)_

## Installing

It is recommended to install the latest full package for your
distribution, which is split into multiple sub-packages:

 * The _base_ package includes the main script, its `.desktop` file, and
   an English help file (markdown)
 * The optional _NLS_ package adds run-time translations in several
   languages

[Installation requirements](install-require.md).

To improve search features, accuracy and speed consider also installing the
_[fzf search engine](fzf.md)_ package (highly recommended).

To read _translated_ help files the _mdview_ markdown viewer is
required.  While a text editor is sufficient to read English help files,
installing mdview is recommended for an improved experience.  Mdview
is a small, single-file, GTK application that displays markdown with
clickable hyperlinks and pictures.

### Packages

Packages for various distributions can be downloaded from:

(1) the latest release announcement in the
[releases page](http://github.com/step-/find-n-run/releases/):

* Fatdog64 [.txz](http://github.com/step-/find-n-run/releases/)
* Puppy Linux [.pet](http://github.com/step-/find-n-run/releases/)
* Debian/Ubuntu/Mint - .deb packages aren't available, but you should be able
  to install findnrun following the
  [Debian page](https://github.com/step-/find-n-run/blob/master/usr/share/findnrun/doc/DEBIAN.md).

(2) one of these known threads:

 * Puppy Linux full
   [.pet](http://www.murga-linux.com/puppy/viewtopic.php?t=98330), which
   also features a ROX-app application
 * Quirky Linux [.pet](http://www.murga-linux.com/puppy/viewtopic.php?t=99789)

## Language Settings

If the system locale is correctly configured, and the optional NLS
support package is installed, which includes translations for your local
language, findnrun should automatically display its messages in the
local language.

Moreover the search result list can display item _name_ and _comments_
in the local language provided that the corresponding `.desktop` file
includes translated names and comments, which is independent of findnrun.
(Item _categories_ instead are strictly single-language ,typically
English, according to the freedesktop.org's desktop file specifications
[ref1](http://standards.freedesktop.org/desktop-entry-spec/latest/ar01s04.html)
and
[ref2](http://standards.freedesktop.org/desktop-entry-spec/latest/ar01s05.html)).

Some plugins may require you to install a separate NLS support package
before they can display translated messages.

_Next: [Fzf Search Engine](fzf.md)_

