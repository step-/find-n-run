## Requirements

If you are using Puppy Linux, Fatdog64 or DebianDog your system should
already meet the minimum requirements for findnrun.  Other Debian-based
distributions, such as Ubuntu and Mint, need additional packages before
they can use findnrun. More information for Debian systems is available
on the
[project page](https://github.com/step-/find-n-run/blob/master/usr/share/doc/findnrun/DEBIAN.md)

Findnrun depends on three packages:

 * GNU awk, **gawk 4.1.0**
 * **gtk-dialog 0.8.3**
 * the **ash** shell (with some precautions, see further down)

### Ash

If the ash shell **is** installed, be wary that some Linux
distributions link `/bin/ash` to `/bin/dash`, and dash can't run
findnrun. When ash is linked to dash findnrun prints error messages to
the shell such as:
```
    gawk: /tmp/findnrun_18ud5t/.build.awk:3:   if("") print "
    gawk: /tmp/findnrun_18ud5t/.build.awk:3:                ^ syntax error
    sh: $'\b': command not found
```

If the true ash shell isn't already installed you can target /bin/busybox,
if available, as a symbolic link or even /bin/bash.

To create a symbolic link run the following commands in a terminal:
```
    test `readlink -m /bin/ash` = /bin/dash && echo "Remove link /bin/ash -> /bin/dash first."
    test -x /bin/ash || sudo ln -s /bin/busybox /bin/ash
    test -x /bin/ash || sudo ln -s /bin/bash /bin/ash
    ls -l /bin/ash
```

If `/bin/ash` is still unavailable or linked to `/bin/dash` try changing
the first line of file `/usr/bin/findnrun` to reference `/bin/bash`
instead of `/bin/ash`.
