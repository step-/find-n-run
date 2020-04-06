## Filmstrip

Progressive image search

Filmstrip is a source plugin for Findnrun.
As you incrementally refine the search term in Findnrun's search window,
an image viewer displays thumbnails of the images that match your search
results. Matches are checked against image filename and caption.

### Requirements and Installation

 * Copy file [source-me.sh](source-me.sh) to your home folder
   - [alternative location](examples/filmstrip/source-me.sh).
 * Copy file [taprc](taprc) to your home folder as `~/.filmstriprc`
   - [alternative location](examples/filmstrip/taprc).
 * Edit file `~/.findnrunrc` and **APPEND** two lines; one line sources
   this file and another line adds the new plugin source to SOURCES:
```
    . "$HOME/source-me.sh"
    SOURCES='FNRstart filmstrip FNRsc' # <<< CHANGE IF NECESSARY
```

 * Start findnrun. Press 'F3' to activate the filmstrip viewer.
   You may press Ctrl+1 to return to the standard 'application finder'.

This plugin can be further configured by editing its configuration file
'[taprc](taprc)' - [alternative location](examples/filmstrip/taprc).

 * Do not edit 'taprc' directly. Copy it to file `.filmstriprc` in your
   home folder.
 * Review basic settings. All defaults have sensible values for most
   systems, but do check that `FIND_PATH` points to existing picture
   folder locations, and that `TYPING_RATE` is well-suited to your
   hardware (try the default value first).

For advanced features read section _Suggested Packages_.
To customize search tags read about `CUSTOM_CAPTION` in file 'taprc'.

### Operation

The Filmstrip plugin outputs at most $LIST\_LINES (60) rows at the time
to the search result list. Each row label is the shortened full pathname
of a JPEG image file under folder $SEARCH\_IN.  Activating a row opens a
demo dialog window that shows the image full pathname.

The first $VIEWER\_FRAMES (5) images are displayed in a separate
thumbnail viewer, which auto-updates while the user keys in the search
term.  Note that by design input terms are searched for literally
and only within the filename part of the path, or within the picture
caption.  Searching is letter case insensitive.

CAVEAT: On slow systems the viewer may not be able to update fast enough
for fast typing. As a quick remedy, backspace and type again - more
slowly - to sync. For a permanent solution experiment changing the value
of the TYPING\_RATE, as explained in file [taprc](taprc).

By default clicking a picture in the viewer window opens the image file
full pathname with ROX-filer, which presumably should start the default
image viewer. This action can be customized with CUSTOM\_CLICK.

You can save search results by pressing hotkey F4. By default
tab-separated text data fields are copied to the clipboard if xclip is
installed, otherwise data are sent to the standard error stream.  To save
to a file start findnrun like so (or set RDR in file ~/.findnrun):
```
    RDR=">/path/to/save-file.tsv" findnrun &
```
To keep just specific columns use a filter command, i.e.:
```
    RDR="|cut -f2 >/path/to/save-file.tsv" findnrun &
    # -f2 : image file full path
```
To copy to the clipboard:
```
    RDR="|xclip" findnrun &
```

Search results can be paginated by pressing the PageDown or PageUp keys
while the search input field is selected. Page size is $VIEWER\_FRAMES
rows, say N rows.  Paginating down the search result list rotates the
first N items to the bottom of the list.  Paginating up rotates the
last N items to the top.  Viewer contents update consequently.  Typing
or continuing to type the search term updates the list entirely and
deliveres a new set of result items to the list and viewer.

### Suggested Packages

While the Filmstrip plugin doesn't depend on non-standard packages,
it does deliver enhanced functionality when package 'exiftool' is
installed. Read more in file 'taprc' in the comment section for
CUSTOM\_CAPTION.

### Translations

Source title and messages can be localized by installing a suitable
.mo file, findnrun-plugin-filmstrip.mo.

### Version

See file [source-me.sh](source-me.sh) for version information.
