
### Configuration file

Source plugin 'filmstrip' tap has its own configuration file.
Get familiar with the default configuration file 'taprc' in this folder.
The same file also explains how to enable this plugin.

### Synopsis

The 'filmstrip' source outputs at most $LIST\_LINES (60) records to
the tree list widget.  No icons are displayed. Each row label is the
shortened full pathname of a JPEG image file under folder $SEARCH\_IN.
Activating a row opens a demo dialog window that shows the image full
pathname.

The first $VIEWER\_FRAMES (5) images are displayed in a separate image
viewer, which auto-updates while the user keys in the search term.  Note
that by design input terms are searched for literally and only within
the filename part of the path, or within the picture caption.
Searching is letter case insensitive.

CAVEAT: On slow systems the viewer may not be able to update fast
enough for fast typing. Backspace and type again - more slowly - to
sync.

By default clicking a picture in the viewer window opens the image file
fullpath with ROX-filer, which presumably should run the default image
viewer. This action can be customized with setting CUSTOM\_CLICK.

EXPERIMENTAL - Search results can be paginated by pressing the
PageDown/PageUp keys while the search input field is selected. Page
size is $VIEWER\_FRAMES lines. Paginating down/up the search result
list rotates the first/last $VIEWER\_FRAMES items to the bottom/top
of the list respectively. Viewer contents update consequently. Typing
or continuing to type the search term updates the list entirely and
deliveres a new set of result items to the list and viewer.

CAVEAT: On slow systems the viewer may not be able to update fast
enough when pressing the pagination keys too quickly. It will *skip*
an entire pageful of pictures, and the next pagination will display the
page after (or before) the skipped page. So there will be a gap in the
displayed sequence.

### Suggested packages

The filmstrip plugin doesn't require additional packages, but it
delivers enhanced functionality when the following packages are
installed: xdotool, exiftool. In particular for exiftool read the
comments for CUSTOM\_CAPTION in the default taprc file.

### Translations

Source title and messages can be localized by installing a suitable
.mo file, findnrun-plugin-filmstrip.mo

