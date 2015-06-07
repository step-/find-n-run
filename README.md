# find-n-run

GNU awk fork of the original find-n-run utility for Puppy linux.

## Motivation

Puppy linux forum users SFR and L18L have developed Find-N-Run, a wonderful
little application starter that displays your `*.desktop` files in a
`gtkdialog` window with a progressive typing search field to narrow down the
list. It's all written in shell, optionally augmented with a ROX-Filer
application directory.

The version of Find-N-Run in this repo consists of the main shell script
only, which I have modified to use GNU `awk` instead of the likes of `grep`,
`sed`, `cut`, and `sort`. My main intent was to reduce the number
of processes that need to run when the search field is exercised.

## Overview

Switching to `awk` also allowed me to add considerable extra functionality:

 * Display an application icon for each `.desktop` file.
   Due to limitations of the `gtkdialog` tree widget, icons that are not
   located in `/usr/share/pixmaps` will not show in the dialog window.
 * Command line entry with command history. A combobox widget
   tracks the command associated with the currently selected `.desktop`
   item. Pressing up-arrow/down-arrow moves back/forward in the history
   of previously executed commands.
   Due to limitations of the `gtkdialog` comboboxentry widget, the
   combobox is normally blank until it's focused **and** up-arrow has
   been pressed at least once. The first key press displays the
   command associated with the current entry.

This version can replace directly the Find-N-Run script included with
Fatdog64-700, a 64-bit OS in the Puppy linux family, and the script
included in the `.pet` package for all other Puppies.

## Bugs

Please file bugs in the Issues section of the
[github repository](https://github.com/step-/find-n-run/issues).

## Screenshot

Side by side: Left: version 1.10-gawk -- Right: original version 1.9 (Fatdog64-701).

![side-by-side versions](findnrun-1.10-gawk.png)

