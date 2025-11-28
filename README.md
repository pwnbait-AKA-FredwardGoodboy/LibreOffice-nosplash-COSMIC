# LibreOffice-nosplash-COSMIC
This is a bash shell script to remove the splash screen from the LibreOffice suite for better compatibility with the COSMIC (Wayland) desktop environment in Pop!_OS 24.04.

The Who: This script is intended to make it easier for users who may not be familiar with the processes involved, as Pop!_OS is increasingly being recommended to beginners wishing to migrate from a Windows environment with gaming in mind, as well as users with NVIDIA hardware, as it is not only supported out of the box, but often may contain performance improvements by default that are not included in other distributions.

The Why: Some users have experienced issues with launching LibreOffice in Pop!_OS 24.04. The splash screen appears, becomes stuck on top of other windows, and cannot be hidden, closed, or otherwise modified. They remain resident even if all LibreOffice processes are terminated. They are ghost windows, and probably a result of a feature of the compositor, rather than a bug. Windows in COSMIC (Wayland) are more or less sovereign entities and do not play nicely with others.

The What: The simplest solution to this problem is to use the built-in flags in LibreOffice to prevent the splash at program launch.

The Where and How: This script will attempt to copy the LibreOffice .desktop files from /usr/share/applications and ~/.local/share/flatpak/exports/share/applications/ to the friendlier ~/.local/share/applications/ so they will be persistent through package updates, and then modify the new .desktop files to include the --nologo flag in their EXEC= lines. For EXEC= lines that contain %U, the flag will be placed before the %U. For all others, it will be placed at the end of the line.

The When: 10,000 years in the belly of the Sarlacc, this script was AI optimized with Gemini-CLI. Putting myself out of business.

...but when you download this, be sure to run chmod +x on the file to make it executable.
