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
