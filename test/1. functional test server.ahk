; 这是测试速度和基本功能用的

#NoEnv
SetBatchLines -1

zmq := new ZeroMQ

context := zmq.context()
socket := context.socket(zmq.REP)
socket.bind("tcp://*:5555")

; 确保连接上再开始计时
socket.recv_string()
socket.send_string("ok")

; 1
loop 10000
{
  socket.recv_string()
  socket.send_string("世界 world1 测试1 默认编码发送单帧文本 合并接收")
}

; 2
loop 10000
{
  socket.recv_string()
  socket.send_string("世界 world2 ", zmq.SNDMORE)
  socket.send_string("测试2 默认编码发送多帧文本 合并接收")
}

; 3 
loop 10000
{
  socket.recv_string()
  socket.send_string("世界 world3 ", zmq.SNDMORE)
  socket.send_string("测试3 默认编码发送多帧文本 分开接收")
}

; 4
loop 10000
{
  socket.recv_string()
  socket.send_string("世界 world4 ", zmq.SNDMORE, "utf-8")
  socket.send_string("测试4 utf8编码发送多帧文本 合并接收", , "utf-8")
}

; 5
loop 10000
{
  socket.recv_string()
  socket.send_string("世界 world5 ", zmq.SNDMORE, "utf-8")
  socket.send_string("测试5 utf8编码发送多帧文本 分开接收", , "utf-8")
}

; 6
loop 10000
{
  socket.recv_string()
  socket.send_binary("世界 world6 ", 20, zmq.SNDMORE)
  socket.send_binary("测试6 指定大小发送多帧二进制 合并接收", 40)
}

; 7
loop 10000
{
  socket.recv_string()
  socket.send_binary("世界 world7 ", 20, zmq.SNDMORE)
  socket.send_binary("测试7 指定大小发送多帧二进制 分开接收", 40)
}

; 8
loop 10000
{
  socket.recv_string()
  socket.send_binary("世界 world8 ", , zmq.SNDMORE)
  socket.send_binary("测试8 不指定大小发送多帧二进制 合并接收")
}

; 9
loop 10000
{
  socket.recv_string()
  socket.send_binary("世界 world9 ", , zmq.SNDMORE)
  socket.send_binary("测试9 不指定大小发送多帧二进制 分开接收")
}

; 10
loop 10000
{
  socket.recv_string()
  str1 := "世界 world10 "
  str2 := "测试10 指定大小发送多帧二进制 指定大小分开接收"
  socket.send(&str1, 22, zmq.SNDMORE)
  socket.send(&str2, 50)
}

ExitApp

#Include %A_LineFile%\..\..\ZeroMQ\ZeroMQ.ahk