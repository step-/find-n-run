_Note: These instructions concern installing Findnrun on
Debian/Ubuntu/Mint systems. If you are running a Puppy Linux OS, you
need not be concerned._

While supporting Debian-based distributions isn't a project goal, my
limited testing on Lubuntu shows that findnrun 1.10.6 runs fine.  I will
try to keep compatibility in future releases, but I can't promise full
support - because I am focused on Fatdog64 Linux and do not use Ubuntu.

Findnrun 1.10.6 running on Lubuntu with the WinAte theme.

![lubuntu main window](images/lubuntu-winate-1.10.6-main.pub.png)

## Installing Findnrun on Debian/Ubuntu/Mint Systems

**PRE-REQUISITES**: Before you can install findnrun your system must
satisfy the pre-requisites that are explained in the next section.

Then you can download and install the `.deb` package
attached to the **latest release** in the
[release page](http://github.com/step-/find-n-run/releases/).

## Pre-requisites

_Note: The findnrun `.deb` package has been improved to automatically
handle the cases discussed in this section. Follow the instructions on
the download page and you should be fine. In case you are unable to run
findnrun, come back to this section and use it to troubleshoot the
installation._

To use findnrun on a plain Debian/Ubuntu/Mint system you need to install
three packages, which might themselves pull in additional dependencies:

 * GNU awk, **gawk**
 * **gtk-dialog 0.8.3**
 * the **ash** shell (with some precautions, see further down)

### GNU awk

Findnrun requires GNU awk, best known as `gawk`.  On some Debian-based
versions, i.e., Lubuntu and others, by default `awk` links to `mawk`,
which isn't sufficiently capable for findnrun. So get `gawk`.

Start a terminal and run this command:

    sudo apt-get install gawk

### gtk-dialog and libnotify-bin

Ubuntu removed gtk-dialog from the offical repository a few releases
ago, so you need to install gtk-dialog from a contributed repository.  I
tested lanzadoc's repository, which includes a 32-bit package only.
Option for 64-bit systems are also listed further down.

**Links to PPA repositories**

Update: lanzadoc's repository link has disappeared from Launchpad's
_Other versions of 'gtkdialog' in untrusted archives_. I found some new
PPA links for a mix of versions and architectures. I have _not_ tested
any of these links, but here they are:

 * https://launchpad.net/~kxstudio-team/+archive/ubuntu/ppa
 * https://launchpad.net/~elia-notarangelo/+archive/ubuntu/x-light-mind
 * https://launchpad.net/~dnjl/+archive/ubuntu/ppa/+packages
   (32- and 64-bit builds)

**Using aptitude**

_Note: I only tested the manual installation process, which is described
in the next section._

Browse https://launchpad.net/ubuntu/+source/gtkdialog
and click "Other versions of 'gtkdialog' in untrusted archives".

Add lanzadoc's repository (32-bit only):

    sudo apt-add-repository https://launchpad.net/~geinux/+archive/ubuntu/lanzadoc
    sudo apt-get update

install gtk-dialog, which should also install the official libnotify-bin
package if necessary.

    sudo apt-get gtk-dialog

**Manual installation for 32-bit OS**

Download the `.deb` file directly from lanzadoc's repository:

 * http://ppa.launchpad.net/geinux/lanzadoc/ubuntu/pool/main/g/gtkdialog/
 * http://ppa.launchpad.net/geinux/lanzadoc/ubuntu/pool/main/g/gtkdialog/gtkdialog_0.8.4_i386.deb

Install gtk-dialog by double-clicking the `.deb` file in your file
manager to start your package manager, which should also install the
official libnotify-bin package if necessary.

**Options for 64-bit systems**

Unfortunately, lanzadoc's repository lacks a 64-bit gtk-dialog `.deb`
package.  A 64-bit package of an earlier gtk-dialog version 0.8.3.2 is
found on the 'multisystem' sourceforce project
[page](http://sourceforge.net/projects/multisystem/files/gtkdialog-deb/).
Please note that I did not test this package at all.  You are on your
own.  Proceed with due caution at your own risk.

Alternatively, if you don't mind mixing binaries, you could download
Fatdog64's own gtk-dialog binary package and dependency libraries from
the official [page](http://distro.ibiblio.org/fatdog/packages/700/),
and extract binary files into the standard locations for your OS.

### Ash

If the ash shell **is** installed, be wary that Debian, Mint, and Ubuntu
have a separate ash.deb package that links `/bin/ash` to `/bin/dash`,
and dash can't run findnrun. When ash is linked to dash findnrun prints
error messages to the shell such as:
```
    gawk: /tmp/findnrun_18ud5t/.build.awk:3:   if("") print "
    gawk: /tmp/findnrun_18ud5t/.build.awk:3:                ^ syntax error
    sh: $'\b': command not found
```
Findnrun really needs the true ash (or bash) binary.

If the true ash shell isn't already installed you can target /bin/busybox,
if available, as a symbolic link or even /bin/bash.

To create a symbolic link run the following commands in a terminal:
```
    test `readlink -m /bin/ash` = /bin/dash && echo "Remove link /bin/ash -> /bin/dash first."
    test -x /bin/ash || sudo ln -s /bin/busybox /bin/ash
    test -x /bin/ash || sudo ln -s /bin/bash /bin/ash
    ls -l /bin/ash
```
If `/bin/ash` is still unavailable or linked to `/bin/dash` try
changing the first line of file `/usr/bin/findnrun` to reference
`/bin/bash` instead of `/bin/ash`.
