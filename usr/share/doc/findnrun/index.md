# find-n-run

Simple and quick application finder for Linux.

[About](https://github.com/step-/find-n-run) | [Downloads](https://github.com/step-/find-n-run/releases) | [Translations](https://github.com/step-/find-n-run/releases)

## News

 * **2015-12-08** [Find-n-run 1.10.7 beta 2 - now with plugins](https://github.com/step-/find-n-run/tree/source-plugins)
 * [Project home](http://github.com/step-/find-n-run)
 * As of version 1.10.5 this script is featured in the _original_
[Find'N'Run](http://www.murga-linux.com/puppy/viewtopic.php?t=98330)
 * Version 1.10.6 runs on Lubuntu: [package information](DEBIAN.md)

## Introduction

Puppy Linux users SFR and L18L created the _original_ Find'N'Run, an
application starter script that displays system applications in a
graphical window with a find-as-you-type search field to refine the
hit list.

This project takes the shell script further, by increasing search speed
and ease, adding many new features, a help system and translations.

This version does not include the additional ROX-Filer application,
which is still included in the _original_ version.

Unlike the _original_ script, this version uses GNU awk (gawk) for
core operations.

find-n-run is being developed and tested on
[Fatdog64](http://distro.ibiblio.org/fatdog/web/)-701 64-bit Linux, a
[Puppy Linux](http://puppylinux.com/) and
[LFS](http://www.linuxfromscratch.org/) derivative.

### Naming

 - _find-n-run_ refers to this new project and its repository.
 - _Find'N'Run_ refers to the _original_ project. For historical reasons both projects also used it as the window title.
 - `findnrun` is the script name; the same _name_ for both projects - but of course the script contents differ.

## Overview

Main features:

 * **Fast searching** and starting system applications (find as you type).
   Search by application **name**, **command line**, **comments**, and
   **categories**, or all at once. Search **from left**, with **regular
   expressions**, with **case-dependence** (lower-case).
 * **Application icon** column. [1]
 * **Command line entry** with command history.
   A combobox widget
   tracks the command associated with the currently selected `.desktop`
   item. Pressing up-arrow/down-arrow moves back/forward in the history
   of previously executed commands. [2]
 * **Keyboard focus** control.
   After starting an application focus can be returned to
   either the search input field or to the selected application list item.
 * **Geometry** support to exactly size and position the main window.
 * **Browsable help documentation** (HTML and markdown).
 * **Extensive tooltips**, and configurable **user preferences**.
 * **Multiple users** can use find-n-run at the same time. [3]
 * **Multi-language** support includes program and help documentation.

**Notes**

[1] It can happen that some icons unexpectedly look empty.
   Enable option _"Show all icons"_ in the main window to fix the look.

[2] Due to limitations of the `gtkdialog` comboboxentry widget, the
   combobox is normally blank until it is focused **and** up-arrow has
   been pressed at least once. The first key press displays the
   command associated with the current entry.

[3] If you are running in a multi-user environment, be aware that
   find-n-run's temporary files are readable by everyone by default.
   Use command-line option `--perm=` to tighten permissions.

## Screenshots

Version 1.10.6 (default window size)

![main window](images/findnrun-pub-main.png)

![about dialog](images/findnrun-pub-about.png)

## Installing

It is recommended to install the latest full package for your distribution,
which is split into multiple sub-packages:

 * The _base_ package includes the main script, its `.desktop` file, and an
   English help file (markdown)
 * The optional _NLS_ package adds runtime translations in several languages
 * The optional _doc_ package adds HTML English documentation (possibly
   also translated in other languages).

If you prefer a barebone, manual installation you can just copy
the script file `usr/bin/findnrun` from
[Github](http://github.com/step-/find-n-run) to your system.

In all cases, your system needs to satisfy the following
[pre-requisites](DEBIAN.md):
ash, gawk, gtk-dialog.

### Packages

Packages for various distributions can be downloaded from:

(1) the latest release announcement in the [releases page](http://github.com/step-/find-n-run/releases/) on Github:

 * Fatdog64 [.txz](http://github.com/step-/find-n-run/releases/)
 * Puppy Linux [.pet](http://github.com/step-/find-n-run/releases/)
 * Debian (Lubuntu) [.deb](http://github.com/step-/find-n-run/releases/)

(2) one of these known threads:

 * Puppy Linux full [.pet](http://www.murga-linux.com/puppy/viewtopic.php?t=98330), which also features a ROX-app application
 * Quirky Linux [.pet](http://www.murga-linux.com/puppy/viewtopic.php?t=99789)

### Manual installation

For a minimal installation, download the latest `.zip` or `.tar.gz` archive from
the [releases](http://github.com/step-/find-n-run/releases/) page on Github:

 * Non-Puppy Linux OS: ensure all [pre-requisites](DEBIAN.md) are met
 * Extract file `usr/bin/findnrun` and copy it to `/usr/bin/findnrun`
 * Set file ownership to root and executable file permissions

**Puppy Linux OS:**
You can replace directly the `findnrun` script bundled with
Fatdog64, and the script
included in the `.pet` package for all other Puppies. For older `.pet` versions
simply replace the existing file `/usr/local/apps/FindNRun/findnrun` with
file `usr/bin/findnrun` from the downloaded archive.

## Help system

You can view this file directly from `findnrun` by pressing key [F1] in the
main window, or by clicking the help button in the About dialog window.
If nothing happens when pressing [F1] or if the button is missing, most
likely the help file isn't installed. If you are sure that the help file
is installed, try setting environment variable `BROWSER` as explained
further down.

## User Preferences

The user preferences file is created as `~/.findnrunrc` on first run.

Users can specify an alternative preferences file from the shell command line:

    env CONFIG="/my/findnrun/conf" /usr/bin/findnrun

### Gui Preferences

These values can be set also from the main window:

    # Keep the main window open after starting an item.
    defOPEN=false
    # Show and cache all application icons.
    varICONS=false
    # Return keyboard focus to the search input field.
    varFOCUSSEARCH=true

### Hidden Preferences

These values are hidden in the main window. They are intended mostly for power users and custom applications:

    # Icon cache location.
    ICONCACHE=${HOME}/.icons
    # By default findnrun searches in application names only.
    # Extend search to application comments (OR).
    SEARCHCOMMENTS=false
    # Extend search to application categories (OR).
    # When true categories are shown in the comment field.
    # Prepend ';' to search for category only, i.e., ';office'.
    SEARCHCATEGORIES=false
    # Search in names, command lines, comments and categories all at once.
    # When true (recommended) findnrun finds more and is slightly faster.
    SEARCHCOMPLETE=false
    # Search pattern must match from the leftmost character.
    # Ignored for category search.
    SEARCHFROMLEFT=false
    # Search pattern is a POSIX Basic regular expression.
    # Applied also to comment search and category search.
    SEARCHREGEX=false
    # Enforce case-dependent searching.
    CASEDEPENDENT=false
    # Main window geometry, no default.
    # Command-line option --geometry=WxH+X+Y overrides this value.
    #GEOMETRY=460x280+100+200
    # Desktop file search directories, space-separated list, system default.
    #DESKTOP_FILE_DIRS=~/.local/applications /usr/share/applications /usr/local/share/applications
    # Icon search directories, space-separated list, system default.
    #ICON_DIRS=~/.icons ~/.local/іcons /usr/share/icons /usr/local/share/icons /usr/share/pixmaps /usr/share/midi-icons /usr/share/mini-icons
    # Preferred help viewing program.
    #BROWSER=
    # Pressing HOTKEY_F2 cycles keyboard input focus between the command entry field and the search field.
    HOTKEY_F2=F2
    # Entering IBOL+IBOL makes the search input field ignore all characters to the left of IBOL+IBOL included.
    # This is a reserved setting; do not edit it. If you accidentally do, delete the line and restart findnrun.
    IBOL=" "

## Command-line options

`--geometry=WxH+X+Y`

  Set window Width`x`Heigth and top-left corner position.
  You may omit `WxH` or `+X+Y`.

`--perm=PERMISSIONS`

  Set PERMISSIONS of the _program temporary directory_ (per `chown` command).
  By default the temporary directory is created readable by everyone (755),
  which on multi-user systems can be a security concern:

    findnrun --perm=700 # Now only the owner can read it / write it.

`--stdout`

  Display gtkdialog's standard output, which would otherwise not be shown.
  This option is mostly of interest to developers and advanced users.

`--`

  If you need to pass advanced options to gtkdialog, like perhaps
  which X display to use, you need to pass them on the command-line
  after a `--` stop marker. Anything following `--` will be passed
  to gtkdialog without further inspection. Be vary that some options
  you pass could conflict with the way `findnrun` sets up gtkdialog
  for use. Be also aware that in some cases you might also need to
  specify option `--stdout`:

    findnrun --geometry= -- --center
    findnrun -- --display=DISPLAY
    findnrun --stdout -- --version

## Environment variables

**Standard variables**

Many Linux versions pre-define some of these variables in system
initialization files.

`BROWSER`

  If the **Help file** is installed but it does not open - or it opens
  in a text editor - try setting `BROWSER` to your preferred web
  browser.  `BROWSER` can be set either as an environment variable or as
  a configuration preference.

    env BROWSER=firefox findnrun

`LANG`

  If a translation file for your local language is installed but you
  see English messages, you need to properly configure your system
  locale.  Find-n-run honors the system locale code that environment
  variable `LANG` displays.

    echo $LANG

**Non-standard variables**

`GEOMETRY`

  Window geometry can be set as an environment variable, as a
  configuration preference, and as a command-line option - in increasing
  order of precedence.

    env GEOMETRY=500x200+100+100 findnrun

## Known issues and limitations

 * Freedesktop.org's
   [icon theme](http://standards.freedesktop.org/icon-theme-spec)
   support isn't implemented. This means that if multiple
   icon themes are installed _findnrun_ will apply the first icon found
   in alphabetical order.
   You can work around this limitation by setting hidden user preference
   `ICON_DIRS`.

 * Prioritized language preferences via environment variable `LANGUAGE`
   are not supported. Find-n-run honors the system locale code that
   environment variable `LANG` displays - when a matching translation
   file is installed.

## Reporting bugs

Please file bugs against this script in the issues section of the
[github repository](https://github.com/step-/find-n-run/issues) _and not
in the Puppy Linux forum thread_. You do need a github free accont to
file new issues.

## Translations

If the system locale is correctly configured, `findnrun` should automatically
display entry _name_ and _comments_ in the local language provided that the
corresponding `.desktop` file includes translation strings.
Note that entry _categories_ are available in English only according to the
freedesktop.org's desktop file specifications
[ref1](http://standards.freedesktop.org/desktop-entry-spec/latest/ar01s04.html)
and
[ref2](http://standards.freedesktop.org/desktop-entry-spec/latest/ar01s05.html).

I will gladly add contributed translations to the git repository if
translators send them to me. Generate a Github pull request or attach your
contributed files to the above-mentioned forum thread.
See [TRANSLATING](TRANSLATING.md) for further instructions.

## Credits

[Artwork, translations](CREDITS.md)

## Change Log

See the project [release announcements](https://github.com/step-/find-n-run/releases) page and - for fine-grained information - the [commit history](https://github.com/step-/find-n-run/commits/master) page.

## License

[GNU GPL v2](LICENSE.md)

