## Plugins

[Plugin Development](plugin-dev.md)
   | [List of contributed plugins](plugin-list.md)
   | [Screenshots](screenshots.md)

Plugins enable connecting new types of searches into the main
window. Findnrun expands beyond its original scope of "finding and
starting an application" to "finding something and doing something with
it".  Some plugins are bundled so you can immediately use them.  Shell
scripting ability suffices to write your own plugin.

### Plugin Types

There is just one type of plugin, the _source_ plugin.
More types may be added in the future.

## Source Plugins

Each source plugin - _source_ for short - does two things: it generates
list items for the main window, and it processes the selected list
item when the user activates the item. The _exemplar source_ is the
"application search and execution" that findnrun performs in its most
basic configuration. It is referred to as _source 1_ and labelled
_Application Finder_.

As new plugins are installed, you get source 2, source 3, etc, each
source with its own label.  The status bar located at the bottom of
the main window shows the labels of the currently active source and
of the _next_ source. You move through the source ring by pressing
[F3](hotkey.md).

### Bundled Plugins

In its default configuration findnrun enables the _shell completion_
plugin, which is source 2. Press `F3` in the main window to start
it. Shell completion searches through all the commands in your `$PATH`
variable. Be aware that most commands are meant to run in their own
terminal window, which this plugin doesn't start automatically.

### Demo Plugins

**Filmstrip** is the prominent demo plugin for end users.  As you
incrementally refine the search term the Filmstrip viewer displays
thumbnails of the images that match your search results. Matches are
checked against image filename and caption.[1]

Filmstrip isn't installed by default. To install it follow the
instructions in its [README](examples/filmstrip/README.md) file.
Once the plugin is installed press [F3](hotkey.md) repeatedly until the
viewer starts.

[1] Searching captions requires installing package 'exiftool' for your
   platform.

