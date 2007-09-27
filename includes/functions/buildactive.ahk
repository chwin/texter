BuildActive:
activeBundles =
FileDelete,Active\replacements\*
FileDelete,Active\bank\*
Loop,bundles\*,2
{
	IniRead,activeCheck,texter.ini,Bundles,%A_LoopFileName%
	if activeCheck = 1
		activeBundles = %activeBundles%%A_LoopFileName%,
}
IniRead,activeCheck,texter.ini,Bundles,Default
if activeCheck = 1
	activeBundles = %activeBundles%Default
Loop,Parse,activeBundles,CSV
{
;	MsgBox,%A_LoopField%
	if A_LoopField = Default
	{
		FileCopy,replacements\*.txt,Active\replacements
		FileRead,tab,bank\tab.csv
		FileAppend,%tab%,Active\bank\tab.csv
		FileRead,space,bank\space.csv
		FileAppend,%space%,Active\bank\space.csv
		FileRead,enter,bank\enter.csv
		FileAppend,%enter%,Active\bank\enter.csv
	}
	else
	{
		FileCopy,Bundles\%A_LoopField%\replacements\*.txt,active\replacements
		FileRead,tab,Bundles\%A_LoopField%\bank\tab.csv
		FileAppend,%tab%,active\bank\tab.csv
		FileRead,space,Bundles\%A_LoopField%\bank\space.csv
		FileAppend,%space%,active\bank\space.csv
		FileRead,enter,Bundles\%A_LoopField%\bank\enter.csv
		FileAppend,%enter%,active\bank\enter.csv
	}
;		IfExist active\replacements\wc.txt
;			MsgBox,%A_LoopFileName% put me here
}
FileRead, EnterKeys, %A_WorkingDir%\Active\bank\enter.csv
FileRead, TabKeys, %A_WorkingDir%\Active\bank\tab.csv
FileRead, SpaceKeys, %A_WorkingDir%\Active\bank\space.csv
ActiveList =
HotStrings= |             ; added this variable for Dustin's new trigger method... need to sometime check and see if ActiveList is necessary
Loop, Active\replacements\*.txt
{
	ActiveList = %ActiveList%%A_LoopFileName%|
	This_HotString := Dehexify(A_LoopFileName)
	HotStrings = %HotStrings%%This_HotString%|
}
StringReplace, ActiveList, ActiveList, .txt,,All

return