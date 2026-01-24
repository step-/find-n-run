## Requirements

If you are using Puppy Linux, Fatdog64 or DebianDog your system should
already meet the minimum requirements for findnrun.  Other Debian-based
distributions, such as Ubuntu and Mint, need additional packages before
they can use findnrun. More information for Debian systems is available
on the
[Debian page](https://github.com/step-/find-n-run/blob/master/usr/share/findnrun/doc/DEBIAN.md)

Findnrun **requires** the following dependencies:

* The shell sh - see section _Shell_ below
* GNU awk gawk 4.1.0 or higher
* gtk-dialog 0.8.3 or higher
* xwininfo
* yad

Findnrun also uses the following packages if they are installed.

* **MDVIEW MTX** - graphical Markdown viewer. If mdview isn't
  installed a text editor will be used to open Markdown documents.
  Mdview can be found [here](http://github.com/step-/mdview).
* The /proc file system (Linux). If /proc isn't available, findnrun can't
  restart itself automatically. Other functions are unaffected.
* GNU date - only if debugging mode is enabled.

### Shell

Findnrun is tested and known to work with the following shells: ash, dash,
bash. By default findnrun runs under `/bin/sh`, which is linked to dash on
Debian Linux, and to bash on Ubuntu Linux. On Fatdog64 and other slim
distributions `/bin/sh` is linked to busybox ash.

If you need to run findnrun under a specific shell, you can edit the first line
of file `/usr/bin/findnrun` to reference `/bin/bash` or whatever instead of
`/bin/sh`.

Historical note: findnrun versions before 3.0.0 only worked with ash and bash.

