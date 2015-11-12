## Plugins

### Source Plugins

A source plugin comprises a _tap_ and, optionally, its _drain_ and its _default icon filename_. The tap outputs the data records that populate the list widget. The drain consumes the selected record when the user presses ENTER or double-clicks the list view selection. Tap-records consist of fields separated by the pipe character '|':
````
    <icon-filename> '|' <label> '|' <tap-data> '|' <comment> '|' <categories>
````

All fields yield string values, all characters allowed (caveat) except the pipe character. There is no way to include a literal pipe character in a value.  All values can be null except for `<tap-data>`.

 * `<icon-filename>` is the filename only part (no path and no extension) of a suitable image file. Place the file in the `$ICONCACHE` path (default path `~/.icons`, set in `.findnrunrc`). If the value of icon-filename starts with "findnrun-" the file is automatically deleted when findnrun terminates. If you want for an icon file to survive findnrun's termination, do not start its filename by "findnrun-". If the icon-filename value is null findnrun uses the sources's default icon-filename. Examples of valid icon-filename values: `findnrun-my_icon_used_and_removed`, where its complete default path is `~/.icons/findnrun-my_icon_used_and_removed.png`; `this_icon_survives`, with default path `~/.icons/this_icon_survives.svg`.

 * `<label>` is displayed in the list widget. If the label value is null findnrun uses tap-data instead.

 * `<tap-data>` is displayed in the command entry widget. Tap-data is sent to the drain upon activating its entry in the list view.

 * `<comment>` is displayed in the comment widget.

 * `<categories>` is a semicolon-separated list of words and can be displayed in the comment widget.

**Examples of well-formed records**

    american_icon|born to run|mplayer /root/bruce.mp3|the boss|multimedia;audio
    |command line|xterm -e sh||system
    ||chrome
    firefox

The last example is the minimum data a well-formed record must include. Accordingly, findnrun's list view shows a predefined icon, label "firefox" and tap-data "firefox". Similarly, for record `||chrome` the list view shows a predefined icon, title "chrome" and tap-data "chrome". To show an empty icon, set the filename of an empty image. To show an empty label set a space character (" ").

**Installing source plugins**

In the following discussion:
 * An `<...-id>` is a valid sh variable name: only letters, digits, and underscore characters are allowed.
 * Characters outside of angle brackets are to be written literally.

A source plugin is installed by adding its declaration into `.findnrunrc` as follows:
```
    SOURCE_<source-id>='<tap-id>:<drain-id>:<icon-id>:<title-id>'
    TAP_<tap-id>='<tap-command>'
    DRAIN_<drain-id>='<drain-command>'    # optional
    ICON_<icon-id>='<icon-filename>'      # optional
    TITLE_<title-id>='<source-title>'     # optional
```
 * Each `<...-id>` identifier must be unique within its declaration group (SOURCE\_, TAP\_, DRAIN\_, ICON\_, TITLE\_).
 * `<tap-command>` is a valid sh command (more on this further down).
 * `<drain-command>` is also a valid sh command.
 * `<icon-filename>` is defined as the tap-record `<icon-filename>`.
 * `<source-title>` is displayed in the user interface.
 * Declarations marked "optional" can be omitted by leaving their respective `<...-id>` slot empty in their `SOURCE_<source-id>` declaration.
 * Paired exterior double quotes work just as well as single quotes, but require escaping interior sh special characters.

You can use any valid sh variable name as an `<...-id>`, but prefix "FNR" is reserved for findnrun's own plugins.
Examples of valid `<id>`s: drain27, acme\_1.
Examples of invalid `<id>`s: my-plugin (sh identifiers can't include "-"), FNR\_plugin (prefix "FNR" is reserved), 100 (numbers aren't valid sh variable names).

To enable a plugin edit `~/.findnrunrc` and add its `<source-id>` to the space-separated list `SOURCES`. The user interface shows enabled plugins in the order they appear in `SOURCES`.
```
    SOURCES='... <source-id> ...'    # list of all enabled sources
```

**Tap and drain command implementation**

A command is implemented as a sh command, script, or external program, something that the shell can execute.

**Source plugin command invocation**

Findnrun invokes two plugin commands. While the user is typing into the search innput field, findnrun invokes the tap-command as follows:
```
    eval <tap-command>
```

The tap-command can use the current value of the search input field by including the string `${term}` in `<tap-command>`.
On each plugin invocation the tap may output zero or more formatted tap-records.

When the user selects and activates an entry in the list view, findnrun invokes the drain-command as follows:
```
    eval <drain-command> <tap-data>
```

Just before starting the command findnrun saves the whole line, without "eval ", into the history list pull-down widget.[1]
If the drain-command value is null findnrun starts `<tap-data>` with the sh builtin command `eval`.

The invocation environment provides tap-command and drain-command with the following preset variables:

 * `${SOURCE}`, `${TAP}`, `${DRAIN}`, `${TITLE}` and `${ICON}`, the source's declared values
 * `${ID}`, the source-id
 * `${NSOURCES}, the number of sources.

[1] Findnrun also saves two history files: the global history file and the plugin's history file. Currently they are not exposed in the user interface, and the pull-down widget shows the global history. This might change in the future.

**Source plugin user interface**

By default, when findnrun starts and no source plugins are installed, it displays the list of desktop (file) applications, which is connected to the builtin source `ID` "FNRstart". Effectively, the default source installation is:
```
    SOURCES='FNRstart'
```

Since version 1.7 a shell-completion plugin is bundled, so the amended default source installation is:
```
    SOURCES='FNRstart FNRsc'
```

On program start findnrun displays the tap-records of the first element of SOURCES. So declaring `SOURCES='FNRsc FNRstart'` would display the shell-completion plugin on program start. Declaring `SOURCES='FNRsc'` would disable the builtin FNRstart source. `SOURCES=MySourceOnly` would be a dedicated "MySourceOnly" application for a suitable MySourceOnly plugin.

When `SOURCES` includes multiple elements, a status bar appears at the bottom of the main window. The status bar includes the current source's source-title. If the source-title value is null, findnrun displays the plugin's source-id value instead. Pressing F3 cycles the list view through the sources. Pressing Ctrl+_i_, for _i_=1,2,..,9 displays the _i_-th source directly.

The first column of the list view displays the tap-record icon-filename. If the icon-filename value is null, findnrun displays the source default icon set by `ICON_<icon-id>`. If also the default icon is null findnrun displays an empty cell.

There is no provision for a plugin to display a user interface of its own. Nor is there a system to signal a plugin important events.

A word of caution: gtkdialog can't display streaming data. A tap-command must close its output stream for gtkdialog to populate the list view.

**Plugin internationalization**

Source-titles are looked up for [translations](TRANSLATING.md) using GNU Gettext in text domain "findnrun-plugin-PLUGIN-ID", where PLUGIN-ID stands for the `<source-id>` value.

**Formatter**

At the moment, all non-builtin source tap-commands are required to end with `| findnrun-formatter --`. This constraint might be removed in the future. So the typical tap-command stanza is:
```
    <command> | findnrun-formatter -- <formatter-options>
```

If tap-command outputs single records, that is, the records don't include "|" (pipe), then do include `-O s` in findnrun-formatter's options. "-O s" tells the formatter not to decode each tap-record in detail.  If the source default icon is non-null, include `-I "${ICON}"`.

Run `findnrun-formatter -- -h` for usage information. Note again those two dashes in the formatter command line: they are required because the formatter is a gawk script.

### Source plugin examples

Each example builds over the previous ones, so please add all previous declarations in order to make the next example work.

**Find file**

Save the following script in file `/fnr-find-file.sh`
```
    #!/bin/sh
    find $HOME -type f -name "*$1*" | findnrun-formatter -- -O s -I "${ICON}"
```

Edit `~/.findnrun` and add:
```
    TITLE_find_file='open ROX-Filer with file selected'
    TAP_find_file='export ICON; /fnr-find-file.sh "${term}"'
    DRAIN_rox='rox -s'
    ICON_find_file='find-file.png'
    # tap:drain:default_icon:title
    SOURCE_find_file='find_file:rox:find_file:find_file'
    SOURCES='FNRstart find_file'
```
Don't forget to make your script executable and add the declared default icon:
```
    chmod +x /fnr-find-file.sh
    cp -v /usr/share/icons/hicolor/32x32/apps/findnrun.png $HOME/.icons/find-file
```

Now every time `find_file` is selected in the user interface and the user types a character in the search field, `/fnr-find-file.sh` lists file names that partially match the search term and are located inside and below the user's `$HOME` folder. If the user selects and activates an entry, ROX-Filer is started with the given file selected (but how clearly marked the selection will depend on your ROX-Filer version).

**Find file revisited**

Let's tweak the previous example to avoid the overhead of calling an external script. Let's also start findnrun directly into `find_file`'s view. Edit `~/.findnrun` and add:
```
    TITLE_find_file2='find file no script'
    TAP_find_file2='find $HOME -type f -name "*${term}*" | findnrun-formatter -- -O s -I "${ICON}"'
    SOURCE_find_file2='find_file2:rox:find_file:find_file2'
    SOURCES='find_file2 find_file FNRstart'
```

**Find file advanced**

A more powerful file search method might involve case insensitive regular expression matching.
```
    TITLE_iregex='Find file with regular expressions'
    TAP_iregex='find $HOME -iregex ".*${term}" | findnrun-formatter -- -O s -I "${ICON}"'
    SOURCE_iregex='iregex:rox:find_file:iregex'
    SOURCES='iregex find_file FNRstart'
```

tap-command prepends `.*` to `${term}` because find -iregex matches on the whole path. Without `.*` the expression would never match.

### Plugin performance

Please note that the active source plugin's tap-command is invoked on every keypress. So it's very important for tap-commands to return as quickly as possible otherwise they could slow down the user interface to a crawl.

TODO add sh time hooks.

### Debugging plugins

Your plugin can print debugging messages to the standard error stream. Do not write to the standard output stream, which is reserved for tap-records.

Findnrun validates source plugin declarations in various ways. On fatal errors findnrun prints the offending subject's id, when it is known, to the standard error strem, and exits with an error exit status. On recoverable errors, findnrun prints the offending source's id and a warning code to the standard error stream, disables the source, and continues. On warnings findnrun prints a warning code to the standard error stream and continues.
```
FATAL ERROR EXIT CODES
TODO

RECOVERABLE ERROR CODES
TODO

WARNING CODES
TODO
```

To run findnrun in debugging mode use: `DEBUG=<level> findnrun`. Levels 1-9 enable increasingly verbose debugging messages to the standard error stream. Level 10 dumps the gtkdialog definition to the standard output stream and exits.

### Known "official" plugins**

While there is no centralized registration service/authority for plugin IDs, if you send me the ID of your plugin I will publish it in findnrun's github page, so other developers will be able to see it.
```
    # Your plugin here...
```

