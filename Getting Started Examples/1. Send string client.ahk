; Send string - 客户端
; 本例演示发送10000条消息给服务端，同时从服务端接收10000条回应。
; 本例使用 REQ/REP 模式，又叫 请求/回应 或 提问/回答 模式。
; 注意：该模式下，严格遵循 REQ端发送-REP端接收-REP端发送-REQ端接收 这个顺序。
; 改变顺序会报错，例如： REQ端发送-REQ端发送-REP端接收-REP端发送-REQ端接收。

#NoEnv
SetBatchLines -1                       ; 速度最大化

zmq := new ZeroMQ                      ; 初始化 ZeroMQ

context := zmq.context()               ; 创建一个上下文
socket := context.socket(zmq.REQ)      ; 创建一个 REQ 套接字
socket.connect("tcp://localhost:5555") ; 连接到端口

loop 10000
{
  socket.send_string("Hello")          ; 发送消息 Hello 给服务端
  msg := socket.recv_string()          ; 从服务端接收回应
}

MsgBox Client received reply %msg%

ExitApp

#Include %A_LineFile%\..\..\ZeroMQ\ZeroMQ.ahk