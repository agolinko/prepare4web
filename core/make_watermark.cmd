@echo off
if NOT DEFINED CONFIGURED (
	echo HELP
	pause
	goto eof
)
setlocal EnableDelayedExpansion

if [%WATERMARK_SIZE%] == [] set WATERMARK_SIZE=250x150
if ["%WATERMARK_TEXT%"] == [""] set WATERMARK_TEXT="@watermark.txt"
if [%WATERMARK_DEGREES%] == [] set WATERMARK_DEGREES=330x330
if [%WATERMARK_FONTSIZE%] == [] set WATERMARK_FONTSIZE=20
if [%WATERMARK_FONT%] == [] set WATERMARK_FONT=Arial
if ["%WATERMARK_FILE%"] == [""] set WATERMARK_FILE=%tmp%\WATERMARK_FILE.png

set parameters=-size %WATERMARK_SIZE% xc:none -font %WATERMARK_FONT% -pointsize %WATERMARK_FONTSIZE% -gravity center ^
                   -fill black -annotate %WATERMARK_DEGREES% "%WATERMARK_TEXT%" ^
                   -fill white -annotate %WATERMARK_DEGREES%+2+2 "%WATERMARK_TEXT%" "%WATERMARK_FILE%"
if [%DEBUG%]==[1] (
    echo WATERMARK PARAMETERS: %parameters%
)

%IM_PATH%convert %parameters%

:eof