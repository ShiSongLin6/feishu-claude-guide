@echo off
chcp 65001 >nul
rem Put lark-skills.zip next to this file, then double-click.
rem (Build the zip from the "skills/" folder of https://github.com/larksuite/cli : one folder per skill, each with a SKILL.md.)
set "DEST=%USERPROFILE%\.claude\skills"
if not exist "%DEST%" mkdir "%DEST%"
powershell -NoProfile -ExecutionPolicy Bypass -Command "Expand-Archive -LiteralPath '%~dp0lark-skills.zip' -DestinationPath '%DEST%' -Force"
dir /b "%DEST%\lark-*"
pause
