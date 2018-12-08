_Next: [Hotkeys](hotkey.md)_

## Configuring Preferences

The user preferences file is created as `$HOME/.findnrunrc` on first run.

Users can specify an alternative preferences file from the shell command
line:

    env CONFIG="/my/findnrun/conf" /usr/bin/findnrun

### GUI Preferences

These values can be set also from the main window:
```gettext
    # Keep the main window open after activating an item.
    defOPEN=false
    # Show and cache all application icons.
    varICONS=false
    # Return keyboard focus to the search input field.
    varFOCUSSEARCH=true
```

These values can be set also from the main menu:
```gettext
    # Search approximated words tolerating some mispelling and missing parts.
    # Fuzzy search ignores the following settings because it substitutes them
    # in other ways: CASEDEPENDENT, SEARCHFROMLEFT.
    SEARCHFUZZY=false
```

```gettext
    # Search pattern is a POSIX Basic regular expression.
    # Applied also to comment search and category search.
    SEARCHREGEX=false
```

```gettext
    # Extend search subject to .desktop file names.
    SEARCHFILENAMES=false
```

```gettext
    # Extend search subject to application comments.
    SEARCHCOMMENTS=false
```

```gettext
    # Extend search subject to application categories.
    # Show category labels in the comment field.
    # Set 'hidden' to hide category labels in the comment field.
    # In search input field prepend ';' to search for category only, i.e., ';office'.
    SEARCHCATEGORIES=false
```

```gettext
    # Enforce case-dependent searching.
    CASEDEPENDENT=false
```

```gettext
    # Search pattern must match from the leftmost position.
    # Ignored for category search.
    SEARCHFROMLEFT=false
```

```gettext
    # Ignore the NoDisplay=true attribute value of .desktop files.
    SHOWNODISPLAY=false
```
 
### Notes

`SHOWNODISPLAY`: Versions up to 1.10.6 didn't have this setting and showed all
files by default.

`SEARCHFILENAMES` `SEARCHCOMMENTS` `SEARCHCATEGORIES`: If all three are
enabled, the fields are searched at the same time (faster). If only some are
enabled, the fields are searched separately, and the search stops at the first
matching field from the left in the order application name, filename, comment,
category.

### Hidden Preferences

These values aren't available from the main window. They are intended mostly for
power users and custom applications:
```gettext
    # Hotkey format: accel-mods':'key-sym':'accel-key
    # cf. https://github.com/01micko/gtkdialog/blob/wiki/menuitem.md
    # Pressing HOTKEY_F2 cycles keyboard input focus between the history field and the search input field.
    HOTKEY_F2=0:F2:0xffbf
    # Pressing HOTKEY_F3 starts the next available source plugin.
    HOTKEY_F3=0:F3:0xffc0
    # Pressing HOTKEY_F4 saves+filters search results
    HOTKEY_F4=0:F4:0xffc1
    # Pressing HOTKEY_F5 runs the top/selected search result item in a terminal
    HOTKEY_F5=0:F5:0xffc2
    # Pressing HOTKEY_F12 activates the top search result list item.
    HOTKEY_F12=0:F12:0xffc9
    # Icon cache location.
    ICONCACHE=${HOME}/.icons
```

```gettext
    # This value affects the relative importance of matching the application
    # name versus matching other details (filenames, comments, categories).
    # Increasing this value makes the application name match more important so the
    # name is found with fewer keystrokes. This setting applies to fuzzy search
    # with **all** details enabled only.
    FUZZY_MATCH_BONUS_FOR_APP_NAME=20
```

```gettext
    # Main window geometry, no default.
    # Command-line option --geometry=WxH+X+Y overrides this value.
    #GEOMETRY=460x280+100+200
    # Desktop file search directories, colon-separated list from system settings.
    # Recursively search folders and sub-folders.
    #DESKTOP_FILE_DIRS="$HOME/.local/share/applications:/usr/share/applications:+
    #  + /usr/local/share/applications"
    # Icon search directories, colon-separated list from system default settings.
    #ICON_DIRS="$HOME/.icons:$HOME/.local/icons:/usr/share/icons:+
    #  + /usr/local/share/icons:/usr/share/pixmaps:+
    #  + /usr/share/midi-icons:/usr/share/mini-icons"
    # GTK2 icon-theme-name value initialized from ~/.gtkrc-2.0 (or in included file).
    # Icons found in the icon theme directory take precedence over other icons.
    # You may change this settings to experience another installed icon theme.
    #GTK_ICON_THEME_NAME="/path/to/icon-theme-directory" # optional
    # Preferred help viewing program (obsolete since version 2.0.0).
    #BROWSER=
```

```gettext
    # Change the output destination to which hotkey F4 saves search results.
    # Default value: '@timestamp'.
    # Use '@timestamp' for a timestamped, tab-separated-value (.tsv) file in your home folder.
    # Use 'none' to disable saving search results.
    # Use '>/path/to/filename' to save to filename. /path/to must exist.
    # Command pipelines are supported, too, i.e.,
    #   RDR="|cut -f1,2 |tee /dev/stderr" # label & .desktop full path to stderr
    #   RDR="|xclip" # all columns to the clipboard
    # Changing RDR affects the destination of all sources.
    # To changes single sources read plugin-dev.md.
    # Built-in sources honor RDR. Some external plugins may not.
    #RDR=@timestamp
```

```gettext
    # Entering IBOL+IBOL makes the search input field ignore all characters to the left of IBOL+IBOL included. 
    # This is a reserved setting; do not edit it. If you accidentally do, delete the line and restart findnrun.
    IBOL=' '
```

### See Also

 * _Environment Variables_ in [Starting Findnrun](running.md).

_Next: [Hotkeys](hotkey.md)_
