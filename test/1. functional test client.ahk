#NoEnv
SetBatchLines -1

zmq := new ZeroMQ

context := zmq.context()
socket := context.socket(zmq.REQ)
socket.connect("tcp://localhost:5555")

; 确保连接上再开始计时
socket.send_string("ok")
socket.recv_string()

; 1 553ms
计时()
loop 10000
{
  socket.send_string("hello`n你好")
  ret1 := socket.recv_string()
}
耗时1 := 计时()

; 2 598ms
计时()
loop 10000
{
  socket.send_string("hello`n你好")
  ret2 := socket.recv_string()
}
耗时2 := 计时()

; 3 604ms
计时()
loop 10000
{
  socket.send_string("hello`n你好")
  ret3 := socket.recv_string(, , false)
}
耗时3 := 计时()

; 4 623ms
计时()
loop 10000
{
  socket.send_string("hello`n你好")
  ret4 := socket.recv_string(, "utf-8")
}
耗时4 := 计时()

; 5 633ms
计时()
loop 10000
{
  socket.send_string("hello`n你好")
  ret5 := socket.recv_string(, "utf-8", false)
}
耗时5 := 计时()

; 6 672ms
计时()
loop 10000
{
  socket.send_string("hello`n你好")
  ret6 := socket.recv_binary()
}
耗时6 := 计时()

; 7 672ms
计时()
loop 10000
{
  socket.send_string("hello`n你好")
  ret7 := socket.recv_binary()
}
耗时7 := 计时()

; 8 672ms
计时()
loop 10000
{
  socket.send_string("hello`n你好")
  ret8 := socket.recv_binary()
}
耗时8 := 计时()

; 9 672ms
计时()
loop 10000
{
  socket.send_string("hello`n你好")
  ret9 := socket.recv_binary()
}
耗时9 := 计时()

; 10 574ms
计时()
loop 10000
{
  socket.send_string("hello`n你好")
  VarSetCapacity(ret10_1, 22, 0)
  VarSetCapacity(ret10_2, 50, 0)
  socket.recv(&ret10_1, 22)
  socket.recv(&ret10_2, 50)
}
耗时10 := 计时()

zmq.parse_buffer_array(ret6_all, ret6)
zmq.parse_buffer_array(ret7_1, ret7, 1)
zmq.parse_buffer_array(ret7_2, ret7, 2)
zmq.parse_buffer_array(ret8_all, ret8)
zmq.parse_buffer_array(ret9_1, ret9, 1)
zmq.parse_buffer_array(ret9_2, ret9, 2)

ret3_1      := ret3[1]
ret3_2      := ret3[2]
ret5_1      := ret5[1]
ret5_2      := ret5[2]
ret6_str    := StrGet(&ret6_all)
ret7_1_str  := StrGet(&ret7_1)
ret7_2_str  := StrGet(&ret7_2)
ret8_str    := StrGet(&ret8_all)
ret9_1_str  := StrGet(&ret9_1)
ret9_2_str  := StrGet(&ret9_2)
ret10_1_str := StrGet(&ret10_1)
ret10_2_str := StrGet(&ret10_2)

输出=
(
-------- 1 耗时： %耗时1% ms--------
%ret1%
-------- 2 耗时： %耗时2% ms--------
%ret2%
-------- 3 耗时： %耗时3% ms--------
%ret3_1%%ret3_2%
-------- 4 耗时： %耗时4% ms--------
%ret4%
-------- 5 耗时： %耗时5% ms--------
%ret5_1%%ret5_2%
-------- 6 耗时： %耗时6% ms--------
%ret6_str%
-------- 7 耗时： %耗时7% ms--------
%ret7_1_str%%ret7_2_str%
-------- 8 耗时： %耗时8% ms--------
%ret8_str%
-------- 9 耗时： %耗时9% ms--------
%ret9_1_str%%ret9_2_str%
-------- 10 耗时： %耗时10% ms-------
%ret10_1_str%%ret10_2_str%
----------------
)

MsgBox % 输出

ExitApp

计时()
{
	static
  
	if (CounterBefore="")
	{
		DllCall("QueryPerformanceFrequency", "Int64*", freq)
		, DllCall("QueryPerformanceCounter", "Int64*", CounterBefore)
	}
	else
	{
		DllCall("QueryPerformanceCounter", "Int64*", CounterAfter)
    return (CounterAfter - CounterBefore) / freq * 1000, CounterBefore := ""
	}
}

#Include %A_LineFile%\..\..\ZeroMQ\ZeroMQ.ahk