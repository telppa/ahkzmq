; Pubsub envelope publisher
; 
; Author: https://github.com/telppa/ahkzmq

#NoEnv
SetBatchLines -1

zmq := new ZeroMQ

; Prepare our context and publisher
context := zmq.context()
publisher := context.socket(zmq.PUB)
publisher.bind("tcp://*:5563")

loop
{
  ; Write two messages, each with an envelope and content
  publisher.send_string("A", zmq.SNDMORE)
  publisher.send_string("We don't want to see this")
  
  publisher.send_string("B", zmq.SNDMORE)
  publisher.send_string("We would like to see this")
  
  Sleep 10
}

#Include %A_LineFile%\..\..\ZeroMQ\ZeroMQ.ahk