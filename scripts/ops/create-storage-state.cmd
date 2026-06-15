@echo off
setlocal

set "ROOT=%~dp0..\.."
pushd "%ROOT%" >nul
if errorlevel 1 (
  echo Could not enter repo root: %ROOT%
  echo.
  pause
  exit /b 1
)

where pnpm >nul 2>nul
if errorlevel 1 (
  echo pnpm was not found in PATH.
  echo Install/enable pnpm, then run this command again.
  echo.
  popd >nul
  pause
  exit /b 1
)

echo Creating Wolume storageState.json...
echo Repo: %CD%
echo.
call pnpm create-storage-state -- storageState.json https://ccfolia.com/
set "EXITCODE=%ERRORLEVEL%"

echo.
if "%EXITCODE%"=="0" (
  echo Wrote %CD%\storageState.json
  echo.
  echo Next step:
  echo Update GitHub Secret CCFOLIA_STORAGE_STATE_JSON with the contents of storageState.json.
) else (
  echo Failed with exit code %EXITCODE%.
)
echo.
popd >nul
pause
exit /b %EXITCODE%
