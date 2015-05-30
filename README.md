# find-n-run
GNU awk fork of the original find-n-run utility for puppy linux.

Puppy linux forum users SFR and L18L have developed Find-N-Run, a wonderful
little application starter that displays your `*.desktop` files in a
`gtkdialog` window with a progressive typing search field to narrow down the
list. It's all written in shell, optionally augmented with a ROX-Filer
application directory.

The version of Find-N-Run in this repo consists of just the main shell
script, which I modified to use GNU awk instead of the likes of `grep`,
`sed`, `cut`, and `sort`. My main intent was to reduce the number
of processes that need to run when the search field is exercised.
Awk allowed me to add a little bit of extra functionality, namely
displaying an application icon for each `.desktop` file. Unfortunately,
due to limitations of the `gtkdialog` tree widget, icons that aren't
located in `/usr/share/pixmaps` will not show in the dialog window.

Indeed the awk script parses more information than just the application
name and icon. All extra information is passed to the tree widget but
it is hidden. It gets used to compose the lauch command, and update
the dialog status line.

This version can replace directly the Find-N-Run included with Fatdog64-700,
a 64-bit OS in the Puppy linux family.

Here is a screenshot of the two versions -- gawk version on the left side.

![side-by-side versions](findnrun-1.9-gawk.png?raw=true "Find-N-Run gawk fork vs. original 1.9 version.")

