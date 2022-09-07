; Send & recv multi frame string - client
; This example shows how to send and receive multi-frame text messages.
; Note: The slicing mentioned in Example 2 refers to multiple messages, while this example is a single message containing multiple frames.

#NoEnv
SetBatchLines -1

zmq := new ZeroMQ

context := zmq.context()
socket := context.socket(zmq.REQ)
socket.connect("tcp://localhost:5555")

loop 10000
{
  socket.send_string("11111", zmq.SNDMORE) ; send frame 1
  socket.send_string("22222", zmq.SNDMORE) ; send frame 2
  ; send last frame. at this time, the sending of one message is completed.
  ; it does not violate the order rule mentioned in Example 1, because this is one message with three frames.
  socket.send_string("33333")
  
  ; recv_string() without arguments will combine multiple frames into one variable
  msg := socket.recv_string()
}

MsgBox %msg%

ExitApp

#Include %A_LineFile%\..\..\ZeroMQ\ZeroMQ.ahk