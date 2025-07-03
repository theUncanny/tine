#!/bin/bash

build()
{

    echo '--------------------------------------------------------------'
    echo 'Building Tine...'
    echo '--------------------------------------------------------------'

    blc --verbose -build --release
}

appimage_bootstrap()
{

    echo '--------------------------------------------------------------'
    echo 'Creating application bundle...'
    echo '--------------------------------------------------------------'

    rm -r -f Tine.AppDir
    mkdir -p Tine.AppDir/usr/bin
    mkdir -p Tine.AppDir/usr/lib
    mkdir -p Tine.AppDir/usr/share/applications
    mkdir -p Tine.AppDir/usr/share/icons/hicolor/256x256/apps

    cp Tine Tine.AppDir/usr/bin/
    cp icon/icon_256x256.png Tine.AppDir/usr/share/icons/hicolor/256x256/apps/Tine.png
    echo -e "[Desktop Entry]\nName=Tine\nExec=Tine\nIcon=Tine\nType=Application\nCategories=Utility\n" > Tine.AppDir/usr/share/applications/Tine.desktop
    # export NO_STRIP=true

}

appimage_check_tools()
{

    if [[ ! -f "./appimagetool-x86_64.AppImage" ]];
    then
        echo '--------------------------------------------------------------'
        echo 'Downloading appimagetool...'
        echo '--------------------------------------------------------------'

        wget -c --content-disposition 'https://github.com/AppImage/appimagetool/releases/download/continuous/appimagetool-x86_64.AppImage' && \
        chmod +x *.AppImage;
    fi

    if [[ ! -f "./linuxdeploy-x86_64.AppImage" ]];
    then
        echo '--------------------------------------------------------------'
        echo 'Downloading linuxdeploy...'
        echo '--------------------------------------------------------------'

        wget -c --content-disposition 'https://github.com/linuxdeploy/linuxdeploy/releases/download/continuous/linuxdeploy-x86_64.AppImage' && \
        chmod +x *.AppImage;
    fi

}

appimage_generate()
{

    echo '--------------------------------------------------------------'
    echo 'Generating AppImage...'
    echo '--------------------------------------------------------------'

    ./linuxdeploy-x86_64.AppImage --appdir Tine.AppDir --output appimage
    ./appimagetool-x86_64.AppImage Tine.AppDir

    chmod +x *.AppImage

}

main()
{

    build;
    appimage_check_tools;
    appimage_bootstrap;
    appimage_generate;

}

main;
