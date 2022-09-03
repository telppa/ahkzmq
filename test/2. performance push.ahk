#NoEnv
SetBatchLines -1

zmq := new ZeroMQ
context := zmq.context()
sender := context.socket(zmq.PUSH)
sender.bind("tcp://*:5557")

; 确保连接上再开始计时，这样无论先启动 pull.ahk 还是 push.ahk 计时都是一样的
sender.send_string("abcde")

计时()
loop 1000000
  sender.send_string("abcde") ; 1215ms
计时()

; 找到消息发送对象
DetectHiddenWindows On
SetTitleMatchMode 2
WinGet hwnd, ID, 2. performance pull.ahk ahk_class AutoHotkey

计时()
loop 1000000
  ; PostMessage 0x5555, 123, 456, , ahk_id %hwnd% ; 7542ms
  SendMessage 0x5555, 123, 456, , ahk_id %hwnd% ; 12086ms 不应该用 post ，因为 send 才能确保送达
计时()

WinClose ahk_id %hwnd%

ExitApp

计时()
{
	Static
	if (CounterBefore="")
	{
		DllCall("QueryPerformanceFrequency", "Int64*", freq)
		, DllCall("QueryPerformanceCounter", "Int64*", CounterBefore)
	}
	else
	{
		DllCall("QueryPerformanceCounter", "Int64*", CounterAfter)
		, 耗时:=(CounterAfter - CounterBefore) / freq * 1000
		, CounterBefore:=""
		MsgBox, 4096, 耗时, % Format("{1} 毫秒`r`n或`r`n{2} 分 {3} 秒", 耗时, Floor(耗时/1000/60), Round(Mod(耗时/1000,60)))
	}
}

#Include %A_LineFile%\..\..\ZeroMQ\ZeroMQ.ahk