#!/bin/bash

KWINRC="$HOME/.config/kwinrc"
KVANTUM_CONFIG="$HOME/.config/Kvantum/kvantum.kvconfig"

wallpaper_dir="$HOME/.local/share/wallpapers/TitaniumDark"
colorscheme="$HOME/.local/share/color-schemes/TitaniumDark.colors"
kvantum_dir="$HOME/.config/Kvantum/Titanium-Dark"
lookandfeel_dir="$HOME/.local/share/plasma/look-and-feel/Titanium-Dark"

fixWindowTitle(){
    local section="[Windows]"
    local setting="BorderlessMaximizedWindows=false"

    mkdir -p "$(dirname "$KWINRC")"

    if grep -q "^\s*\[Windows\]\s*$" "$KWINRC"; then
        if grep -q "^BorderlessMaximizedWindows=" "$KWINRC"; then
            sed -i "s|^BorderlessMaximizedWindows=.*|$setting|" "$KWINRC"
        else
            sed -i "/^\[Windows\]$/a $setting" "$KWINRC"
        fi
    else
        echo -e "\n$section\n$setting\n" >> "$KWINRC"
    fi
    echo -e "> window titlebar will be shown when fullscreen."

}

unsetKvantum(){
    local section="[General]"
    local setting="theme="

    mkdir -p "$(dirname "$KVANTUM_CONFIG")"

    if grep -q "^\s*\[General\]\s*$" "$KVANTUM_CONFIG"; then
        if grep -q "^theme=" "$KVANTUM_CONFIG"; then
            sed -i "s|^theme=.*|$setting|" "$KVANTUM_CONFIG"
        else
            sed -i "/^\[General\]$/a $setting" "$KVANTUM_CONFIG"
        fi 
    else
        echo -e "\n$section\n$setting\n" >> "$KVANTUM_CONFIG"
    fi
    echo "> kvantum theme unset."
    
}

remove_files(){
    echo -e "> removing wallpaper...\n"
    rm -r $wallpaper_dir
   
   echo -e "> removing color scheme...\n"
   rm $colorscheme
   
   echo -e "> removing kvantum theme...\n"
   rm -r $kvantum_dir
   
   echo -e "> removing global theme and splash screen...\n"
   rm -r $lookandfeel_dir
}

fixWindowTitle
unsetKvantum
remove_files
echo -e "uninstallation finished.\n"
echo "it can take a while to changes start to appear"
echo -e "Note: this script did not remove kvantum manager because of you might already using it.\n
if you wanna delete anyway you can type \n\n\"sudo dnf/apt/pacman remove -y kvantum\"\n\non your terminal."
plasmashell --replace & disown