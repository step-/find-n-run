# Findnrun

A progressive finder.

[Documentation Index](http://github.com/step-/find-n-run/tree/master/usr/share/doc/findnrun/index.md)
   | [Screenshots](http://github.com/step-/find-n-run/tree/master/usr/share/doc/findnrun/screenshots.md)
   | [Downloads](http://github.com/step-/find-n-run/releases)
   | [Translations](http://github.com/step-/find-n-run/tree/master/usr/share/doc/findnrun/TRANSLATING.md)
   | [Credits](http://github.com/step-/find-n-run/tree/master/usr/share/doc/findnrun/CREDITS.md)
   | [Legal](http://github.com/step-/find-n-run/tree/master/LICENSE)
   | [Project home](http://github.com/step-/find-n-run)

## News

**06-Apr-2020 Release [4.0.3](https://github.com/step-/find-n-run/releases/tag/4.0.3)**

* Move help folder to a more standard path.

**Upgrading**

From version 2.2.0 - You need to edit your existing configuration file
as explained in the
[2.3.0 release announcement](https://github.com/step-/find-n-run/releases/tag/2.3.0).

From an earlier version - You need to edit your existing configuration
file as explained in the
[2.2.0 release announcement](https://github.com/step-/find-n-run/releases/tag/2.2.0).

## Introduction, Features, Installing, Documentation and more

[Main article](http://github.com/step-/find-n-run/tree/master/usr/share/doc/findnrun/index.md)

## Change Log

See [release announcements](https://github.com/step-/find-n-run/releases)
and
[commit history](https://github.com/step-/find-n-run/commits/master).

## Old News

**24-Jan-2019 Release [4.0.2](https://github.com/step-/find-n-run/releases/tag/4.0.2)**

* Fix: Selected command not started (involves plugin use only).

**13-Jan-2019 Release [4.0.1](https://github.com/step-/find-n-run/releases/tag/4.0.1)**

Recommended upgrade for all users.

* Critical fix: Built-in fuzzy search displays no results if only search-filenames is enabled in default configuration.
* Fix: Built-in fuzzy search used even though disabled on pristine start.
* Fix: Fuzzy search engine choice displayed incorrectly in About dialog text.
* Update: user documentation and translation template.

**3-Jan-2019 Release [4.0.0](https://github.com/step-/find-n-run/releases/tag/4.0.0)**

Release highlights: * Faster, better, alternative **fuzzy and exact search** engine using the optional [fzf](https://github.com/junegunn/fzf) external binary. * Now plugins can call the built-in and fzf search engines.

* New: integrate external search engine `fzf` for exact and fuzzy search
* New: start-up dialog to download/install `fzf`
* New: user preference `TERMINAL_PROGRAM` (defaultterm)
* Change: UI rename "Consider word case" to "A ≠ a"
* Change: UI "Show all icons" and "A ≠ a" swap places
* Change: Toggling "A ≠ a" no longer requires a restart
* Change: Toggling search details no longer requires a restart when `fzf` is used
* Fix: `findnrun-formatter -s` splits lines on spaces
* Fix: Run in terminal saves history to `.hist-` instead of `.hist-$ID`
* Fix: Null `FNR*` variables when saving drain invocation history
* Update: credits
* Update: user and plugin documentation
* Update: translation template
* Plugin: New: plugins can call the built-in and fzf search engines
* Plugin: New: plugin Helper Functions
* Dev: extend help system to allow directly opening any markdown file

**16-Dec-2018 Release [3.1.0](https://github.com/step-/find-n-run/releases/tag/3.1.0)**

Release highlights: A new **fuzzy search** mode (off by default), a new configurable **hotkey F6**, and a **configuration menu** that reveals all previously hidden settings (hotkey re-assignment is still hidden in the configuration file `~/.findnrunrc`). Press `[F10]` in the main window to see hoteys settings. Press `[F10]` again to access the configuration menu, or click the new menu symbol "☰".

* New: add fuzzy search (SEARCHFUZZY setting), off by default
* New: add Options menu.
* New: fuzzy search checkbox in the main window
* New: hidden setting `FUZZY_MATCH_FIELD_BONUS`
* New: hotkey `F6` clears the search input field
* Change: remove user setting SEARCHCOMPLETE
* Fix: work around "&" in .desktop comment field
* Fix: did not show icon for `.DirIcon` files
* Fix: restart did not reset the search input field
* Update: screenshots
* Update: credits
* Update: user and plugin documentation
* Update: translation template
* Plugin dev: update `findnrun-formatter`
* Dev: add desktop file lister (debug level 1)

**19-Oct-2018 Release [3.0.0](https://github.com/step-/find-n-run/releases/tag/3.0.0)**
* Faster program start.
* Huge speed increase "Showing all icons".
* New: Dash compatible out-of-the-box (sh, bash and ash too).
* New: Hotkey help - hotkey F10 lists hotkey assignments.
* New: Save results - hotkey F4 saves search results to a file or command pipe defined via `RDR` in file ~/.findnrunrc.
* New: Run in terminal - hotkey F5 starts selected item in a terminal window.
* New: Run in terminal - UI button to run command entry field in a terminal window.
* New: Icon theme support - icons honor the GTK2 icon theme, if any, e.g. in file ~/.gtkrc-2.0:
    `gtk-icon-theme-name="Clarity"
* New: Icon theme support - override GTK2 icon them with new preference `GTK_ICON_THEME_NAME` in file ~/.findnrunrc.
* New: Source property - Add `INIT_<source>` to built-in and plugin source declarations.
* New: display fallback icon when no app icon exists.
* New: Allow icon names (not just paths) for built-in and plugin sources.
* Changed: Move icons from /usr/share/doc/findnrun to /usr/share/icons.
* Changed: Use icon name 'findnrun' for all sub-windows but Help.
* Changed: Reject non- `Type=Application` .desktop files.
* Changed: Variables XCLIP (preferences.md) and FNRSAVEFLT (plugin-dev.md) are no longer supported.
* Fix: No window auto-close after hotkey F12.
* Fix: wrong `XDG_DATA_HOME` initialization.
* Fix: `yad --progress` still visible after main window exit.
* Fix: Regex search fails for _Shell Completion_ source.
* Several UI messages added and changed (translations needed).
* Help and documentation files updated (translations needed).
* i18n translation template (.pot file) updated.
* Plugins: New `INIT_<source>`, _Saving Search Results_.

**24-Aug-2018 Release [2.5.0](https://github.com/step-/find-n-run/releases/tag/2.5.0)**
* Faster application start thanks to new translation lookup method, new icon caching algorithm, and optimized plugin validation.
* New progress dialog for long scans.
* Change: yad replaces Xdialog for sub-dialogs.
* Updated "de" (63%) and "it" (100%) translations.
* Fix: single quote in plugin code was invalid.
* Fix: some documentation typos.
* New translation tools.

**13-Sep-2017 Release [2.4.1](https://github.com/step-/find-n-run/releases/tag/2.4.1)**
* updates the German translation.

**6-Sep-2016 Release [2.4.0](https://github.com/step-/find-n-run/releases/tag/2.4.0)**
* is a recommended feature upgrade for all users.

**1-Aug-2016 Release [2.3.0](https://github.com/step-/find-n-run/releases/tag/2.3.0)**
* is a recommended feature upgrade for all users.

**13-Jun-2016 Release [2.2.0](https://github.com/step-/find-n-run/releases/tag/2.2.0)**
* is a recommended feature upgrade for all users.

**25-Apr-2016 Release [2.1.1](https://github.com/step-/find-n-run/releases/tag/2.1.1)**
* is a recommended upgrade for all users.

**11-Mar-2016 Release [2.1.0](https://github.com/step-/find-n-run/releases/tag/2.1.0)**
* is a recommended upgrade for all users.

**23-Jan-2016 Release [2.0.0](https://github.com/step-/find-n-run/releases/tag/2.0.0)**
* adds plugins and new features!

**4-Sep-2015 Version 1.10.6 runs on Lubuntu:**
* [package information](http://github.com/step-/find-n-run/tree/master/usr/share/doc/findnrun/DEBIAN.md)

**18-Jun-2015**
* As of version 1.10.5 this script replaces the _original_
  [Find'N'Run](http://www.murga-linux.com/puppy/viewtopic.php?t=98330)

