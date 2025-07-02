#!/bin/bash
blc -build --release
echo "Creating application bundle"
rm -r -f Tine.AppDir
mkdir -p Tine.AppDir/usr/bin
mkdir -p Tine.AppDir/usr/lib
mkdir -p Tine.AppDir/usr/share/applications
mkdir -p Tine.AppDir/usr/share/icons/hicolor/256x256/apps

cp Tine Tine.AppDir/usr/bin/
cp icon/icon_256x256.png Tine.AppDir/usr/share/icons/hicolor/256x256/apps/Tine.png
echo -e "[Desktop Entry]\nName=Tine\nExec=Tine\nIcon=Tine\nType=Application\nCategories=Utility\n" > Tine.AppDir/usr/share/applications/Tine.desktop
# export NO_STRIP=true

if [[ ! -f filename ]];
then
	echo "Downloading appimagetool..."
	wget -c --content-disposition 'https://github.com/AppImage/appimagetool/releases/download/continuous/appimagetool-x86_64.AppImage' && \
	chmod +x *.AppImage;
fi

if [[ ! -f filename ]];
then
	echo "Downloading linuxdeploy..."
	wget -c --content-disposition 'https://github.com/linuxdeploy/linuxdeploy/releases/download/continuous/linuxdeploy-x86_64.AppImage' && \
	chmod +x *.AppImage;
fi

./linuxdeploy-x86_64.AppImage --appdir Tine.AppDir --output appimage
./appimagetool-x86_64.AppImage Tine.AppDir

chmod +x *.AppImage
