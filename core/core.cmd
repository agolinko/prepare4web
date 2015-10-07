:: Purpose:     CORE script
:: Author:      Anton Golinko, 2015
:: Usage:       Its only for internal use, do not invoke it directly

@echo off
setlocal EnableDelayedExpansion
if not defined CONFIGURED (
	echo This script is for internal purposed only. Do not invoke it directly.
	echo Please use prepare4web, prepare4vk, prepare4fb scripts instead

	goto eof
)

if [%DEBUG%]==[1] (
	echo -  IMG_UNSHARP=%IMG_UNSHARP%
	echo -  IMG_QUALITY=%IMG_QUALITY%
	echo -  IMG_SIZE=%IMG_SIZE%
	echo -  IM_PATH=%IM_PATH%
	echo -  SRC_DRIVE=%SRC_DRIVE%
	echo -  SRC_PATH=%SRC_PATH%
	echo -  SRC_MASK=%SRC_MASK%
	echo -  DST_DIR=%DST_DIR%
	echo -  PROCESS_MULTIPLE_FILES=!PROCESS_MULTIPLE_FILES!
	echo -  WATERMARK_FILE=%WATERMARK_FILE%
	echo -  TEMPORARY_DIR=%TEMPORARY_DIR%
	echo.
)

if not exist "%SRC_PATH%%SRC_MASK%" (
    echo %SRC_PATH%%SRC_MASK% does not exist, or no such files.
	goto eof
)

set transform_parameters=-auto-orient -interlace Plane -colorspace sRGB %IMG_CODING_PARAMETERS%
set transform_parameters=-%IMG_RESIZE_METHOD% %IMG_SIZE% -quality %IMG_QUALITY% %transform_parameters%

if not ["%WATERMARK_FILE%"] == [""] set watermark_parameters= -gravity center -draw "image src-over 0,0 0,0 '%WATERMARK_FILE%'"

if [%DEBUG%]==[1] (
    echo -  transform_parameters=%transform_parameters%
    echo -  watermark_parameters=%watermark_parameters%
    echo.
)

:: =======================================
%SRC_DRIVE%
cd "%SRC_PATH%"
if exist "%DST_DIR%" (
	del "%DST_DIR%\%SRC_MASK%" /q
) else (
	md "%DST_DIR%" > nul
)

if %PROCESS_MULTIPLE_FILES% == 1 (
	echo Converting files in %CD% ...
) else (
	echo Converting %SRC_MASK% ...
)

"%IM_PATH%mogrify.exe" %transform_parameters% %watermark_parameters% -path "%DST_DIR%" "%SRC_MASK%"
if %ERRORLEVEL% GEQ 1 goto eof
echo done.

echo Clearing EXIF....
%IM_PATH%exiftool -overwrite_original -all= -tagsFromFile @ -exifversion -orientation -colorspace -compression ^
  -artist -copyright -make -model ^
  -exposuretime -fnumber -exposureprogram -exposuremode -iso -shutterspeedvalue -aperturevalue -exposurecompensation -isospeed -meteringmode ^
  -datetimeoriginal -createdate ^
  -FocalLength -FocalLengthIn35mmFormat -lensinfo -lensmake -lensmodel "%DST_DIR%\%SRC_MASK%"
if %ERRORLEVEL% GEQ 1 goto error

echo done.

:eof
:error
cd %SAVED_CURRENT_PATH%
if [%DEBUG%]==[1] (
	pause
)