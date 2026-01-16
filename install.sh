#!/bin/bash

KWINRC="$HOME/.config/kwinrc"
KVANTUM_CONFIG="$HOME/.config/Kvantum/kvantum.kvconfig"

SCRIPT_DIR="look-and-feel/contents/plasmoidsetupscripts"

THEME_NAME="Titanium-Dark"

touch "$KWINRC"
touch "$KVANTUM_CONFIG"

setKvantumTheme(){
    local section="[General]"
    local setting="theme=$THEME_NAME"

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

    echo "installing kvantum..."
   
    
    if command -v kvantummanager >/dev/null 2>&1
    then
        echo "Kvantum Manager is already installed no need to reinstall."
    else
        sudo dnf install -y kvantum #fedora
        sudo apt install -y kvantum #ubuntu
        sudo pacman install -y kvantum #arch
    fi

    echo "installing kvantum theme..."
    if [ -d "$kvantum_dir/$THEME_NAME" ]; then
        echo "kvantum is already set."
    else
        cp -r "./kvantum" "$kvantum_dir/$THEME_NAME"
    fi

    echo "installing global theme..."
    if [ -d "${lookandfeel_dir}/$THEME_NAME" ]; then
        echo "global theme is already set."
    else
        cp -r "./look-and-feel" "$lookandfeel_dir/$THEME_NAME"
    fi
    echo "installation completed."
}

runScripts(){
    echo "running scripts..."
    for script in "$SCRIPT_DIR"/*.js; do
        if [ -f "$script" ]; then
            echo "Applying: $(basename $script)"
            # DBus üzerinden Plasma'ya JS komutunu gönderiyoruz
            qdbus org.kde.plasmashell /PlasmaShell org.kde.PlasmaShell.evaluateScript "$(cat "$script")"
        fi
    done
}

setKvantumTheme
removeTitlebar
installFiles
echo "activating theme..."
lookandfeeltool -a $THEME_NAME
runScripts
plasmashell --replace & disown
