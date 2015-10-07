@echo off
:: Image preparation script preview
setlocal EnableDelayedExpansion

call core/config.cmd %1
set IMG_SIZE=800x800
set IMG_QUALITY=40
set DST_DIR=preview%IMG_SIZE%
set IMG_CODING_PARAMETERS=
set IMG_UNSHARP=
set IMG_RESIZE_METHOD=sample
::  --------------
set WATERMARK_FILE=%TEMPORARY_DIR%\wm_logo.png
set WATERMARK_TEXT_FILE=%TEMPORARY_DIR%\wm_logo.txt
set WATERMARK_TEXT=@%WATERMARK_TEXT_FILE%

echo UNOFFICIAL DRAFT> "%WATERMARK_TEXT_FILE%"
echo FOR PEER REVIEW ONLY>> "%WATERMARK_TEXT_FILE%"
call core/make_watermark.cmd
::  --------------

set WATERMARK_BASE_FILE=%TEMPORARY_DIR%\wm_base.png
set WATERMARK_TILED_FILE=%TEMPORARY_DIR%\wm_tiled.png

%IM_PATH%convert -size %IMG_SIZE% xc:none "%WATERMARK_BASE_FILE%"
%IM_PATH%composite -dissolve 30 -tile "%WATERMARK_FILE%" "%WATERMARK_BASE_FILE%" "%WATERMARK_TILED_FILE%"
set WATERMARK_FILE=%WATERMARK_TILED_FILE%

call core/core.cmd

if exist "%TEMPORARY_DIR%" (
    del "%TEMPORARY_DIR%\*.*" /q
)
