@echo off

if [%1]==[] goto :eof
:loop
ffmpeg -i %1 -c:v libx264 -crf 22 -preset fast -acodec ac3 -ac 2 "%~dpn1_enc.mp4"
shift
if not [%1]==[] goto loop

pause