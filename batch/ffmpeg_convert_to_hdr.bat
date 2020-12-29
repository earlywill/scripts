@echo off


ECHO.
ECHO ...............................................
ECHO PRESS 1, 2 OR 3 to select your task, or 4 to EXIT.
ECHO ...............................................
ECHO.
ECHO 1 - CPU - ST2084
ECHO 2 - GPU - ST2084
ECHO 3 - CPU - HLG
ECHO 4 - GPU - HLG
ECHO 9 - EXIT
ECHO.

SET /P M=Type 1, 2 then press ENTER:
IF %M%==1 GOTO CPUST2084
IF %M%==2 GOTO GPUST2084
IF %M%==3 GOTO END
IF %M%==4 GOTO END
IF %M%==9 GOTO END

if [%1]==[] goto :eof
:CPUST2084
ffmpeg -i %1 -c:v libx264 ^
-b:v 18M ^
-maxrate 20M ^
-bufsize 24M ^
-pix_fmt yuv420p10le ^
-color_primaries 9 ^
-color_trc 16 ^
-colorspace 9 ^
-color_range 1 ^
-maxrate 26800000 ^
-minrate 8040000 ^
"%~dpn1_st2084_cpu.mov"
shift
if not [%1]==[] goto CPUST2084
pause
GOTO END

REM -c:v hevc_nvenc -b:v 6M -maxrate 9M -bufsize 12M -preset slow -pix_fmt p010le -profile:v main10 -level 4.1 -tier high -refs 3 -coder 1 -rc vbr_hq -rc-lookahead 32 -bf 3 -b_ref_mode middle -b_strategy 1 -r 24000/1001 -c:a ac3 -b:a 192K


if [%1]==[] goto :eof
:GPUST2084
ffmpeg -i %1 -c:v hevc_nvenc ^
-b:v 18M ^
-maxrate 20M ^
-bufsize 24M ^
-pix_fmt p010le ^
-color_primaries 9 ^
-color_trc 16 ^
-colorspace 9 ^
-color_range 1 ^
-maxrate 26800000 ^
-minrate 8040000 ^
"%~dpn1_st2084_gpu.mov"
shift
if not [%1]==[] goto GPUST2084
pause
GOTO END

:END