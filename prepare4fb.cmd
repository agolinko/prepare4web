@echo off
:: Image preparation script for Facebook social network.
:: Uses optimized parameters
:: Guide to facebook image sizes
:: http://benrequena.com/facebook-image-sizes-guide/

call core/config.cmd %1
set IMG_SIZE=1200x960
set IMG_QUALITY=90
set DST_DIR=fb%IMG_SIZE%

call core/core.cmd
