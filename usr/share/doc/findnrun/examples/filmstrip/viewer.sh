#!/bin/sh
# POSIX. No bashisms.
# =============================================================================
# Filmstrip viewer
  Version=1.0.0
# author: Copyright (C)2016 step
# license: GNU GPL applies
# requirements: findnrun >= 2.0.0
# source: https://github.com/step-/find-n-run
# forum: http://www.murga-linux.com/puppy/viewtopic.php?t=98330
# =============================================================================

[ "${FNRDEBUG:-0}" -gt 1 ] && set -x

# $1-$2 are required. [[[1
CONFIG=$1; . "${CONFIG}"
INPUTSTEM=$2
shift 2

# From $CONFIG file. # [[[1
MAXSLOT=${VIEWER_FRAMES:-5}
PICTURE_WIDTH=${PICTURE_WIDTH:-96}
PICTURE_HEIGHT=${PICTURE_HEIGHT:-96}
CAPTION_WIDTH=${CAPTION_WIDTH:-180}
CAPTION_HEIGHT=${CAPTION_HEIGHT:-20:}
# Adapt caption height, see default taprc file.
[ -n "${CUSTOM_CAPTION}" ] && CAPTION_HEIGHT=${CAPTION_HEIGHT#*:} || CAPTION_HEIGHT=${CAPTION_HEIGHT%:*}
[ "${SHOW_SCROLLBARS}" = true ] && scrollbars= || scrollbars=' hscrollbar-policy="2" vscrollbar-policy="2"'

# i18n Localization [[[1
TEXTDOMAIN="findnrun-plugin-filmstrip"
#gettext "filmstrip" # plugin TITLE

# Kill my process when findnrun exits. [[[1
# We want to kill this shell and its gtkdialog window. $$ is for this shell.
# For the window look for KILLPID in section 'Main window' further down.
PIDF="${INPUTSTEM%/*}/.pidof_viewer"
echo $$ > "${PIDF}"

# Install traps. [[[1
# If this viewer exits regardless of findnrun's state, the tap could
# re-start a new viewer provided that $PIDF doesn't exist, so let's
# delete $PIDF.
trap 'rm -f "${PIDF}"' HUP INT QUIT TERM ABRT 0

generate_pixmap() { # $1-varname [$2-indent] [[[1
  # The image fits horizontally with a fixed $width.  Vertical overflow,
  # if any, is hidden and can be revealed by resizing the main window
  # vertically.  The image never scales.
  local margin width height fit click_command
  margin=${GENERATED_MARGIN}
  width=$((${margin}*2 + ${PICTURE_WIDTH}))
  height=$((${margin}*2 + ${PICTURE_HEIGHT}))
  click_command="${CUSTOM_CLICK:-rox}"
  # Gtkdialog's pixmap widget supports auto-refresh and file-monitor
  # attributes. However, they don't seem to work with symlinks, so
  # another widget is used synchronously to refresh all pixmaps.
  printf "${2#*:}%s\\n" \
'<vbox space-fill="false" space-expand="false">' \
'  <eventbox name="FilmstripPictureFrame">' \
'    <vbox spacing="0" margin="'$margin'" width-request="'$width'" height-request="'$height'">' \
'      <pixmap yalign="0">' \
'        <variable export="false">'$1'</variable>' \
'        <input file>'"${INPUTSTEM}-$1"'</input>' \
"        <width>${PICTURE_WIDTH}</width>" \
'      </pixmap>' \
'    </vbox>' \
'    <action signal="button-press-event">'${click_command}' "$(readlink -f "'"${INPUTSTEM}-$1"'")" & </action>' \
'  </eventbox>' \
'</vbox>'
}

generate_caption() { # $1-varname [$2-indent] [[[1
  local margin=${GENERATED_MARGIN}
  local width=$((${margin}*2 + ${CAPTION_WIDTH}))
  local height=$((${margin}*2 + ${CAPTION_HEIGHT}))
	printf "${2#*:}%s\\n" \
'<vbox space-fill="true" space-expand="true">' \
'  <eventbox name="FilmstripCaption">' \
'    <vbox spacing="0" margin="'$margin'" width-request="'$width'" height-request="'$height'">' \
'      <edit name="FilmstripCaption" cursor-visible="false" editable="false" accepts-tab="false" wrap-mode="2" left-margin="5" right-margin="5"'"${scrollbars}"'>' \
'        <variable export="false">'$1'c</variable>' \
'        <input file>'"${INPUTSTEM}-$1"c'</input>' \
"        <width>${CAPTION_WIDTH}</width>" \
"        <height>${CAPTION_HEIGHT}</height>" \
'      </edit>' \
'    </vbox>' \
'  </eventbox>' \
'</vbox>'
}

# Main window [[[1
maxcol=${MAXSLOT}
maxrow=1
# Calculate starting window dimensions (window IS resizable). [[[
WINDOW_SPACING=5 # gtkdialog default (value can be changed)
GENERATED_MARGIN=1 # by the generate_* functions (value can be changed)
GTK_FRAME_MARGIN=7 # constant, value taken from on-screen measure (don't change)
width_request=$((
  ${MAXSLOT} * ( (${CAPTION_WIDTH} > ${PICTURE_WIDTH} ? ${CAPTION_WIDTH} : ${PICTURE_WIDTH}) )
  + 2 * ${MAXSLOT} * ( ${GTK_FRAME_MARGIN} + ${GENERATED_MARGIN} -2) +1
))
# Pixel-perfect corrections: -2 and +1 are empirical corrections for
# a 180x120 picture size with GENERATED_MARGIN=0.  Possibly these
# corrections are needed because gtkdialog's calculations are off by
# some amount?

height_request=$(( 77 + ${CAPTION_HEIGHT} + ${PICTURE_HEIGHT} ))
#]]]
# $TITLE is inherited from tap.sh's environment.
# Widget 'name' attributes are defined in files gtkrc-2.0 and gtk3.css in this folder.
cat > "${INPUTSTEM%/*}/.viewer.xml" << EOF
<window name="FilmstripWindow" title="${TITLE}" icon-name="filmstrip" width-request="${width_request}" height-request="${height_request}">
  <vbox spacing="${WINDOW_SPACING}">
    ${REMARK# [[[. Image+Caption Frames.}
$(y=0; while [ $y -lt $maxrow ]; do
echo '    <hbox>'
  x=0; while [ $x -lt $maxcol ]; do
    v=y${y}x${x}
echo '      <frame>'
echo '        <vbox spacing="0">'
                generate_pixmap $v 10:'          '
                generate_caption $v 10:'          '
echo '        </vbox>'
echo '      </frame>'
    x=$((x + 1))
  done
echo '    </hbox>'
  y=$((y + 1))
done)
    ${REMARK# ]]]}
    ${REMARK# [[[. Button Bar.}
    <vbox space-fill="false" space-expand="false">
      <eventbox name="FilmstripButtonBar">
        <hbox space-fill="false" space-expand="false">
          ${REMARK# This widget makes the widgets to its left float left and distribute evenly when the window is widened.}
          <text space-fill="true" space-expand="true"><label>""</label></text>
          <button tooltip-text="$(gettext "Roll Pictures Left [Alt+PageUp]")" stock-icon-size="1">
            <input file stock="gtk-go-back"></input>
            <action>date +'PageUp %s' >'${FNRRPC}'</action>
          </button>
          <button tooltip-text="$(gettext "Roll Pictures Right [Alt+PageDown]")" stock-icon-size="1">
            <input file stock="gtk-go-forward"></input>
            <action>date +'PageDown %s' >'${FNRRPC}'</action>
          </button>
          <button tooltip-text="$(gettext "Focus Search Window [F2]")">
            <input file icon="findnrun"></input>
            <action>date +"PresentMainSearchInput %s" > "${FNRRPC}"</action>
          </button>
          <button tooltip-text="$(gettext "Reload All Images [F5]")" stock-icon-size="1">
            <input file stock="gtk-refresh"></input>
            <action>. "${INPUTSTEM%/*}/.btn-restart-search.sh"; date +'RestartSearch %s' >'${FNRRPC}'</action>
          </button>
          <button tooltip-text="$(gettext "Help [F1]")" stock-icon-size="1">
            <input file stock="gtk-help"></input>
            <action>v=\$(which mdview 2>/dev/null || echo xdg-open); f="${0%/*}/index.md"; \$v "\$f" &</action>
          </button>
          <button tooltip-text="$(gettext "Exit Filmstrip [Esc]")" stock-icon-size="1">
            <input file stock="gtk-quit"></input>
            <action>exit:EXIT</action>
          </button>
        </hbox>
      </eventbox>
    </vbox>
    ${REMARK# ]]]}
    ${REMARK# [[[. Menubar (nearly hidden 1x1).}
    ${REMARK# So the menubar implements hotkey handlers as menu accelerators, which are fast.}
    ${REMARK# Note that menu accelerators act globally, so these hotkeys really apply to all widgets.}
    <menubar height-request="1" width-request="1">
      <menu>
      ${REMARK#   [[[. Keys Alt+PageUp/PageDown invoke the current source plugin tap.}
      ${REMARK# Note that we serialize (%s) the event name to ensure invokeTAP detects a change.}
      <menuitem accel-key="0xff55" accel-mods="8">
        <action>date '+PageUp %s'>'${FNRRPC}'</action>
      </menuitem>
      <menuitem accel-key="0xff56" accel-mods="8">
        <action>date '+PageDown %s'>'${FNRRPC}'</action>
      </menuitem>
      ${REMARK#   ]]]}
      ${REMARK#   [[[. Key ESC closes the viewer window.}
      <menuitem accel-key="0xff1b" accel-mods="0">
        <action>closewindow:PLUGIN_filmstrip</action>
      </menuitem>
      ${REMARK#   ]]]}
      ${REMARK#   [[[. Key F1 invokes the help viewer.}
      <menuitem accel-key="0xffbe" accel-mods="0">
        <action>v=\$(which mdview 2>/dev/null || echo xdg-open); f="${0%/*}/index.md"; \$v "\$f" &</action>
      </menuitem>
      ${REMARK#   ]]]}
      ${REMARK#   [[[. Key F2 changes input focus to findnruns search input field.}
      <menuitem accel-key="0xffbf" accel-mods="0">
        <action>date +"PresentMainSearchInput %s" > "${FNRRPC}"</action>
      </menuitem>
      ${REMARK#   ]]]}
      ${REMARK#   [[[. Key F5 rebuilds the data cache.}
      <menuitem accel-key="0xffc2" accel-mods="0">
        <action>. "${INPUTSTEM%/*}/.btn-restart-search.sh"; date +'RestartSearch %s' >'${FNRRPC}'</action>
      </menuitem>
      ${REMARK#   ]]]}
        <label>""</label>
      </menu>
    </menubar>
    ${REMARK# ]]]}
  </vbox>
  ${REMARK# --------------------------------------------}
  ${REMARK#   Only invisible widgets below this line.   }
  ${REMARK# --------------------------------------------}
  ${REMARK# [[[. Automation.}
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
  ${REMARK#  [[[. One-time start-up actions.}
  ${REMARK# --- Before showing this window ---}
  ${REMARK# Subscribe to findnruns killing service.}
  <entry visible="false" sensitive="false">
    <variable export="false">KILLPID</variable>
    <input>ps -ho ppid:1 \$\$ >> "${PIDF}"</input>
  </entry>
  ${REMARK# ]]]}
  ${REMARK# --- After showing this window. [[[-}
  <timer milliseconds="true" interval="100" visible="false">
    <variable export="false">TIMER0</variable>
    <action>disable:TIMER0</action>
    ${REMARK# Give focus to findnruns search input widget.}
    <action>date +"PresentMainSearchInput %s" > "${FNRRPC}"</action>
  </timer>
  ${REMARK# -]]]}
  ${REMARK# ]]]}
  <action signal="delete-event">exit:abort</action>
  <variable>PLUGIN_filmstrip</variable>
</window>
EOF

#[[[1]]]
"${GTKDIALOG:-gtkdialog}" --space-expand=true --space-fill=true \
  "${GTK_STYLES}" -s < "${INPUTSTEM%/*}/.viewer.xml" >/dev/null

# wait # to handle trap

# vim: foldmarker=[[[,]]]:
