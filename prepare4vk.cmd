:: Purpose:     Image preparation script for VKontakte social network.
::              Uses optimized parameters
:: Author:      Anton Golinko, 2015
:: Usage:       Script accepts only one required parameter - filename or folder name
::              Rest of parameters are specified via local variables

@echo off
setlocal EnableDelayedExpansion
call core/config.cmd %1
set IMG_SIZE=1200x1024
set IMG_QUALITY=99
set DST_DIR=vk%IMG_SIZE%

call core/core.cmd
