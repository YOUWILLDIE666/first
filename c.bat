@echo off
setlocal
set "library_name=%1"

set downloaded=0
set "ghc="

echo Checking for GHCup...
reg query "HKEY_USERS\S-1-5-21-1917770473-3348344261-3804054489-1000\Environment" >nul 2>&1
if %errorlevel% equ 0 (
    for /f "tokens=3" %%A in ('reg query "HKEY_USERS\S-1-5-21-1917770473-3348344261-3804054489-1000\Environment" /v "GHCUP_INSTALL_BASE_PREFIX" 2^>nul') do (
        if not "%%A"=="" (
            echo GHCup found:                              %%A
            set downloaded=1
            set ghc=%%A
        ) else (
            echo GHCup registry is nil ?
        )
    )
)

%ghc%ghcup\bin\cabal.exe list --installed %library_name% | findstr /%ghc%cabal\packages\hackage.haskell.org:"%library_name%" >nul

if %errorlevel% equ 0 (
    echo 1
) else (
    echo 0
    echo Installing %library_name% library...
    cabal install %library_name% && cabal install --lib %library_name%
)

endlocal
