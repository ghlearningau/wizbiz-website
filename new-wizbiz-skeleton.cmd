@echo off
rem ===========================================================================
rem  new-wizbiz-skeleton.cmd
rem
rem  Creates the wizbiz-website folder and file skeleton. Empty files only.
rem  Filling each file is the work, and that work belongs in a branch behind
rem  an issue.
rem
rem  Empty files are deliberate. Git tracks files, not directories, so an
rem  empty css\ folder would vanish on commit. An empty css\style.css keeps
rem  the folder in the repository without needing a .gitkeep.
rem
rem  Usage:
rem    new-wizbiz-skeleton.cmd
rem    new-wizbiz-skeleton.cmd C:\Projects\wizbiz-website
rem    new-wizbiz-skeleton.cmd wizbiz-website /F
rem ===========================================================================

setlocal

set "TARGET=wizbiz-website"
set "FORCE="
set /a CREATED=0
set /a SKIPPED=0

:parse
if "%~1"=="" goto parsed
if /i "%~1"=="/F" set "FORCE=1" & shift & goto parse
if /i "%~1"=="/?" goto usage
set "TARGET=%~1"
shift
goto parse

:parsed

if not exist "%TARGET%\" mkdir "%TARGET%"
pushd "%TARGET%" || goto badtarget
set "ROOT=%CD%"
popd

echo.
echo wizbiz-website skeleton
echo Target: %ROOT%
echo.

call :dir css
call :dir js
call :dir tests
call :dir docs

call :file index.html
call :file about.html
call :file services.html
call :file contact.html
call :file css\style.css
call :file js\app.js
call :file tests\test-plan.md
call :file docs\deployment.md
call :file .gitignore
call :file README.md

echo.
echo   Created: %CREATED%    Left alone: %SKIPPED%
echo.
echo Next:
echo   cd "%ROOT%"
echo   git init --initial-branch=main
echo   git add .
echo   git commit -m "chore: add project skeleton"
echo.
echo   Then fill each file from a branch, behind an issue.
echo.
endlocal
exit /b 0


:dir
if exist "%ROOT%\%~1\" goto dirExists
mkdir "%ROOT%\%~1"
echo   create  %~1\
exit /b 0
:dirExists
echo   exists  %~1\
exit /b 0


:file
if not exist "%ROOT%\%~1" goto fileWrite
if defined FORCE goto fileWrite
echo   exists  %~1
set /a SKIPPED+=1
exit /b 0
:fileWrite
type nul>"%ROOT%\%~1"
echo   create  %~1
set /a CREATED+=1
exit /b 0


:badtarget
echo ERROR: cannot enter "%TARGET%".
endlocal
exit /b 1

:usage
echo Usage: new-wizbiz-skeleton.cmd [target-folder] [/F]
echo   target-folder  Where to create the project ^(default: wizbiz-website^)
echo   /F             Truncate files that already exist
endlocal
exit /b 0
