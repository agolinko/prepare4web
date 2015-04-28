@echo off
	rem ===================================
	rem * Copyright (C) 2015 Anton Golinko
	rem * vk.com/anton.golinko
	rem * fb.com/anton.golinko
	rem * 500px.com/antongolinko
	rem ===================================
	rem USAGE:
	rem core.cmd <target> [size] [quality]
	rem
	rem OPTIONS 
	rem Default parameters
	rem 
	set unsharp=0
	set quality=90 
	set size=900x600
	if  not [%2] == [] set size=%2
	if  not [%3] == [] set quality=%3
	set DEBUG=0
	rem =======================  

set DST_NAME=web%size%

set IM_PATH=%~dp0
set TARGET=%1
set TARGET_DRIVE=%~d1

setlocal ENABLEEXTENSIONS
set ATTR=%~a1
set DIRATTR=%ATTR:~0,1%
if /I "%DIRATTR%"=="d" (
	set TARGET_DIR=%TARGET%\
	set TARGET_MASK=*.jpg
	set PROCESS_MULTIPLE_FILES=1
) else (
	set TARGET_DIR=%~p1
	set TARGET_MASK=%~nx1
	set PROCESS_MULTIPLE_FILES=0
)


if [%DEBUG%]==[1] (
	echo ! unsharp=%unsharp%
	echo ! quality=%quality%
	echo ! size=%size%
	echo ! IM_PATH=%IM_PATH%
	echo ! TARGET=%TARGET%
	echo ! TARGET_DRIVE=%TARGET_DRIVE%
	echo ! TARGET_DIR=%TARGET_DIR%
	echo ! TARGET_MASK=%TARGET_MASK%
	echo ! DST_NAME=%DST_NAME%
	echo ! PROCESS_MULTIPLE_FILES=%PROCESS_MULTIPLE_FILES%
)

if not exist %TARGET_DIR%%TARGET_MASK% (
	echo %TARGET_DIR%%TARGET_MASK% does not exists, or no such files.
	goto eof
)

%TARGET_DRIVE%
cd "%TARGET_DIR%" 
if exist %DST_NAME% (
	del %DST_NAME%\%TARGET_MASK% /q
) else (
	md %DST_NAME% > nul 
)

set transform_parameters=-auto-orient -unsharp %unsharp% -quality %quality% -interlace Plane -resize %size% -colorspace sRGB -define jpeg:dct-method=float -define jpeg:optimize-coding=true

if %PROCESS_MULTIPLE_FILES% == 1 (
	echo Converting files in %CD% ...
) else (
	echo Converting %TARGET_MASK% ...
)
	
%IM_PATH%mogrify.exe %transform_parameters% -path %DST_NAME% %TARGET_MASK%
if %ERRORLEVEL% GEQ 1 goto eof

echo Clearing EXIF....
%IM_PATH%exiftool -overwrite_original -all= -tagsFromFile @ -exifversion -orientation -colorspace -compression ^
  -artist -copyright -make -model ^
  -exposuretime -fnumber -exposureprogram -exposuremode -iso -shutterspeedvalue -aperturevalue -exposurecompensation -isospeed -meteringmode ^
  -datetimeoriginal -createdate ^
  -FocalLength -FocalLengthIn35mmFormat -lensinfo -lensmake -lensmodel %DST_NAME%\%TARGET_MASK%
if %ERRORLEVEL% GEQ 1 goto error

echo Done.

:eof
:error
cd %IM_PATH%