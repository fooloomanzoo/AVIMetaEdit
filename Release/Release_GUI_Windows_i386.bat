@rem echo off

rem --- Search binaries ---
set BPATH=
if exist "%~dp0\..\..\..\MediaArea-Utils-Binaries" set BPATH="%~dp0\..\..\..\MediaArea-Utils-Binaries"
if exist "%~dp0\..\..\MediaArea-Utils-Binaries" set BPATH="%~dp0\..\..\MediaArea-Utils-Binaries"
if "%BPATH%"=="" (
    echo "ERROR: binaries path not found"
    exit /b 1
)

@rem --- Clean up ---
del   AVI_MetaEdit_GUI_Windows_i386.exe
del   AVI_MetaEdit_GUI_Windows_i386_WithoutInstaller.7z
rmdir AVI_MetaEdit_GUI_Windows_i386 /S /Q
mkdir AVI_MetaEdit_GUI_Windows_i386


@rem --- Copying : Exe ---
copy  ..\Project\MSVC2015\GUI\Win32\Release\AVI_MetaEdit_GUI.exe AVI_MetaEdit_GUI_Windows_i386\avimetaedit-gui.exe

@rem --- Copying : Information files ---
copy ..\License.html AVI_MetaEdit_GUI_Windows_i386\
copy ..\History_GUI.txt AVI_MetaEdit_GUI_Windows_i386\History.txt
copy ..\conformance_point_document.xsd AVI_MetaEdit_GUI_Windows_i386\
copy ReadMe_GUI_Windows.txt AVI_MetaEdit_GUI_Windows_i386\ReadMe.txt


rem --- Compressing Archive ---
cd AVI_MetaEdit_GUI_Windows_i386\
%BPATH%\Windows\7-Zip\7z a -r -tzip -mx9 ..\AVI_MetaEdit_GUI_Windows_i386_WithoutInstaller.zip *
cd ..

rem --- Installer ---
%BPATH%\Windows\NSIS\makensis ..\Source\Install\AVI_MetaEdit_GUI_Windows_i386.nsi

rem --- Clean up ---
if "%1"=="SkipCleanUp" goto SkipCleanUp
rmdir AVI_MetaEdit_GUI_Windows_i386\ /S /Q
:SkipCleanUp
