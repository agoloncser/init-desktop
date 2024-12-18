#!/bin/sh

case $1 in
    modelm)
        gsettings set org.gnome.desktop.input-sources xkb-options "['caps:ctrl_modifier', 'ctrl:nocaps', 'lv3:ralt_switch', 'ctrl:swap_lwin_lctl']"
        ;;
    win)
        gsettings set org.gnome.desktop.input-sources xkb-options "['caps:ctrl_modifier', 'ctrl:nocaps', 'lv3:ralt_switch']"
        ;;
    mac)
        gsettings set org.gnome.desktop.input-sources xkb-options "['caps:ctrl_modifier', 'ctrl:nocaps', 'lv3:ralt_switch', 'altwin:swap_alt_win']"
        ;;
    *)
        cat <<EOF
Choose valid option:
$0 win|mac|modelm
EOF
        exit 1
esac

