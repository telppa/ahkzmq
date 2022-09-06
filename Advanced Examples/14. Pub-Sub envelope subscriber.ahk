; Pubsub envelope subscriber
; 
; Author: https://github.com/telppa/ahkzmq

#NoEnv
SetBatchLines -1

zmq := new ZeroMQ

; Prepare our context and publisher
context := zmq.context()
subscriber := context.socket(zmq.SUB)
subscriber.connect("tcp://localhost:5563")
subscriber.setsockopt_string(zmq.SUBSCRIBE, "B")

loop
{
  ; Read envelope with address
  msg := subscriber.recv_string(, , false)
  ToolTip % "[" msg.1 "] " msg.2
}

#Include %A_LineFile%\..\..\ZeroMQ\ZeroMQ.ahk