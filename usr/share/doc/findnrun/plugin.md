## Plugins

Before giving the theory, let's start with a complete example.

### The Find File example

You want to add a new source that lists the files in your home folder. Selecting one of the files in the search result list should open the filer - ROX-Filer in our case - in the folder that contains the file, and with the file selected.

We will be implementing a so called tap/drain pair: the tap outputs search results, the drain starts the filer. Here's how.

Save the following script in your home folder `${HOME}/fnr-find-file.sh`
```
    #!/bin/sh
    find $HOME -type f -name "*$1*" | findnrun-formatter -- -O s -I "${ICON}"
```

Edit file `${HOME}/.findnrun` and add:
```
    TITLE_find_file='open ROX-Filer with file selected'
    TAP_find_file='export ICON; "${HOME}/fnr-find-file.sh" "${term}"'
    DRAIN_filer_select='rox -s'
    ICON_find_file='find-file.png'
    # tap:drain:default_icon:title
    SOURCE_find_file='find_file:filer_select:find_file:find_file'
    SOURCES='FNRstart find_file'
```

Make your script executable and add the declared default icon:
```
    chmod +x ${HOME}/fnr-find-file.sh
    cp -v /usr/share/icons/hicolor/32x32/apps/findnrun.png $HOME/.icons/find-file
```

Now every time you select the `find_file` source in the user interface and type a character in the search field, `/fnr-find-file.sh` starts and lists file names that partially match the search term and are located inside and below your home folder. When you activate an entry ROX-Filer starts with the given file selected - but how visibly selected depends on the ROX-Filer version.

Now the boring details.

### Source Plugins

A source plugin comprises a _tap_ and, optionally, its _drain_ and its _default icon filename_. The tap outputs the data records that populate the list widget. The drain consumes the selected record when the user presses ENTER or double-clicks the list view selection.

**Tap-record**

A tap-record consists of fields separated by the pipe character '|':
````
    <icon-filename> '|' <tap-reserved> '|' <label> '|' <tap-data> '|' <comment> '|' <categories>
````

All fields yield string values, all characters allowed (caveat) except the pipe character. There is no way to include a literal pipe character in a value.  All values can be null except for `<tap-data>`.

 * `<icon-filename>` is the filename only part (no path and no extension) of a suitable image file. Place the file in the `$ICONCACHE` path (default path `~/.icons`, set in `.findnrunrc`). If the value of icon-filename starts with "findnrun-" the file is automatically deleted when findnrun terminates. If you want for an icon file to survive findnrun's termination, do not start its filename by "findnrun-". If the icon-filename value is null findnrun uses the sources's default icon-filename. Examples of valid icon-filename values: `findnrun-my_icon_used_and_removed`, where its complete default path is `~/.icons/findnrun-my_icon_used_and_removed.png`; `this_icon_survives`, with default path `~/.icons/this_icon_survives.svg`.

 * `<tap-reserved>` is available for a plugin to associate special data to the tap-record record for custom activation. Currently this field isn't processed or further exposed in the plugin interface awaiting feedback from plugin developers.

 * `<label>` is displayed in the list widget. If the label value is null findnrun uses tap-data instead.

 * `<tap-data>` is displayed in the command entry widget. Tap-data is sent to the drain upon activating its entry in the list view.

 * `<comment>` is displayed in the comment widget.

 * `<categories>` is a semicolon-separated list of words and can be displayed in the comment widget.

**Examples of well-formed records**

    american_icon||born to run|mplayer /root/bruce.mp3|the boss|multimedia;audio
    |command line||xterm -e sh||system
    |||chrome
    firefox

The last example is the minimum data a well-formed record must include. Accordingly, findnrun's list view shows a predefined icon, label "firefox" and tap-data "firefox". Similarly, for record `|||chrome` the list view shows a predefined icon, title "chrome" and tap-data "chrome". To show an empty icon, set the filename of an empty image. To show an empty label set a space character (" ").

**Installing source plugins**

In the following discussion:

 * An `<...-id>` is a valid sh variable name: only letters, digits, and underscore characters are allowed.
 * Characters outside of angle brackets are to be written literally.

A source plugin is installed by adding its declaration into `.findnrunrc` as follows:
```
    SOURCE_<source-id>='<tap-id>:<drain-id>:<icon-id>:<title-id>:<init-search-id>'
    TAP_<tap-id>='<tap-command>'
    DRAIN_<drain-id>='<drain-command>'          # optional
    ICON_<icon-id>='<icon-filename>'            # optional
    TITLE_<title-id>='<source-title>'           # optional
    INITSEARCH_<init-search-id>='<init-search>' # optional
```

 * Each `<...-id>` identifier must be unique within its declaration group (SOURCE\_, TAP\_, DRAIN\_, ICON\_, TITLE\_, INITSEARCH\_).
 * `<tap-command>` is a valid sh command (more on this further down).
 * `<drain-command>` is also a valid sh command.
 * `<icon-filename>` is defined as the tap-record `<icon-filename>`.
 * `<source-title>` is displayed in the user interface.
 * `<init-search>` can be used to initialize the search input field.

 * Declarations marked "optional" can be omitted by leaving their respective `<...-id>` slot empty in the `SOURCE_<source-id>` declaration.
 * Embedded newline or carriage return characters are not allowed in `<...-command>` values.
 * All values are quoted strings. Paired exterior double quotes work just as well as single quotes, but require escaping interior sh special characters.

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

 * `${SOURCE}`, `${TAP}`, `${DRAIN}`, `${TITLE}`, `${ICON}` and `${INITSEARCH}` - the source's declared values
 * `${ID}` - the source-id
 * `${NSOURCES} - the number of sources
 * `${FNRPID}` - findnrun's gtkdialog process id[2]
 * `${FNRTMP}` - findnrun temporary folder id[2][3]
 * `${FNRDEBUG}` - findnrun debugging level 1-9
 * `${FNREVENT}` - invocation event name[4].
 * `${FNRRPC}` - remote call mailbox file, see section _Remote call interface_.

[1] Findnrun also saves two history files: the global history file and the plugin's history file. Currently they are not exposed in the user interface, and the pull-down widget shows the global history. This might change in the future.

[2] These variables are provided in support of tasks such as naming files that need to persist across invocations of plugin commands; implementing a plugin as multiple independent programs that share data.

[3] Findnrun's own temporary folder persists across invocations of plugin commands. It is automatically deleted when findnrun terminates. It is recommended for a plugin to create a sub-folder within findnrun's own temporary folder, i.e.,
```
    TMPD="${FNRTMP:-/tmp}/${ID}-${0##*/}" && mkdir -p "${TMPD}" && chmod 700 "${TMPD}"
```

[4] Name of the event that led to the invocation of a tap or drain. Currently the following names are defined:
 * **Search** - Tap - Input entered in the search input field. When a tap is first invoked this event fires even without pressing an input key.
 * **PageUp** - Tap - PageDown key pressed when the search input field has the focus.
 * **PageDown** - Tap - PageUp key pressed when the search input field has the focus.
 * **Activate** - Drain - Enter key pressed or mouse left-clicked when a search result list item has the focus.

### Findnrun user interface and source plugins

By default, when findnrun starts and no source plugins are installed, it displays the list of desktop (file) applications, which is connected to the builtin source `ID` "FNRstart". Effectively, the default source installation is:
```
    SOURCES='FNRstart'
```

Since version 1.7 the "shell completion" plugin is bundled, so the amended default source installation is:
```
    SOURCES='FNRstart FNRsc'
```

On program start findnrun displays the tap-records of the first element of SOURCES. So declaring `SOURCES='FNRsc FNRstart'` would display the shell-completion plugin on program start. Declaring `SOURCES='FNRsc'` would disable the builtin FNRstart source. `SOURCES=MySourceOnly` would be a dedicated "MySourceOnly" application for a suitable MySourceOnly plugin.

When `SOURCES` includes multiple elements, a status bar appears at the bottom of the main window. The status bar includes the current source's source-title. If the source-title value is null, findnrun displays the plugin's source-id value instead. Pressing F3 cycles the list view through the sources. Pressing Ctrl+_i_, for _i_=1,2,..,9 displays the _i_-th source directly.

The first column of the list view displays the tap-record icon-filename. If the icon-filename value is null, findnrun displays the source default icon set by `ICON_<icon-id>`. If also the default icon is null findnrun displays an empty cell.

A word of caution: since gtkdialog can't display streaming data, a tap-command must close its output stream for gtkdialog to start populating the search list view.

**Paginating Search Results**

When a tap returns more items that can fit in the search result list widget, the user can paginate through the list. There are two cases, with the second case of greater relevance to plugin development.

First case: The search result list has the focus and the user presses the PageUp or PageDown key to paginate through the list. The list widget scrolls up and down the list accordingly. Nothing new here, it's the standard handling of Page keys for a list widget.

Second case: The seach _input_ field has the focus and the user presses the PageUp or PageDown keys. Findnrun invokes the tap with variable `$FNREVENT` set to the event name, either `PageUp` or `PageDown`. It is up to the source tap implementation to respond appropriately to the event:
 * Ignore the event name altogether and return its standard search output. This is what the default source `FNRstart` does.
 * Return a subset of its search results to represent a "page" of data. This is what the example source `filmstrip` does, see [More source plugin examples](plugin-examples.md). It's worth noting that the definition of a "page" is left entirely to the tap implementation. For example, `filmstrip` defines the page as the number of thumbnails, five, that fit in its viewer window, and pages the search result list up/down by five lines each time the PageDown/PageUp key is pressed.

### Remote call interface

Write function calls to the mailbox file `${FNRRPC}`.  A call consist of
a list of function names - each name is a single word - followed by a
serialization number. Findnrun executes recognized calls. For instance,
a remote process could ask findnrun to execute functions foo1 and foo2
in this way:
```
    date +"foo1 foo2 %s" > "${FNRRPC}"
```

The Linux date command interprets '+' as introducing a format string,
and replaces '%s' with the serialization number. So, for example
"foo1 foo2 1234567890" (any number) is written into the mailbox file.

Caveat: the order of execution of `foo1` and `foo2` is undefined
within the same call. Thus, findnrun could execute `foo1` before or
after `foo2`. If your plugin relies on a fixed order of execution send
separate calls.

Recognized calls:
 * `Exit` - exit findnrun (this function is always executed last)
 * `RaiseMainWindow` - raise findnrun's main window to top and give it the focus

### Findnrun termination and plugins

When findnrun terminates it deletes its temporary folder and all files/folder within, which become inaccessible to running plugins. Of course, also the plugins terminate. However, if a plugin spawned a running sub-process, i.e., a user interface module, such as a plugin's own gtkdialog, that sub-process will keep running. Findnrun does nothing to stop it.

There is a way to make findnrun terminate sub-processes automatically. Before exiting findnrun looks under its temporary folder for files named `.pidof_*` and gathers their contents, which must consist solely of process and process groups ids. Then findnrun sends a termination signal to those ids:
```
    /bin/kill -TERM -- ${ids}
```

So, if a plugin needs for its sub-process to be automatically terminated when findnrun exits it should save the sub-process id in a suitably-named `.pidof_*` file under findnrun's temporary folder.

### Plugin internationalization (i18n)

Source-titles are looked up for using GNU Gettext in text domain "findnrun-plugin-PLUGIN-ID", where _PLUGIN-ID_ stands for the `<source-id>` value.

As a minimum translators should add a translation for the plugin title defined with TITLE\_PLUGIN-ID=... in the plugin installed definition section of file `~/.findnrunrc`. Plugin developers must provide such installation information to translators. Further reading about [translations](TRANSLATING.md).

### Formatter

At the moment, all non-builtin source tap-commands are **required** to end with `| findnrun-formatter --` optionally followed by formatter options. This constraint might be removed in the future. So the typical tap-command stanza is:
```
    <command> | findnrun-formatter -- [ <formatter-options> ]
```

If tap-command outputs single records, that is, the records don't include "|" (pipe), then do include `-O s` formatter option. "-O s" tells the formatter not to decode each tap-record in detail.  If the source default icon is non-null, include `-I "${ICON}"`.

Run `findnrun-formatter -- -h` for usage information. Note again those two dashes in the formatter command line: they are required because the formatter is a gawk script.

### Plugin performance

Please note that the active source plugin's tap-command is invoked on every keypress. So it's very important for tap-commands to return as quickly as possible otherwise they could slow down the user interface to a crawl.

### See Also

* [More advanced plugin examples](plugin-examples.md)
* [Debugging plugins](plugin-debugging.md)
* [List of known "official" plugins](plugin-list.md)

