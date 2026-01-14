#!/bin/bash

KWINRC="$HOME/.config/kwinrc"
KVANTUM_CONFIG="$HOME/.config/Kvantum/kvantum.kvconfig"

touch "$KWINRC"
touch "$KVANTUM_CONFIG"

setKvantumTheme(){
    local section="[General]"
    local setting="theme=Titanium-Dark"

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
    echo "kvantum theme set."
}

removeTitlebar () {
    local section="[Windows]"
    local setting="BorderlessMaximizedWindows=true"

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
    echo -e "window titlebar disabled when fullscreen."
}

installFiles(){

    local wallpaper_dir="$HOME/.local/share/wallpapers"
    local colorschemes_dir="$HOME/.local/share/color-schemes"
    local kvantum_dir="$HOME/.config/Kvantum"
    local lookandfeel_dir="$HOME/.local/share/plasma/look-and-feel"

    mkdir -p "$wallpaper_dir"
    mkdir -p "$colorschemes_dir"
    mkdir -p "$kvantum_dir"

    echo "installing wallpapers..."
    if [ -d "$wallpaper_dir/TitaniumDark" ]; then
        echo "wallpaper is already set."
    else
        cp -r "./wallpapers" "$wallpaper_dir/TitaniumDark"
    fi

    echo "installing color scheme..."
    cp  "./colors/TitaniumDark.colors" "$colorschemes_dir/"

    echo "installing kvantum theme..."
    if [ -d "$kvantum_dir/Titanium-Dark" ]; then
        echo "kvantum is already set."
    else
        cp -r "./kvantum" "$kvantum_dir/Titanium-Dark"
    fi

    echo "installing global theme..."
    if [ -d "${lookandfeel_dir}/Titanium-Dark" ]; then
        echo "global theme is already set."
    else
        cp -r "./look-and-feel" "$lookandfeel_dir/Titanium-Dark"
    fi
    echo "installation completed."
}

setKvantumTheme
removeTitlebar
installFiles
# plasmashell --replace & disown
