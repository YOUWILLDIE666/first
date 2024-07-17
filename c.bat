@echo off
rem still needs to be fixed though

title check
set "library_name=%1" && set downloaded=0 && set cdownloaded=0 && set "ghc=" && set "c="
echo Checking for GHCup...
reg query "HKEY_USERS\S-1-5-21-1917770473-3348344261-3804054489-1000\Environment" >nul 2>&1
if %errorlevel% equ 0 (
    for /f "tokens=3" %%A in ('reg query "HKEY_USERS\S-1-5-21-1917770473-3348344261-3804054489-1000\Environment" /v "GHCUP_INSTALL_BASE_PREFIX" 2^>nul') do (
        if not "%%A"=="" (
            echo GHCup found: %%A
            set downloaded=1 && set ghc=%%A
        ) else (
            echo GHCup registry is nil ?
        )
    )
    for /f "tokens=3" %%B in ('reg query "HKEY_USERS\S-1-5-21-1917770473-3348344261-3804054489-1000\Environment" /v "CABAL_DIR" 2^>nul') do (
        if not "%%B"=="" (
            echo Cabal found: %%B
            set cdownloaded=1 && set c=%%B
        ) else (
            echo cabal is not installed
        )
    )
)
if %downloaded% equ 0 (
    title GHCup setup && color a && echo Downloading GHCup && ping 127.0.0.1 -n 2 > nul && cls
    powershell -Command "Set-ExecutionPolicy Bypass -Scope Process -Force;[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; try { Invoke-Command -ScriptBlock ([ScriptBlock]::Create((Invoke-WebRequest https://www.haskell.org/ghcup/sh/bootstrap-haskell.ps1 -UseBasicParsing))) -ArgumentList $true } catch { Write-Error $_ }"
    ping 127.0.0.1 -n 4 > nul
) else (
    echo Skipping GHCup setup...
    ping 127.0.0.1 -n 2 > nul
)
if %cdownloaded% equ 0 (
    title cabal setup && color a && echo Downloading cabal && cls
    %ghc%\ghcup\ghcup.exe install --set cabal latest
) else (
    echo Skipping cabal setup...
    ping 127.0.0.1 -n 2 > nul
)
dir "%ghc%\cabal\packages\hackage.haskell.org\%library_name%" 2>nul
rem the line below me is STUPID.
if %errorlevel% equ 0 (
    echo Found %library_name% library, skipping
) else (
    echo %library_name% not found && echo Installing %library_name% library...
    cabal update && cabal install %library_name% && cabal install --lib %library_name%
)
