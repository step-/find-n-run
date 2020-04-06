## More Source Plugin Examples

Each example builds over the previous ones, so please add all previous
declarations in order to make the next example work. Recall the
[Find file](plugin.md) example.

### Find File Example Revisited

Let's tweak 'Find file' to avoid the overhead of calling an external
script. Let's also start findnrun directly into `find_file`'s view.
Edit `~/.findnrun` and add:
```
    TITLE_find_file2='find file no script'
    TAP_find_file2='find $HOME -type f -name "*${term}*" | findnrun-formatter -- -O s'
    SOURCE_find_file2='find_file2:filer_select:find_file:find_file2'
    SOURCES='find_file2 find_file FNRstart'
```

### Find File Advanced

A more powerful file search method might involve case insensitive
regular expression matching.
```
    TITLE_iregex='Find file with regular expressions'
    TAP_iregex='find $HOME -iregex ".*${term}" | findnrun-formatter -- -O s'
    SOURCE_iregex='iregex:filer_select:find_file:iregex'
    SOURCES='iregex find_file FNRstart'
```

The tap-command prepends `.*` to `${term}`.  Since find option -iregex
matches _on the whole path_, we start the search expression with `.*`
otherwise find -iregex would never match. Note also that in order to
match in the middle of a file name you need to explicitly append `.*` to
the search input field value.

### Initializing the Search Input Field

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

### SFS Lister

The following definitions implement an SFS file lister/loader. It assumes
that script `s-sfs` can list all known SFS files (`s-sfs -l`) and load/unload
them. The definitions make use of helper functions.
```
    # search my sfs files
    SOURCE_sfs='sfs:sfs:sfs:sfs:sfs:sfs:sfs:sfs:sfs:'
    ICON_sfs=/usr/share/pixmaps/themes/puppy48/squashfs-image48.png
    INIT_sfs='FNRset_TMPD_DATF; s-sfs -l > "$DATF"; echo >"$TMPD"/go-drain "yad --text=\"\$*\" --button=gtk-go-up:0 --button=gtk-go-down:1 --button=gtk-cancel:2 --window-icon="'"$ICON_sfs"'"; case \$? in 0) s-sfs load \"\$*\";; 1) s-sfs unload \"\$*\";; esac"'
    TAP_sfs='FNRset_TMPD_DATF; FNRsearch | findnrun-formatter -- -O s'
    # Note that DRAIN can only be a simple shell command. Cf. Caveat in plugin-dev.md "Plugin Invocation"
    # So we replace $TMPD with its definition taken from FNRset_TMPD_DATF.
    DRAIN_sfs='sh "$FNRTMP/.$ID/go-drain"'
    TITLE_sfs='s-sfs'
    INITSEARCH_sfs=
    MODE_sfs=
    PLGDIR_sfs=
    SAVEFLT_sfs=
    
    SOURCES="FNRstart FNRsc sfs"
```

### Multi-Field Tap

So far we have only seen examples of source taps that output a single
column, the tap-data column, for each record. Of course you could want
to implement a tap that outputs multi-field records, perhaps to show
a different icon for each record or label text that differs from its
tap-data value. This is possible and there is a fully worked-out example
to study. Since it's a more substantial example, it isn't included in
this document.

The multi-field plugin code and documentation consists of a single file
[/usr/share/findnrun/doc/examples/multi-field-tap.sh](examples/multi-field-tap.sh).

### Filmstrip Viewer

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
`/usr/share/findnrun/doc/examples/filmstrip/`.
Plugin [help file](examples/filmstrip/index.md).

