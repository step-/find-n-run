## Filmstrip - Incremental Image Search Plugin

As you incrementally refine the search term in findnrun's search window,
an image viewer displays thumbnails of the images that match your search
results. Matches are checked against image filename and caption (caption
requires package 'exiftool' for your platform).

### Configuration file

The 'filmstrip' source plugin has its own configuration file.
Get familiar with the default configuration file '[taprc](taprc)',
located in this folder, before reading further.
File 'taprc' also explains how to install plugin 'filmstrip'.

### Operation

The 'filmstrip' plugin outputs at most $LIST\_LINES (60) records to
the tree list widget. The icon column isn't filled. Each row label is the
shortened full pathname of a JPEG image file under folder $SEARCH\_IN.
Activating a row opens a demo dialog window that shows the image full
pathname.

The first $VIEWER\_FRAMES (5) images are displayed in a separate
thumbnail viewer, which auto-updates while the user keys in the search
term.  Note that by design input terms are searched for literally
and only within the filename part of the path, or within the picture
caption.  Searching is letter case insensitive.

CAVEAT: On slow systems the viewer may not be able to update fast
enough for fast typing. As a quick remedy, backspace and type again
- more slowly - to sync. For a permanent solution experiment with
different values of the $TYPING\_RATE parameter, as explained in file
[taprc](taprc).

By default clicking a picture in the viewer window opens the image file
fullpath with ROX-filer, which presumably should start the default image
viewer. This action can be customized with setting CUSTOM\_CLICK.

Search results can be paginated by pressing the PageDown/PageUp keys
while the search input field is selected. Page size is $VIEWER\_FRAMES
lines. Paginating down/up the search result list rotates the first/last
$VIEWER\_FRAMES items to the bottom/top of the list respectively. Viewer
contents update consequently. Typing or continuing to type the search
term updates the list entirely and deliveres a new set of result items
to the list and viewer.

### Suggested packages

The filmstrip plugin doesn't require additional packages, but it
delivers enhanced functionality when the package 'exiftool' is
installed. Read more in file 'taprc' in the comment section for setting
CUSTOM\_CAPTION.

### Translations

Source title and messages can be localized by installing a suitable
.mo file, findnrun-plugin-filmstrip.mo

