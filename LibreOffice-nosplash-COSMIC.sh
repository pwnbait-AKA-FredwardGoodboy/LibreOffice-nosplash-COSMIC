#!/bin/bash
#
########################################################################################
# Script courtesy of redditor u/kleggich, 2025.11.17, bumping a months-old post.       #
# AI assisted via Gemini-CLI because I write spaghetti code and don't document.        #
#                    Boo hiss, it's better at this than me.                            #
# Available on github @ pwnbait-AKA-FredwardGoodboy/LibreOffice-nosplash-COSMIC        #
# Distribute freely, modify to your own needs. Licenses are for vehicles and firearms. #
#                     (and televisions if you're British)                              #
#                                                                                      #
# This is a shell script to remove the splash from the LibreOffice suite.              #
# In Pop!_OS 24.04 COSMIC (Wayland), the splash becomes an interminable window.        #
# The window cannot be alt+tabbed, nor moved, and remains resident                     #
# even after killing all Libre Office processes.                                       #
#                                                                                      #
# As much as I love COSMIC, its security is also its greatest design flaw.             #
#     (>* *)> All I wanted was xfce4-eyes-plugin and tiling. <(* *<)                   #
########################################################################################
#
#
# Define the source directories for .desktop files
APT_SOURCE_DIR="/usr/share/applications"
FLATPAK_SOURCE_DIR="$HOME/.local/share/flatpak/exports/share/applications"

# Define the destination directory where the .desktop files will be copied and modified
DEST_DIR="$HOME/.local/share/applications"

# List of LibreOffice .desktop files to process
APT_DESKTOP_FILES=(
    "libreoffice-calc.desktop"
    "libreoffice-draw.desktop"
    "libreoffice-impress.desktop"
    "libreoffice-math.desktop"
    "libreoffice-startcenter.desktop"
    "libreoffice-writer.desktop"
    "libreoffice-xsltfilter.desktop"
)

FLATPAK_DESKTOP_FILES=(
    "org.libreoffice.LibreOffice.base.desktop"
    "org.libreoffice.LibreOffice.calc.desktop"
    "org.libreoffice.LibreOffice.draw.desktop"
    "org.libreoffice.LibreOffice.impress.desktop"
    "org.libreoffice.LibreOffice.math.desktop"
    "org.libreoffice.LibreOffice.writer.desktop"
    "org.libreoffice.LibreOffice.xsltfilter.desktop"
)
    

echo "Automating LibreOffice splash screen removal (including copying files)..."

# Ensure the destination directory exists
mkdir -p "$DEST_DIR"

for file in "${APT_DESKTOP_FILES[@]}"; do
    APT_SOURCE_FILE_PATH="$APT_SOURCE_DIR/$file"
    DEST_FILE_PATH="$DEST_DIR/$file"

    if [ -f "$APT_SOURCE_FILE_PATH" ]; then
        echo "Processing $file..."
        
        # Copy the file to the user's local applications directory
        echo "Copying $file to $DEST_DIR..."
        cp "$APT_SOURCE_FILE_PATH" "$DEST_FILE_PATH"
        
        # Use sed to add --nologo flag
        # If '%U' is present, insert '--nologo' before it.
        # Otherwise, append '--nologo' to the end of the line.
        sed -i '/^Exec=/ {s/ %U/ --nologo %U/;t;s/$/ --nologo/}' "$DEST_FILE_PATH"
        echo "Modified $file"
    else
        echo "Warning: Source file $file not found at $SOURCE_FILE_PATH. Skipping."
    fi
done

for file in "${FLATPAK_DESKTOP_FILES[@]}"; do
    FLATPAK_SOURCE_FILE_PATH="$FLATPAK_SOURCE_DIR/$file"
    DEST_FILE_PATH="$DEST_DIR/$file"

    if [ -f "$FLATPAK_SOURCE_FILE_PATH" ]; then
        echo "Processing $file..."
        
        # Copy the file to the user's local applications directory
        echo "Copying $file to $DEST_DIR..."
        cp "$FLATPAK_SOURCE_FILE_PATH" "$DEST_FILE_PATH"
        
        # Use sed to add --nologo flag
        # If '%U' is present, insert '--nologo' before it.
        # Otherwise, append '--nologo' to the end of the line.
        sed -i '/^Exec=/ {s/ %U/ --nologo %U/;t;s/$/ --nologo/}' "$DEST_FILE_PATH"
        echo "Modified $file"
    else
        echo "Warning: Source file $file not found at $FLATPAK_SOURCE_FILE_PATH. Skipping."
    fi
done
echo "LibreOffice splash screen automation complete."
echo "You may need to log out and back in, or restart your session, for changes to take effect."
echo "Brought to you by the number 4, the letter R, and the sound stylings of"
echo "Khalifa Ould Eide & Dimi Mint Abbas - Waidalal Waidalal"