set buildNumber=%date:~10,4%%date:~4,2%%date:~7,2%
set component_dir=..\component\CodeExport.4dbase
set source_dir=..\matrix\CodeExport.4dbase

rmdir /Q /S %component_dir%

mkdir %component_dir%

REM Files we need:
REM   -4DB
REM   -4DINDY
REM   -Macros V2
REM   -Resources
copy "%source_dir%\CodeExport.4DB" "%component_dir%\CodeExport.4DB"
copy "%source_dir%\CodeExport.4DIndy" "%component_dir%\CodeExport.4DIndy"
xcopy "%source_dir%\Macros v2" "%component_dir%\Macros v2" /F /S /I
xcopy "%source_dir%\Resources" "%component_dir%\Resources" /F /S /I

echo %buildNumber% - Build Complete> build.txt
type ..\version.txt >> build.txt
type build.txt > ..\version.txt
del build.txt
