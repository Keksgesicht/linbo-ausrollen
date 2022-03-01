C:
cd "C:\Program Files\Veyon"

SET SCRIPT_LOCATION=%~dp0

.\veyon-cli.exe networkobjects remove 00er
.\veyon-cli.exe networkobjects import "%SCRIPT_LOCATION%veyon_00.csv" location "00er" format "%%name%%;%%host%%;%%mac%%"

.\veyon-cli.exe networkobjects remove 100er
.\veyon-cli.exe networkobjects import "%SCRIPT_LOCATION%veyon_100.csv" location "100er" format "%%name%%;%%host%%;%%mac%%"

.\veyon-cli.exe networkobjects remove 200er
.\veyon-cli.exe networkobjects import "%SCRIPT_LOCATION%veyon_200.csv" location "200er" format "%%name%%;%%host%%;%%mac%%"

.\veyon-cli.exe networkobjects remove 300er
.\veyon-cli.exe networkobjects import "%SCRIPT_LOCATION%veyon_300.csv" location "300er" format "%%name%%;%%host%%;%%mac%%"

.\veyon-cli.exe networkobjects remove 400er
.\veyon-cli.exe networkobjects import "%SCRIPT_LOCATION%veyon_400.csv" location "400er" format "%%name%%;%%host%%;%%mac%%"

.\veyon-cli.exe networkobjects remove 500er
.\veyon-cli.exe networkobjects import "%SCRIPT_LOCATION%veyon_500.csv" location "500er" format "%%name%%;%%host%%;%%mac%%"

.\veyon-cli.exe networkobjects remove 600er
.\veyon-cli.exe networkobjects import "%SCRIPT_LOCATION%veyon_600.csv" location "600er" format "%%name%%;%%host%%;%%mac%%"

.\veyon-cli.exe networkobjects remove 700er
.\veyon-cli.exe networkobjects import "%SCRIPT_LOCATION%veyon_700.csv" location "700er" format "%%name%%;%%host%%;%%mac%%"

.\veyon-cli.exe networkobjects remove r306
.\veyon-cli.exe networkobjects import "%SCRIPT_LOCATION%veyon_306.csv" location "r306" format "%%name%%;%%host%%;%%mac%%"

.\veyon-cli.exe networkobjects remove r611
.\veyon-cli.exe networkobjects import "%SCRIPT_LOCATION%veyon_611.csv" location "r611" format "%%name%%;%%host%%;%%mac%%"

.\veyon-cli.exe networkobjects remove r612
.\veyon-cli.exe networkobjects import "%SCRIPT_LOCATION%veyon_612.csv" location "r612" format "%%name%%;%%host%%;%%mac%%"

.\veyon-cli.exe networkobjects remove win10fs2
.\veyon-cli.exe networkobjects import "%SCRIPT_LOCATION%veyon_fs2.csv" location "win10fs2" format "%%name%%;%%host%%;%%mac%%"

.\veyon-cli.exe networkobjects remove win10edu
.\veyon-cli.exe networkobjects import "%SCRIPT_LOCATION%veyon_edu.csv" location "win10edu" format "%%name%%;%%host%%;%%mac%%"
