:: Purpose:     Common image preparation script
:: Author:      Anton Golinko, 2015
:: Usage:       Script accepts only one required parameter - filename or folder name
::              Rest of parameters are specified via local variables

@echo off
setlocal EnableDelayedExpansion
call core/config.cmd %1
call core/core.cmd
