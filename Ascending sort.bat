@echo off
setlocal enabledelayedexpansion
::����Ʈ���� ���ڿ��� �� �� �� �ҷ���
for /f "tokens=*" %%h in (files.txt) do (
	set "str=%%h"
	set "numStr="
	set "A="
	::�� ���ڽ� �и��� ���� ���� �Ǵ� . �ΰ�� ������ ������
	for /l %%i in (0,1,255) do (
		set "char=!str:~%%i,1!"
		:: ���ڰ� �������� Ȯ��
		if "!char!" geq "0" if "!char!" leq "9" (
			set "numStr=!numStr!!char!"
		)
		if "!char!" == "." (
			set "numStr=!numStr!."
			set "A=1"
		)
	)
	::�տ� 0�� ä�� �ְ� �ڿ��� ���� 10�ڸ��� �߶�/�Ҽ��ΰ�� 12�ڸ��� �߶�
	set "numStr=0000000000!numStr!"
	if "!A!" == "" (set "numStr=!numStr:~-10!") else (set "numStr=!numStr:~-12!")
	::���� ��Ͽ� ������ ���ڸ� �տ� ���б�ȣ�� �԰� �ٿ��� ���Ϸ� ������
	echo !numStr!#%%h>>files_sort1.txt
)
endlocal
::����� ����Ʈ�� ������ ���� ���Ϸ� ������
SORT files_sort1.txt>files_sort2.txt
::���ĵ� ����Ʈ�� �ҷ��� ���б�ȣ �ڿ� �ִ� ���ڿ��� ���� ������ ���� �������� ������ �Ϸ���
for /f "delims=# tokens=1-2" %%f in (files_sort2.txt) do (
	echo %%g>>files_sort.txt
)
pause
::������ �ӽ� ����Ʈ�� �����ϰ� ����
del files_sort1.txt
del files_sort2.txt