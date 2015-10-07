@echo off
::  Image preparation script for Vkontakte social network.
::  Uses optimized parameters

call core/config.cmd %1
set IMG_SIZE=1200x1024
set IMG_QUALITY=99
set DST_DIR=vk%IMG_SIZE%

call core/core.cmd
