@echo off

ECHO.
ECHO ...............................................
ECHO PRESS 1, 2 OR 3 to select your task, or 9 to EXIT.
ECHO ...............................................
ECHO.
ECHO 1 - Linear file to sRGB JPG (ie. Preview Images)
ECHO 2 - sRGB file to ACEScg (ie. Texture to ACEScg EXR)
ECHO 3 - Resize to HD EXR (ie. resize into HD image)
ECHO 4 - HDRI to ACEScg (ie. HdriHaven to ACEScg EXR)
ECHO 9 - EXIT
ECHO.

SET /P M=Type 1, 2, 3 or 9 then press ENTER:
IF %M%==1 GOTO LINEAR2PAINT
IF %M%==2 GOTO PAINT2LINEAR
IF %M%==3 GOTO RESIZEHD
IF %M%==4 GOTO HDRI2ACESCG
IF %M%==9 GOTO EOF

:LINEAR2PAINT
if [%1]==[] goto :eof
:loop1
"oiiotool.exe" %1 -v --colorconvert scene_linear matte_paint -o "%~dpn1_srgb.jpg"
shift
if not [%1]==[] goto loop1
pause
GOTO END

:PAINT2LINEAR
if [%1]==[] goto :eof
:loop2
"oiiotool.exe" %1 -v --colorconvert matte_paint scene_linear -o "%~dpn1_acescg.exr"
shift
if not [%1]==[] goto loop2
pause
GOTO END

:RESIZEHD
if [%1]==[] goto :eof
:loop3
"oiiotool.exe" %1 -v -resize 1920x1080 -o %~dpn1__hd.exr"
shift
if not [%1]==[] goto loop3
pause
GOTO END

:HDRI2ACESCG
if [%1]==[] goto :eof
:loop4
"oiiotool.exe" %1 -v -d float --colorconvert lin_srgb scene_linear -o %~dpn1__acescg.exr"
shift
if not [%1]==[] goto loop4
pause
GOTO END

:END