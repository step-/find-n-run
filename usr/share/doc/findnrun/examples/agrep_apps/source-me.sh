#!/bin/ash
# This file is sourced by (b)ash not run.

# Version: 1.0.0 2016-05-18
# Author: step
# License: GPLv2
# Copyright (c)2016 step

# Installation file for the 'approximate application search' source plugin
# INSTRUCTIONS: Read file index.md, which is co-located with this file.
# Do not edit this file; copy it to your home folder and edit the new file:
#  cp -n /usr/share/doc/findnrun/examples/agrep_apps/source-me.sh $HOME/

bin_agrep_apps=/usr/bin/agrep # <<< REVIEW AND CHANGE THIS IF NECESSARY

define_source_plugin () { #{{{
  local oe oi on os ox
  os=1 # default sort output by error tolerance; set 0 to disable
  oe=1 # default error tolerance threshold
  oi=-i # default is case-independent
  [ true = "$CASEDEPENDENT" ] && oi=
  # 1:fullpathname 2:appname 3:exec 4:comment 5:categories
  on='\$2'
  if [ true = "$SEARCHFILENAMES" -o true = "$SEARCHCOMPLETE" ]; then
    # keep basename(fullpathname, .ext)
    statements='gsub(/^.*[/]|[.][^.]+\$/, \"\", \$1);'
    on=$on',\$1'
  fi
  [ true = "$SEARCHCOMMENTS" ] && on=$on',\$4'
  case $SEARCHCATEGORIES in true|hidden) on=$on',\$5' ;; esac
  [ true = "$SEARCHCOMPLETE" ] && on='\$1,\$2,\$3,\$4,\$5'
  [ true = "$SEARCHREGEX" ] && ox= || ox=-k
  # $0 is the findnrun script file path.
  local plgdir="${0%/*}/../share/doc/findnrun/examples/agrep_apps"
  # This plugin provides its own help file "$plgdir/index.md"
  PLGDIR_agrep_apps="$plgdir"
  SOURCE_agrep_apps='agrep_apps:::agrep_apps:::agrep_apps:FNRstart'
  TITLE_agrep_apps='approximate application finder'
  if [ -e "$bin_agrep_apps" ]; then
    TAP_agrep_apps=\
"e=-$oe OX=$ox ;"\
'case $term in '\
"  -[0-9]\" \"*) e=\${term%% *}; term=\${term#*\" \"};;"\
"  *\" \"-[0-9]) e=\${term##* }; term=\${term%\" \"*};;"\
"esac;"\
'case $term in '\
"  -x\" \"*) OX=;   term=\${term#-x\" \"};;"\
"  *\" \"-x) OX=;   term=\${term%\" \"-x};;"\
"  -X\" \"*) OX=-k; term=\${term#-X\" \"};;"\
"  *\" \"-X) OX=-k; term=\${term%\" \"-X};;"\
"esac;"\
'gawk -F "[\b]" '\
"-v 'command=\"$bin_agrep_apps\" -n -s '\$e' $oi '\$OX' -e \"'\$term'\"' "\
'"'\
'  {'\
'    a[++ia]=\$0;'"$statements"\
'    print '$on' |& command;'\
'  }'\
'  END {'\
'    close(command, \"to\");'\
'    FS=\":\";'\
"    if(\"$os\") {"\
'      while ((command |& getline) > 0) {'\
'        k = sprintf(\"%02d.%05d\", \$2, \$1);'\
'        v[k] = \$2;'\
'      }'\
'      close(command);'\
'      nv = asorti(v);'\
'      for(i = 1; !(i > nv); i++) {'\
'        print a[0+substr(v[i],4)];'\
'      }'\
'    } else {'\
'      while ((command |& getline) > 0) {'\
'        print a[\$1];'\
'      }'\
'    }'\
'  }'\
'" "$FNRTMP/.FNRstart/.dat"'

# gawk script explained:
# 1. for each record (main loop)
# 1.1. save input record with record number as index (a[])
# 1.2. pipe field selection ($on) to command (agrep, -n:record#, -s:tolerance)
# 2. read command output (END) and for each line (while)
# 2.1. k = <tolerance, record#> (sprint)
# 2.2. v[k] = tolerance
# 3. sort v by tolerance getting k as values (asort)
# 4. output matching records sorted by tolerance (for)
# Note: the else block is the simpler case without sorting

  else
    TAP_agrep_apps=\
"printf '||%s\n||%s\n' \"$(printf \
  "$(gettext "File not found (agrep binary): '%s'")" "$bin_agrep_apps")\" \"$(gettext \
  "Press F1 for help.")\" | findnrun-formatter --"
  fi
}
: DEBUG << 'EOF'
# Debug gawk input stream by adding the first line before the second one above.
'    print '$on' >\"/dev/stderr\";'\
'    print '$on' |& command;'\
# Debug gawk output stream by adding the first line before the second one above.
'        print a[0+substr(v[i],4)] > \"/dev/stderr\";'\
'        print a[0+substr(v[i],4)];'\
# Debug tap-command arguments by changing from:
'gawk -F "[\b]" '\
#  to
'echo >&2 gawk -F "[\b]" '\

EOF
#}}}
define_source_plugin
