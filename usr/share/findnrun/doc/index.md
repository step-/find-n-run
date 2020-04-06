# Help Index

**Findrun** - A progressive finder

_4.0.3_

[Project home](http://github.com/step-/find-n-run)
   | [Downloads](http://github.com/step-/find-n-run/releases)

## Introduction

Findnrun is an extensible desktop application finder. It finds and
displays system applications in a graphical window. Search results are
refined and displayed progressively as you type characters into the
search input field.  With the addition of plugins findnrun can search
for other objects, such as user files, shell commands, pictures, and so
on.

Findnrun started in May 2015 as a fork of [Find'N'Run](CREDITS.md), an
earlier project for Puppy Linux.

Currently Findnrun is being developed and tested on
[Fatdog64](http://distro.ibiblio.org/fatdog/web/) 64-bit Linux, a
[Puppy Linux](http://puppylinux.com/) and
[LFS](http://www.linuxfromscratch.org/) derivative.

To clarify the names, which can be confusing at first:

 * _Findnrun_ - this project
 * _find-n-run_ - this online repository
 * _Find'N'Run_ - the _earlier_ project

Both projects name the main script 'findnrun'.

## Main features

 * **Fast incremental search** (find as you type)[1]
 * **Exact and fuzzy matching** (choice of "built-in" or external ["fzf"](fzf.md) engines)
 * **Search Plugins** extend search to other data types
 * **Command line entry** with history.
 * **[Hotkeys](hotkey.md)**
 * **Browsable help**[2]
 * **[User preferences](preference.md)**
 * **Multiple-user, multiple-instance** support[3]
 * **Multi-language** support includes program and help documentation.

[1] Search for applications by **name**, **filename**, **command line**,
   **comments**, and **categories**, or all at once. Search **from left**,
   with **regular expressions**, **case-independently**. Search for
   applications installed with **Wine**.

[2] Help documents are encoded as _markdown_. You can _read_ markdown as
   plain text - with some minor loss of formatting - or with the
   [mdview](http://chiselapp.com/user/jamesbond/repository/mdview3/index)
   viewer (recommended). Mdview can also _browse_ markdown, and
   automatically show _translated_ markdown provided that the findnrun
   NLS package for your language is installed.

[3] Run multiple searches at the same time. Each search window is
   separate from other running instances. Use multiple preference
   files to tailor each instance to your needs.

## Documentation Topics

 * [Screenshots](screenshots.md)
 * [Installing](install.md) and Language Settings
 * [Fzf](fzf.md) Search Engine
 * [Starting](running.md) Findnrun
 * [Configuring](preference.md) Preferences
 * [Hotkeys](hotkey.md)
 * [Plugins](plugin.md)
 * [Reporting bugs](issues.md)
 * [Credits](CREDITS.md)
 * [Translating](TRANSLATING.md)
 * [License](LICENSE.md) GNU GPL v2

## Change Log

See [release announcements](https://github.com/step-/find-n-run/releases)
and - for fine-grained information -
[commit history](https://github.com/step-/find-n-run/commits/master).

## Links

 * [Project home](http://github.com/step-/find-n-run)
 * [Downloads](http://github.com/step-/find-n-run/releases)
 * [Forum thread](http://www.murga-linux.com/puppy/viewtopic.php?t=102811)
 * [Old forum thread](http://www.murga-linux.com/puppy/viewtopic.php?t=98330)

