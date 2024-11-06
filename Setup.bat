@echo off
title Select Country, Time Zone, and Region

:menu
echo.
echo === Choose the country to set the time zone and region ===
echo.
echo 1 - Germany (DE)
echo 2 - France (FR)
echo 3 - Canada (CA)
echo 4 - Italy (IT)
echo.

set /p choice="Enter your choice (1-4): "

REM Set variables for each choice
if "%choice%"=="1" (
    set timezone="W. Europe Standard Time"
    set locale="de-DE"
    set geoid=94
) else if "%choice%"=="2" (
    set timezone="Romance Standard Time"
    set locale="fr-FR"
    set geoid=84
) else if "%choice%"=="3" (
    set timezone="Eastern Standard Time"
    set locale="en-CA"
    set geoid=39
) else if "%choice%"=="4" (
    set timezone="W. Europe Standard Time"
    set locale="it-IT"
    set geoid=118
) else (
    echo Invalid choice. Please enter a number from 1 to 4.
    goto menu
)

REM Apply time zone, locale, and GeoID
echo Applying settings...
tzutil /s %timezone%
powershell -command "Set-ItemProperty -Path 'HKCU:\Control Panel\International' -Name 'LocaleName' -Value '%locale%'"
powershell -command "Set-WinHomeLocation -GeoID %geoid%"

REM Check if GeoID was set correctly
for /f %%G in ('powershell -command "(Get-WinHomeLocation).GeoID"') do set currentGeoID=%%G

if "%currentGeoID%"=="%geoid%" (
    echo Settings applied successfully for your selected country.
) else (
    echo Failed to apply settings. Please try again.
    goto menu
)

pause
