; Send string - 服务端

#NoEnv
SetBatchLines -1

zmq := new ZeroMQ

context := zmq.context()
socket := context.socket(zmq.REP) ; 创建一个 REP 套接字
socket.bind("tcp://*:5555")       ; 绑定到端口

loop 10000
{
  msg := socket.recv_string()     ; 接收客户端的请求
  socket.send_string("World")     ; 发送消息 World 给客户端
}

MsgBox Server received request %msg%

ExitApp

#Include %A_LineFile%\..\..\ZeroMQ\ZeroMQ.ahk