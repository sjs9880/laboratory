@echo off
setlocal enabledelayedexpansion
::리스트에서 문자열을 한 줄 씩 불러옴
for /f "tokens=*" %%h in (files.txt) do (
	set "str=%%h"
	set "numStr="
	set "A="
	::한 문자식 분리해 비교해 숫자 또는 . 인경우 변수에 저장함
	for /l %%i in (0,1,255) do (
		set "char=!str:~%%i,1!"
		:: 문자가 숫자인지 확인
		if "!char!" geq "0" if "!char!" leq "9" (
			set "numStr=!numStr!!char!"
		)
		if "!char!" == "." (
			set "numStr=!numStr!."
			set "A=1"
		)
	)
	::앞에 0을 채워 넣고 뒤에서 부터 10자리를 잘라냄/소수인경우 12자리를 잘라냄
	set "numStr=0000000000!numStr!"
	if "!A!" == "" (set "numStr=!numStr:~-10!") else (set "numStr=!numStr:~-12!")
	::원래 목록에 추출한 숫자를 앞에 구분기호와 함게 붙여서 파일로 저장함
	echo !numStr!#%%h>>files_sort1.txt
)
endlocal
::저장된 리스트를 정렬해 별도 파일로 저장함
SORT files_sort1.txt>files_sort2.txt
::정렬된 리스트를 불러와 구분기호 뒤에 있는 문자열만 따로 저장해 숫자 오름차순 정렬을 완료함
for /f "delims=# tokens=1-2" %%f in (files_sort2.txt) do (
	echo %%g>>files_sort.txt
)
pause
::생성된 임시 리스트를 삭제하고 종료
del files_sort1.txt
del files_sort2.txt