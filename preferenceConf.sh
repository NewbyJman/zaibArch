sudo mkdir -p ~/.local/share/gitMedia
sudo cp -f ~/arch-install-scripts/media/* ~/.local/share/gitMedia/

echo "Import custom icons, cursors and themes? (Y/n): "
read imResponse
if [ $imResponse -eq "n" ]; then
    imStyles="n"
else
    imStyles="y"
    echo "Remove default icons, cursors and themes? (Y/n): "
    read rmResponse
    if [ $rmResponse -eq "n" ]; then
        rmStyles="n"
    else
        rmStyles="y"
    fi
fi

echo "Select your environment:"
echo "1. zaibCustom"
echo "2. KDE plasma"
echo "3. XFCE"
echo "4. OpenBox"
read envResponse

if [ $envResponse -eq 1 ]; then
    sh custom/preferences.sh $imStyles $rmStyles
elif [ $envResponse -eq 2 ]; then
    sh preferences/KDE.sh $imStyles $rmStyles
elif [ $envResponse -eq 3 ]; then
    sh preferences/xfce.sh $imStyles $rmStyles
elif [ $envResponse -eq 4 ]; then
    sh preferences/openbox.sh $imStyles $rmStyles
fi