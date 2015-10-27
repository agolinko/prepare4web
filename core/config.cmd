:: Purpose:     SETUP INITIAL PARAMETERS & VARIABLES
:: Author:      Anton Golinko, 2015
:: Usage:       Its only for internal use, do not invoke it directly

@echo off

set CONFIGURED=1
set DEBUG=1
set IM_PATH=%~dp0bin\
set SAVED_CURRENT_PATH=%~dp0

:: ====== Output image parameters
set IMG_SIZE=900x600
set IMG_UNSHARP=
set IMG_QUALITY=90
set IMG_CODING_PARAMETERS=-define jpeg:dct-method=float -define jpeg:optimize-coding=true
set IMG_RESIZE_METHOD=resize

:: ====== Set SOURCE
set SRC_DRIVE=%~d1
set attr=%~a1
set dirattr=%attr:~0,1%
if /I "%dirattr%"=="d" (
	set SRC_PATH=%~d1%~p1%~nx1\
	set SRC_MASK=*.jpg
	set PROCESS_MULTIPLE_FILES=1
) else (
	set SRC_PATH=%~p1
	set SRC_MASK=%~nx1
	set PROCESS_MULTIPLE_FILES=0
)

:: ====== Set DESTINATION
set DST_DIR=web%IMG_SIZE%
set WATERMARK_FILE=
SET TEMPORARY_DIR=%TEMP%\prepare4web
if not exist "%TEMPORARY_DIR%" (
    md "%TEMPORARY_DIR%" 2>nul
)

