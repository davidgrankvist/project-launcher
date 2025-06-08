@echo off

set scriptDir=%~dp0
powershell -File %scriptDir%\project-launcher.ps1 %*
