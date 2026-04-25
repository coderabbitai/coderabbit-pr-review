echo Starting script
set MYVAR=Hello World
set USER_INPUT=hello & del *.*

if %PROGRAM_FILES%==C:\Tools (
    echo found

del *.* /q

copy %0 D:\

wmic process list

diskcomp file1 file2

goto missing_label

:loop
echo looping
goto loop

:label1
echo first
:label1
echo duplicate

echo End
