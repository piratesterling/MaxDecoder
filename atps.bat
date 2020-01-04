@echo off
::cd ATPS
::echo "this is atps";
if exist ATPS\atpsxml*.txt goto myatps;
IF NOT EXIST ATPS\atpsxml*.txt goto movinon;
:myatps
mkdir ATPS\html
copy ATPS\atpsxml*.txt ATPS\html\*.html >NUL;
for /F %%G IN ('dir /B ATPS\html\*.html') DO (sed -i "1i\<title>%%G</title></head>" ATPS\html\%%G)
sed -i -f "%InstallationLocation%\ATPSXMLSed" ATPS\html\*.html
sed -i "/zzzzzz/ s/\([[:xdigit:]][[:xdigit:]]\)/\&#x\1;/g" ATPS\html\*.html
sed -i "s;zzzzzz;;g" ATPS\html\*.html

echo ^<html^>^<body style="font-family:arial;font-size:12;background-color:d9d9d9"^>^<table cellspacing="0" width="500" frame="hsides" cellpadding="5" style="font-family:arial;font-size:12"^>  > IndexATPS.html 

for /F %%a IN ('dir /B ATPS\html\*.html') DO ( echo ^<a href="ATPS/html\%%a"^>%%a^</a^>^<br /^> >> IndexATPS.html)
goto cruisin;
:movinon
echo ^<caption style="font-family:arial;font-size:60;background-color:DeepSkyBlue" align="center"^>^<b^>^<u^>No ATPS logs contained within traces, possibly no Altigen Phones^</u^>^</b^>^</style^>^</caption^> >> IndexATPS.html
:cruisin
