@REM This batch file copies the bing desktop wallpapers from the temp directory to a save directory.
if NOT exist c:\temp\wallpapers mkdir c:\temp\wallpapers
copy/y "%USERPROFILE%\AppData\Local\Microsoft\BingDesktop\en-US\Apps\Wallpaper_5386c77076d04cf9a8b5d619b4cba48e\VersionIndependent\images\*.jpg" c:\temp\wallpapers

@REM these are the lock screen wallpapers
copy/y "%USERPROFILE%\AppData\Local\Packages\Microsoft.Windows.ContentDeliveryManager_cw5n1h2txyewy\LocalState\Assets" c:\temp\wallpapers

