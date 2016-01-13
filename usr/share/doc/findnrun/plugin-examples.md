## More source plugin examples

Each example builds over the previous ones, so please add all previous
declarations in order to make the next example work. Recall the
[Find file](plugin.md) example.

### Find file revisited

Let's tweak 'Find file' to avoid the overhead of calling an external
script. Let's also start findnrun directly into `find_file`'s view.
Edit `~/.findnrun` and add:
```
    TITLE_find_file2='find file no script'
    TAP_find_file2='find $HOME -type f -name "*${term}*" | findnrun-formatter -- -O s -I "${ICON}"'
    SOURCE_find_file2='find_file2:filer_select:find_file:find_file2'
    SOURCES='find_file2 find_file FNRstart'
```

### Find file advanced

A more powerful file search method might involve case insensitive
regular expression matching.
```
    TITLE_iregex='Find file with regular expressions'
    TAP_iregex='find $HOME -iregex ".*${term}" | findnrun-formatter -- -O s -I "${ICON}"'
    SOURCE_iregex='iregex:filer_select:find_file:iregex'
    SOURCES='iregex find_file FNRstart'
```

tap-command prepends `.*` to `${term}`
Since find option -iregex matches _on the whole path_, we start
the search expression with `.*` otherwise find -iregex would never
match. Note also that in order to match in the middle of a file name you
need to explicitly append `.*` to the search input field value.

### Initializing the search input field

When a plugin is activated - by starting findnrun or by pressing F3
or Ctrl+_i_ - the search input field is initialized with the value of
`<init-search>`. Let's apply this to the _Find file advanced_ example.
```
    TITLE_iregexinit='Find file with regex and init search'
    INITSEARCH_regexPNG='\.png'
    SOURCE_iregexPNG='iregex:filer_select:find_file:iregexinit:regexPNG'
    SOURCES='iregexPNG iregex find_file FNRstart'
```

You will notice that the insert cursor is placed in column 1, at
the beginning of the input text. This isn't ideal but it is the way
gtkdialog works. Get in the habit of pressing the End key if you want to
continue entering text after the initialization value.

If you want to initialize the search input field for any of the built-in
sources, simply add the appropriate line to `~/.findnrun`. For instance,
for the default source use:
```
    INITSEARCH_FNRstart='audio'
```

### Multi-field tap

So far we have only seen examples of source taps that output a single
column, the tap-data column, for each record. Of course you could want
to implement a tap that outputs multi-field records, perhaps to show
a different icon for each record or label text that differs from its
tap-data value. This is possible and there is a fully worked-out example
to study. Since it's a more substantial example, it isn't included in
this document.

The multi-field plugin code and documentation consists of a single file
[/usr/share/doc/findnrun/examples/multi-field-tap.sh](examples/multi-field-tap.sh).

### Filmstrip viewer

The filmstrip source plugin demonstrates several advanced features of
the plugin interface:

  * paginating search results
  * remote interface calls
  * an independent GUI

The filmstrip viewer is a full example of an independent GUI that syncs
with findnrun keyboard events. On the practical side, it is also an
application that can be used to search through a collection of pictures
by filename and embedded image caption/comments.  Extending search to
other metadata contents (EXIF and IPCT tags, etc.), such as camera
settings, geotags and so on, should be relatively simple - given some
knowledge of shell scripting and of the exiftool command-line utility.

The filmstrip plugin/application consists of several files located in
`/usr/share/doc/findnrun/examples/filmstrip/`.
[Plugin README](examples/filmstrip/README.md) file.

