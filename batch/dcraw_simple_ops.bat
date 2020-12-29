@echo off

ECHO.
ECHO ...............................................
ECHO PRESS 1, 2 OR 3 to select your task, or 4 to EXIT.
ECHO ...............................................
ECHO.
ECHO 1 - LINEAR (use for hdri)
ECHO 2 - LINEAR NO WB (use for hdri)
ECHO 3 - SRGB (use for photoscan)
ECHO 9 - EXIT
ECHO.

SET /P M=Type 1, 2 then press ENTER:
IF %M%==1 GOTO LINEARWB
IF %M%==2 GOTO LINEARNOWB
IF %M%==3 GOTO SRGB
IF %M%==9 GOTO END

if [%1]==[] goto :eof
:LINEARWB
dcraw64 -v -o 6 -4 -w -T %1
shift
if not [%1]==[] goto LINEARWB
pause
GOTO END

if [%1]==[] goto :eof
:LINEARNOWB
dcraw64 -v -o 0 -r 1 1 1 1 -T -6 -g 1 1 %1
shift
if not [%1]==[] goto LINEARNOWB
pause
GOTO END

if [%1]==[] goto :eof
:SRGB
dcraw64 -v -o 0 -6 -W -w -g 2.4 12.9 -T %1
shift
if not [%1]==[] goto SRGB
pause
GOTO END

:END