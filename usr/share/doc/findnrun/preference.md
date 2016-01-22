## User Preferences

The user preferences file is created as `~/.findnrunrc` on first run.

Users can specify an alternative preferences file from the shell command
line:

    env CONFIG="/my/findnrun/conf" /usr/bin/findnrun

### GUI Preferences

These values can be set also from the main window:

    # Keep the main window open after starting an item.
    defOPEN=false
    # Show and cache all application icons.
    varICONS=false
    # Return keyboard focus to the search input field.
    varFOCUSSEARCH=true

### Hidden Preferences

These values are hidden in the main window. They are intended mostly for
power users and custom applications:

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
    # Pressing HOTKEY_F3 starts the next available source plugin.
    HOTKEY_F3=F3
    # Pressing HOTKEY_F12 activates the top search result list item.
    HOTKEY_F12=F12
    # Entering IBOL+IBOL makes the search input field ignore all characters to the left of IBOL+IBOL included.
    # This is a reserved setting; do not edit it. If you accidentally do, delete the line and restart findnrun.
    IBOL=" "
    # Ignore the NoDisplay=true attribute value of .desktop files (not recommended).
    # Note: Versions up to 1.10.6 didn't have this setting and showed all files by default.
    SHOWNODISPLAY=false

## Command-Line Options

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

## Environment Variables

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

## Language Settings

If the system locale is correctly configured, and findnrun's optional
NLS support package is installed, and it includes translations for the
local language, `findnrun` should automatically display its messages in
the local `language.

The search result list should also display an item _name_ and _comments_
in the local language provided that the corresponding `.desktop` file
includes translations.  Note that item _categories_ are available
in English only - according to the freedesktop.org's desktop file
specifications
[ref1](http://standards.freedesktop.org/desktop-entry-spec/latest/ar01s04.html)
and
[ref2](http://standards.freedesktop.org/desktop-entry-spec/latest/ar01s05.html).

Some plugins may require you to install a separate NLS support package
before they can display translated messages.

