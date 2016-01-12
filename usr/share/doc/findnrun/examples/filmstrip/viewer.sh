#!/bin/sh
# POSIX. No bashisms.
# Adapted from /usr/share/doc/gtkdialog-514/examples/pixmap/pixmap_file_monitor

[ "${FNRDEBUG:-0}" -gt 1 ] && set -x


# $1-$2 are required. {{{1
CONFIG=$1; . "${CONFIG}"
INPUTSTEM=$2
shift 2

# From $CONFIG file. # {{{1
MAXSLOT=${VIEWER_FRAMES:-5}
PICTURE_WIDTH=${PICTURE_WIDTH:-96}
PICTURE_HEIGHT=${PICTURE_HEIGHT:-96}
CAPTION_WIDTH=${CAPTION_WIDTH:-180}
CAPTION_HEIGHT=${CAPTION_HEIGHT:-20:}
# Adapt caption height, see default taprc file.
[ -n "${CUSTOM_CAPTION}" ] && CAPTION_HEIGHT=${CAPTION_HEIGHT#*:} || CAPTION_HEIGHT=${CAPTION_HEIGHT%:*}
[ "${SHOW_SCROLLBARS}" = true ] && scrollbars= || scrollbars=' hscrollbar-policy="2" vscrollbar-policy="2"'

# i18n Localization {{{1
TEXTDOMAIN="findnrun-plugin-filmstrip"
#gettext "filmstrip" # plugin TITLE

# Kill my process when findnrun exits. {{{1
# We want to kill this shell and its gtkdialog window. $$ is for this shell.
# For the window look for KILLPID in section 'Main window' further down.
PIDF="${INPUTSTEM%/*}/.pidof_viewer"
echo $$ > "${PIDF}"

# Install traps. {{{1
# If this viewer exits regardless of findnrun's state, the tap could
# re-start a new viewer provided that $PIDF doesn't exist, so let's
# delete $PIDF.
trap 'rm -f "${PIDF}"' HUP INT QUIT TERM ABRT 0

generate_pixmap() { # $1-varname [$2-indent] {{{1
  # pixmap and its path
	printf "${2#*:}%s\\n" \
'<pixmap yalign="0">' \
'  <variable export="false">'$1'</variable>' \
'  <width>'"${PICTURE_WIDTH}"'</width>' \
'  <height>'"${PICTURE_HEIGHT}"'</height>' \
'  <input file>'"${INPUTSTEM}-$1"'</input>' \
'</pixmap>'
#'  <action signal="refresh" condition="command_is_true(echo ${#'$1'})">show:'$1'</action>' \
#'  <action signal="refresh" condition="command_is_true(echo ${#'$1'})">echo >&2 true ${#'$1'}</action>' \
#'  <action signal="refresh">echo >&2 true/false ${#'$1'}</action>' \
#'  <action signal="refresh" condition="command_is_false(echo ${#'$1'})">hide:'$1'</action>' \
#'  <action signal="refresh" condition="command_is_false(echo ${#'$1'})">echo >&2 false ${#'$1'}</action>' \
}

generate_caption() { # $1-varname [$2-indent] {{{1
	printf "${2#*:}%s\\n" \
'<edit name="filmstripCaption" cursor-visible="false" editable="false" accepts-tab="false" wrap-mode="2" left-margin="5" right-margin="5"'"${scrollbars}"'>' \
'  <variable export="false">'$1'c</variable>' \
'  <input file>'"${INPUTSTEM}-$1"c'</input>' \
"  <width>${CAPTION_WIDTH}</width>" \
"  <height>${CAPTION_HEIGHT}</height>" \
'</edit>'
}

generate_action() { # $1-varname [$2-indent] {{{1
  local click_command
  click_command="${CUSTOM_CLICK:-rox}"
  printf "${2#*:}%s\\n" \
'<action signal="button-press-event">'${click_command}' "$(readlink -f "'"${INPUTSTEM}-$1"'")" & </action>'
}

generate_horizontal_band() { # $1-varname [$2-indent] {{{1
	printf "${2#*:}%s\\n" \
'<edit name="filmstripPictureFrame" cursor-visible="false" editable="false" accepts-tab="false" hscrollbar-policy="2" vscrollbar-policy="2">' \
'  <variable export="false">'$1'p</variable>' \
"  <width>${CAPTION_WIDTH}</width>" \
"  <height>5</height>" \
'</edit>'
}

# Main window {{{1
maxcol=${MAXSLOT}
maxrow=1
width_request=$(( ((${CAPTION_WIDTH} > ${PICTURE_WIDTH} ? ${CAPTION_WIDTH} : ${PICTURE_WIDTH}) + 20) * ${MAXSLOT} ))

# $TITLE is inherited from tap.sh's environment.
# Widget 'name' attributes are defined in files gtkrc-2.0 and gtk3.css in this folder.
cat > "${INPUTSTEM%/*}/.viewer.xml" << EOF
<window name="filmstripWindow" title="${TITLE}" icon-name="edit-find" width-request="${width_request}" resizable="false">
  <vbox>
$(y=0; while [ $y -lt $maxrow ]; do
echo '    <hbox>'
  x=0; while [ $x -lt $maxcol ]; do
    v=y${y}x${x}
echo '      <frame>'
echo '        <vbox spacing="0">'
                generate_horizontal_band $v 10:'          '
echo '          <eventbox name="filmstripPictureFrame">'
                  generate_pixmap $v 12:'            '
                  generate_action $v 12:'            '
echo '          </eventbox>'
                generate_horizontal_band $v 10:'          '
                generate_caption $v 10:'          '
echo '        </vbox>'
echo '      </frame>'
    x=$((x + 1))
  done
echo '    </hbox>'
  y=$((y + 1))
done)
  </vbox>
  <entry visible="false" sensitive="false" auto-refresh="true">
    <variable export="false">REFRESHPIXMAPS</variable>
    <input file>"${INPUTSTEM}-refresh"</input>
$(  >"${INPUTSTEM}-refresh" # must exist before input triggers
y=0; while [ $y -lt $maxrow ]; do
  x=0; while [ $x -lt $maxcol ]; do
    v=y${y}x${x}
    printf '    %s\n' \
    "<action>refresh:${v}</action><action>refresh:${v}c</action>"
    x=$((x + 1))
  done
y=$((y + 1))
done
)
  </entry>
  <entry visible="false" sensitive="false">
    <variable export="false">KILLPID</variable>
    <input>ps -ho ppid:1 \$\$ >> "${PIDF}"</input>
  </entry>
  <action signal="delete-event">exit:abort</action>
  <variable>GUI_FILMSTRIP</variable>
  <action signal="key-press-event" condition="command_is_true([ \$KEY_SYM = Escape ] && echo true )">closewindow:GUI_FILMSTRIP</action>
</window>
EOF

#{{{1}}}
"${GTKDIALOG:-gtkdialog}" --space-expand=true --space-fill=true \
  "${GTK_STYLES}" -s < "${INPUTSTEM%/*}/.viewer.xml" >/dev/null &

# Raise findnrun's own window (requires xdotool installed). {{{1
if which xdotool >/dev/null 2>&1; then
  sleep 0.5s # to give gtkdialog enough time to map its window
  2>/dev/null xdotool search --all --pid ${FNRPID} \
    --onlyvisible --name . windowactivate
fi

#{{{1}}}
wait # to handle trap

