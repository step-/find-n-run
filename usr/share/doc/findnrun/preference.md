_Next: [Hotkeys](hotkey.md)_

## Configuring Preferences

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
    # Pressing HOTKEY_F2 cycles keyboard input focus between the history field and the search input field.
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

_Next: [Hotkeys](hotkey.md)_
