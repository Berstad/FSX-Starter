:: ==================================================================================
:: This script performs tasks related to the starting of FSX, and then starts the 
:: game.
:: Author: Tor Jan Derek Berstad
:: License: See included file for details
:: Usage: 
::  - Download this file anywhere on your system. 
::  - Make changes as detailed below depending on your configuration and extras.
::  - IMPORTANT: Create a shortcut to this file which runs it as adminstrator.
::    To do this, create a shortcut as usual, then right click on it, select
::    "Advanced" and check "Run as adminstrator".
::  - Double click and enjoy
:: Note: The programs which this script kills will not work until you restart your
:: system or start the programs manually, this includes OneDrive, f.lux, Google Drive
:: Dropbox and Skype.

:: First we kill programs which use CPU, this has a measurable effect on performance
:: in FSX.

@ECHO OFF
taskkill /f /im GROOVE.exe
taskkill /f /im flux.exe
taskkill /f /im googledrivesync.exe
taskkill /f /im DropboxUpdate.exe
taskkill /f /im dbxsvc.exe
taskkill /f /im OneDrive.exe
taskkill /f /im SkypeHost.exe

:: Change to the FSX directory, if your FSX is located somewhere else 
:: you must change this yourself
cd /d D:
cd \Program Files\Steam\steamapps\common\FSX

:: Begin starting FSX with "realtime" process priority, this improves performance
START fsx.exe
FOR /L %%i IN (1,1,100) DO (
  (TASKLIST | FIND /I "fsx.exe") && wmic process where name="fsx.exe" CALL setpriority "realtime" && GOTO :startnext
  timeout /t 5
)
ECHO Timeout waiting for fsx.exe to start
GOTO :EOF


:startnext
:: Start AISmooth (highly recommended), if you do not use AISmooth 
:: you can remove this part
START Modules/AISmooth.exe

FOR /L %%i IN (1,1,100) DO (
  (TASKLIST | FIND /I "AISmooth.exe") && GOTO :startlast
  timeout /t 5
)
ECHO Timeout waiting for AISmooth.exe to start
GOTO :EOF

:startlast
:: Start FSXWX (also hightly recommended), if you do not use FSXWX 
:: you can remove this part
START Modules/FSXWX.exe
