XML_LOCATION=~/.config/xfce4/xfconf/xfce-perchannel-xml
USER_NAME=zaib
REPO_DIR=/home/$USER_NAME/zaibArch

# Import media
sudo mkdir -p $XML_LOCATION
sudo mkdir -p /home/$USER_NAME/.local/share/gitMedia
sudo cp -f $REPO_DIR/media/* /home/$USER_NAME/.local/share/gitMedia/

# Configure SDDM
echo "Downloading sddm theme"
sudo rm -r /usr/share/sddm/themes/*
sudo bash -c 'echo "[Theme]" >> /usr/lib/sddm/sddm.conf.d/sddm.conf'
sudo bash -c 'echo "Current=zaib-purple" >> /usr/lib/sddm/sddm.conf.d/sddm.conf'
sudo bash -c 'sed -i "s/^Current=.*/Current=zaib-purple/" /lib/sddm/sddm.conf.d/default.conf'
sudo bash -c 'sed -i "s/^CursorTheme=.*/CursorTheme=Dracula-cursors/" /lib/sddm/sddm.conf.d/default.conf'
sudo cp /home/$USER_NAME/.local/share/gitMedia/gintoki.png /usr/share/sddm/faces/$USER_NAME.face.icon
sudo cp /home/$USER_NAME/.local/share/gitMedia/gintoki.png /home/$USER_NAME/.face
sudo mkdir -p /usr/share/sddm/themes
sudo cp -f $REPO_DIR/sddm/zaib-purple /usr/share/sddm/themes/zaib-purple

# Download global theme, cursors, icons
echo "Downloading Dracula-purple kde theme"
cd /usr/share/themes
sudo mkdir -p Dracula
sudo git clone https://github.com/dracula/gtk.git
sudo mv -f gtk/kde/cursors/Dracula-cursors /usr/share/icons
sudo rm -r gtk

yay -S dracula-gtk-theme --noconfirm --removemake --noanswerclean --noanswerdiff --needed

echo "Adding icons"
sudo pacman -S papirus --noconfirm --needed
yay -S papirus-folders-git --noconfirm --removemake --noanswerclean --noanswerdiff --needed
papirus-folders -C violet --theme Papirus
papirus-folders -C violet --theme Papirus-Dark
sudo pacman -S python-cairosvg --noconfirm --needed
sudo python3 $REPO_DIR/iconSetter/icons.py
sudo rm -r /usr/share/icons/Papirus-Light

# Configure global theme, cursor, icons
xfconf-query -c xsettings -p /Net/ThemeName -n -t string -s "Dracula"
xfconf-query -c xsettings -p /Net/IconThemeName -n -t string -s "Papirus-Dark"
xfconf-query -c xsettings -p /Gtk/FontName -n -t string -s "System-ui 10"
xfconf-query -c xsettings -p /Gtk/MonospaceFontName -n -t string -s "Noto Sans Regular 10"
xfconf-query -c xsettings -p /Gtk/CursorThemeName -n -t string -s "Dracula-cursors"

xfconf-query -c xfwm4 -p /general/borderless_maximize -s "true"
xfconf-query -c xfwm4 -p /general/click_to_focus -s "true"
xfconf-query -c xfwm4 -p /general/cycle_apps_only -s "false"
xfconf-query -c xfwm4 -p /general/cycle_draw_frame -s "false"
xfconf-query -c xfwm4 -p /general/cycle_raise -s "true"
xfconf-query -c xfwm4 -p /general/cycle_hidden -s "true"
xfconf-query -c xfwm4 -p /general/cycle_preview -s "true"
xfconf-query -c xfwm4 -p /general/double_click_action -s "maximize"
xfconf-query -c xfwm4 -p /general/theme -s "Default"
xfconf-query -c xfwm4 -p /general/title_alignment -s "left"
xfconf-query -c xfwm4 -p /general/title_font -s "System-ui Bold 11"
xfconf-query -c xfwm4 -p /general/snap_to_border -s true
xfconf-query -c xfwm4 -p /general/snap_to_windows -s true
xfconf-query -c xfwm4 -p /general/snap_width -s 10
xfconf-query -c xfwm4 -p /general/wrap_windows -s false
xfconf-query -c xfwm4 -p /general/wrap_workspaces -s false
xfconf-query -c xfwm4 -p /general/workspace_count -s 1
xfconf-query -c xfwm4 -p /general/wrap_resistance -s 10

# Configure desktop
sudo rm -f $XML_LOCATION/xfce4-desktop.xml
cat <<EOT >> $XML_LOCATION/xfce4-desktop.xml
<?xml version="1.0" encoding="UTF-8"?>
<channel name="xfce4-desktop" version="1.0">
<property name="backdrop" type="empty">
    <property name="screen0" type="empty">
    <property name="monitor0" type="empty">
    <property name="image-path" type="string" value="/home/zaib/.local/share/gitMedia/wallpaper.png"/>
    <property name="image-show" type="bool" value="true"/>
    <property name="image-style" type="int" value="5"/>
    </property>
    </property>
</property>
<property name="desktop-icons" type="empty">
    <property name="show-hidden-files" type="bool" value="false"/>
    <property name="show-removable" type="bool" value="true"/>
    <property name="show-home" type="bool" value="true"/>
    <property name="show-trash" type="bool" value="false"/>
    <property name="show-filesystem" type="bool" value="false"/>
    <property name="primary" type="bool" value="true"/>
</property>
<property name="desktop-menu" type="empty">
    <property name="show" type="bool" value="false"/>
</property>
</channel>
EOT

# Docklike Taskbar
mkdir -p /home/$USER_NAME/.config/xfce4/panel
cat <<EOT >> /home/$USER_NAME/.config/xfce4/panel/docklike-2.rc
[user]
showPreviews=true
indicatorStyle=1
inactiveIndicatorStyle=1
forceIconSize=true
iconSize=32
keyComboActive=true
EOT

# Keymap mapping
xfconf-query -c xfce4-keyboard-shortcuts -p /commands/custom -r -R
xfconf-query -c xfce4-keyboard-shortcuts -p /commands/custom -n -t "string" -s "replace me"
sed -i 's/type="string" value="replace me"/type="empty"/g' $XML_LOCATION/xfce4-keyboard-shortcuts.xml
xfconf-query -c xfce4-keyboard-shortcuts -p /commands/custom/override -n -t bool -s true
xfconf-query -c xfce4-keyboard-shortcuts -p /commands/custom/"<Primary>Print" -n -t string -s "flameshot gui"
xfconf-query -c xfce4-keyboard-shortcuts -p /commands/custom/"<Super>p" -n -t string -s "xfce4-display-settings --minimal"
xfconf-query -c xfce4-keyboard-shortcuts -p /commands/custom/"<Primary><Shift>Escape" -n -t string -s "lxtask"
xfconf-query -c xfce4-keyboard-shortcuts -p /commands/custom/"<Super>l" -n -t string -s "xfce4-session-logout"
xfconf-query -c xfce4-keyboard-shortcuts -p /commands/custom/"<Primary>Super_L" -n -t string -s "xfce4-popup-whiskermenu"
xfconf-query -c xfce4-keyboard-shortcuts -p /commands/custom/"<Super>e" -n -t string -s "thunar"
xfconf-query -c xfce4-keyboard-shortcuts -p /commands/custom/"<Super>t" -n -t string -s "xfce4-terminal"
xfconf-query -c xfce4-keyboard-shortcuts -p /commands/custom/"<Super>b" -n -t string -s "chromium --incognito google.co.uk"
xfconf-query -c xfce4-keyboard-shortcuts -p /xfwm4/custom/"<Super><Alt>l" -n -t string -s "tile_right_key"xfconf-query -c xfce4-keyboard-shortcuts -p /xfwm4/custom/"<Super><Alt>h" -n -t string -s "tile_left_key"
xfconf-query -c xfce4-keyboard-shortcuts -p /xfwm4/custom/"<Super><Alt>k" -n -t string -s "tile_up_key"
xfconf-query -c xfce4-keyboard-shortcuts -p /xfwm4/custom/"<Super><Alt>j" -n -t string -s "tile_down_key"
xfconf-query -c xfce4-keyboard-shortcuts -p /xfwm4/custom/"<Super><Shift>l" -n -t string -s "tile_up_right_key"
xfconf-query -c xfce4-keyboard-shortcuts -p /xfwm4/custom/"<Super><Shift>h" -n -t string -s "tile_up_left_key"
xfconf-query -c xfce4-keyboard-shortcuts -p /xfwm4/custom/"<Super><Primary>l" -n -t string -s "tile_down_right_key"
xfconf-query -c xfce4-keyboard-shortcuts -p /xfwm4/custom/"<Super><Primary>h" -n -t string -s "tile_down_left_key"
mkdir -p /home/$USER_NAME/.config/parcellite
sudo cp -f $REPO_DIR/configs/parcelliterc /home/$USER_NAME/.config/parcellite/

# power management and screensaver
echo "screensaver"
sudo rm -f $XML_LOCATION/xfce4-screensaver.xml
cat <<EOT >> $XML_LOCATION/xfce4-screensaver.xml
<?xml version="1.0" encoding="UTF-8"?>
<channel name="xfce4-screensaver" version="1.0">
<property name="saver" type="empty">
    <property name="mode" type="int" value="2"/>
    <property name="themes" type="empty">
    <property name="list" type="array">
        <value type="string" value="screensavers-xfce-floaters"/>
    </property>
    </property>
</property>
<property name="lock" type="empty">
    <property name="enabled" type="bool" value="true"/>
    <property name="sleep-activation" type="bool" value="true"/>
</property>
</channel>
EOT

echo "session management"
sudo rm -f $XML_LOCATION/xfce4-session.xml
cat <<EOT >> $XML_LOCATION/xfce4-session.xml
<?xml version="1.0" encoding="UTF-8"?>
<channel name="xfce4-session" version="1.0">
<property name="general" type="empty">
    <property name="AutoSave" type="bool" value="false"/>
    <property name="SaveOnExit" type="bool" value="false"/>
    <property name="PromptOnLogout" type="bool" value="true"/>
</property>
<property name="shutdown" type="empty">
    <property name="LockScreen" type="bool" value="true"/>
</property>
<property name="chooser" type="empty">
    <property name="AlwaysDisplay" type="bool" value="false"/>
</property>
</channel>
EOT

echo "power management"
sudo rm -f $XML_LOCATION/xfce4-power-manager.xml
cat <<EOT >> $XML_LOCATION/xfce4-power-manager.xml
<?xml version="1.0" encoding="UTF-8"?>
<channel name="xfce4-power-manager" version="1.0">
<property name="xfce4-power-manager" type="string" value="replace me">
    <property name="brightness-store-restore-on-exit" type="int" value="1"/>
    <property name="brightness-store" type="bool" value="false"/>
    <property name="lock-screen-suspend-hibernate" type="bool" value="true"/>
    <property name="lid-action-on-ac" type="uint" value="1"/>
    <property name="inactivity-on-ac" type="uint" value="30"/>
    <property name="dpms-on-ac-sleep" type="uint" value="0"/>
    <property name="blank-on-ac" type="int" value="0"/>
    <property name="brightness-switch-restore-on-exit" type="int" value="1"/>
    <property name="brightness-switch" type="int" value="0"/>
    <property name="show-tray-icon" type="bool" value="false"/>
    <property name="show-presentation-indicator" type="bool" value="false"/>
    <property name="show-panel-label" type="int" value="0"/>
    <property name="inactivity-sleep-mode-on-ac" type="uint" value="1"/>
    <property name="dpms-enabled" type="bool" value="false"/>
    <property name="inactivity-sleep-mode-on-battery" type="uint" value="1"/>
    <property name="brightness-on-battery" type="uint" value="60"/>
    <property name="blank-on-battery" type="int" value="0"/>
    <property name="dpms-on-battery-sleep" type="uint" value="0"/>
    <property name="power-button-action" type="uint" value="1"/>
    <property name="critical-power-action" type="uint" value="1"/>
    <property name="critical-power-level" type="uint" value="5"/>
    <property name="inactivity-on-battery" type="uint" value="30"/>
    <property name="brightness-on-ac" type="uint" value="60"/>
    <property name="lid-action-on-battery" type="uint" value="1"/>
    <property name="brightness-level-on-battery" type="uint" value="20"/>
    <property name="brightness-exponential" type="bool" value="false"/>
    <property name="dpms-on-battery-off" type="uint" value="0"/>
    <property name="dpms-on-ac-off" type="uint" value="0"/>
    <property name="brightness-level-on-ac" type="uint" value="20"/>
    <property name="sleep-button-action" type="uint" value="0"/>
</property>
</channel>
EOT

# Notifications
echo "Notifications"
sudo rm -f $XML_LOCATION/xfce4-notifyd.xml
cat <<EOT >> $XML_LOCATION/xfce4-notifyd.xml
<?xml version="1.0" encoding="UTF-8"?>
<channel name="xfce4-notifyd" version="1.0">
    <property name="log-max-size-enabled" type="bool" value="true"/>
    <property name="plugin" type="string" value="replace me">
        <property name="hide-on-read" type="bool" value="true"/>
        <property name="log-icon-size" type="int" value="15"/>
        <property name="log-only-today" type="bool" value="true"/>
    </property>
</channel>
EOT

# Thunar
echo "Thunar"
sudo rm -f $XML_LOCATION/xfce4-thunar.xml
cat <<EOT >> $XML_LOCATION/xfce4-thunar.xml
<?xml version="1.0" encoding="UTF-8"?>
<channel name="thunar" version="1.0">
    <property name="last-view" type="string" value="ThunarIconView"/>
    <property name="last-icon-view-zoom-level" type="string" value="THUNAR_ZOOM_LEVEL_220_PERCENT"/>
    <property name="last-window-maximized" type="bool" value="true"/>
    <property name="last-separator-position" type="int" value="170"/>
    <property name="last-location-bar" type="string" value="ThunarLocationButtons"/>
    <property name="last-image-preview-visible" type="bool" value="false"/>
    <property name="misc-single-click" type="bool" value="false"/>
    <property name="misc-open-new-window-as-tab" type="bool" value="true"/>
    <property name="misc-thumbnail-mode" type="string" value="THUNAR_THUMBNAIL_MODE_ALWAYS"/>
    <property name="misc-middle-click-in-tab" type="bool" value="true"/>
    <property name="misc-full-path-in-tab-title" type="bool" value="true"/>
    <property name="misc-recursive-permissions" type="string" value="THUNAR_RECURSIVE_PERMISSIONS_ASK"/>
    <property name="misc-recursive-search" type="string" value="THUNAR_RECURSIVE_SEARCH_NEVER"/>
    <property name="last-details-view-zoom-level" type="string" value="THUNAR_ZOOM_LEVEL_40_PERCENT"/>
    <property name="last-show-hidden" type="bool" value="true"/>
    <property name="last-menubar-visible" type="bool" value="false"/>
    <property name="last-toolbar-item-order" type="string" value="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18"/>
    <property name="last-toolbar-visible-buttons" type="string" value="0,1,1,0,0,0,0,0,0,0,0,0,0,0,1,0,1,0,0"/>
</channel>
EOT
sudo rm -f $XML_LOCATION/thunar-volman.xml
cat <<EOT >> $XML_LOCATION/thunar-volman.xml
<?xml version="1.0" encoding="UTF-8"?>

<channel name="thunar-volman" version="1.0">
  <property name="automount-drives" type="empty">
    <property name="enabled" type="bool" value="true"/>
  </property>
  <property name="automount-media" type="empty">
    <property name="enabled" type="bool" value="true"/>
  </property>
  <property name="autobrowse" type="empty">
    <property name="enabled" type="bool" value="true"/>
  </property>
</channel>
EOT

sudo mkdir -p /home/$USER_NAME/.config/gtk-3.0
sudo bash -c 'echo ".thunar toolbar image {-gtk-icon-style: regular;}" >> /home/$USER_NAME/.config/gtk-3.0/gtk.css'

# Thunar right click menu addons
mkdir -p /home/$USER_NAME/.config/Thunar
bash -c 'echo '\''(gtk_accel_path "<Actions>/ThunarWindow/switch-next-tab" "<Primary>Tab")'\'' >> /home/zaib/.config/Thunar/accels.scm'
sudo rm -f /home/$USER_NAME/.config/Thunar/uca.xml
cat <<EOT >> /home/$USER_NAME/.config/Thunar/uca.xml
<?xml version="1.0" encoding="UTF-8"?>
<actions>
<action>
    <icon>object-locked</icon>
    <name>Open as Root</name>
    <submenu></submenu>
    <unique-id>1713022049984740-1</unique-id>
    <command>pkexec thunar %f</command>
    <description>Opens directory as root</description>
    <range>*</range>
    <patterns>*</patterns>
    <directories/>
    <audio-files/>
    <image-files/>
    <other-files/>
    <text-files/>
    <video-files/>
</action>
<action>
    <icon>utilities-terminal</icon>
    <name>Open Terminal Here</name>
    <submenu></submenu>
    <unique-id>1713020166163568-1</unique-id>
    <command>exo-open --working-directory %f --launch TerminalEmulator</command>
    <description>Opens terminal in current directory</description>
    <range></range>
    <patterns>*</patterns>
    <startup-notify/>
    <directories/>
</action>
</actions>
EOT

# Mouse and touchpad
sudo rm -f $XML_LOCATION/pointers.xml
cat <<EOT >> $XML_LOCATION/pointers.xml
<?xml version="1.0" encoding="UTF-8"?>

<channel name="pointers" version="1.0">
<property name="SynPS2_Synaptics_TouchPad" type="empty">
    <property name="RightHanded" type="bool" value="true"/>
    <property name="ReverseScrolling" type="bool" value="true"/>
    <property name="Threshold" type="int" value="1"/>
    <property name="Acceleration" type="double" value="5"/>
    <property name="Properties" type="empty">
        <property name="libinput_Tapping_Enabled" type="int" value="1"/>
    </property>
    <property name="libinput_Tapping_Enabled" type="int" value="1"/>
</property>
</channel>
EOT

# Terminal
echo "terminal"
xfconf-query -c xfce4-terminal -p /misc-cursor-shape -n -t string -s "TERMINAL_CURSOR_SHAPE_IBEAM"
xfconf-query -c xfce4-terminal -p /misc-cursor-blinks -n -t bool -s true
xfconf-query -c xfce4-terminal -p /font-use-system -n -t bool -s false
xfconf-query -c xfce4-terminal -p /font-name -n -t string -s "Source Code Pro Medium 15"
xfconf-query -c xfce4-terminal -p /font-allow-bold -n -t bool -s true
xfconf-query -c xfce4-terminal -p /background-mode -n -t string -s "TERMINAL_BACKGROUND_TRANSPARENT"
xfconf-query -c xfce4-terminal -p /background-darkness -n -t double -s 0.9
xfconf-query -c xfce4-terminal -p /misc-menubar-default -n -t bool -s true
xfconf-query -c xfce4-terminal -p /misc-toolbar-default -n -t bool -s false
xfconf-query -c xfce4-terminal -p /title-mode -n -t string -s "TERMINAL_TITLE_HIDE"
xfconf-query -c xfce4-terminal -p /color-foreground -n -t string -s "#d2d25050ffff"
xfconf-query -c xfce4-terminal -p /color-background -n -t string -s "#0b840068da7"
xfconf-query -c xfce4-terminal -p /tab-activity-color -n -t string -s "1c1c7171d8d8"

# Mousepad
cd $REPO_DIR
git clone https://github.com/dracula/mousepad.git
mkdir -p /home/$USER_NAME/.local/share/gtksourceview-4/styles
cp -f $REPO_DIR/mousepad/dracula.xml /home/$USER_NAME/.local/share/gtksourceview-4/styles

gsettings set org.xfce.mousepad.preferences.view color-scheme 'dracula'
gsettings set org.xfce.mousepad.preferences.view font-name 'Source Code Pro Regular 12'
gsettings set org.xfce.mousepad.preferences.view show-line-numbers true
gsettings set org.xfce.mousepad.preferences.view tab-width 3
gsettings set org.xfce.mousepad.preferences.window recent-menu-items 5

# Import remaining conf files
sudo cp -f $REPO_DIR/configs/xfce4-panel.xml $XML_LOCATION/
sudo cp -f $REPO_DIR/configs/startup/* /etc/xdg/autostart/
