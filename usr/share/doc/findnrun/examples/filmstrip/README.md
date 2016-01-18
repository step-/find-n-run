
### Configuration file

Source plugin 'filmstrip' tap has its own configuration file.
Get familiar with the default configuration file '[taprc](taprc)',
located in this folder, before reading further.
File 'taprc' also explains how to install plugin 'filmstrip'.

### Synopsis

The 'filmstrip' plugin outputs at most $LIST\_LINES (60) records to
the tree list widget. The icon column isn't filled. Each row label is the
shortened full pathname of a JPEG image file under folder $SEARCH\_IN.
Activating a row opens a demo dialog window that shows the image full
pathname.

The first $VIEWER\_FRAMES (5) images are displayed in a separate thumbnail
viewer, which auto-updates while the user keys in the search term.  Note
that by design input terms are searched for literally and only within
the filename part of the path, or within the picture caption.
Searching is letter case insensitive.

CAVEAT: On slow systems the viewer may not be able to update fast
enough for fast typing. As a quick remedy, backspace and type again
- more slowly - to sync. For a permanent solution experiment with
different values of the $TYPING\_RATE parameter, as explained in file
[taprc](taprc).

By default clicking a picture in the viewer window opens the image file
fullpath with ROX-filer, which presumably should start the default image
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
displayed sequence. As a quick remedy, paginate back/forth once until
displayed thumbnails match the top lines of the search result list.

### Suggested packages

The filmstrip plugin doesn't require additional packages, but it
delivers enhanced functionality when the following packages are
installed: xdotool, exiftool. In particular for exiftool read the
comments for CUSTOM\_CAPTION in the default taprc file.

### Translations

Source title and messages can be localized by installing a suitable
.mo file, findnrun-plugin-filmstrip.mo

