; Weather proxy device
; 
; Author: https://github.com/telppa/ahkzmq

#NoEnv
SetBatchLines -1

zmq := new ZeroMQ

context := zmq.context()

; This is where the weather server sits
frontend := context.socket(zmq.SUB)
frontend.connect("tcp://192.168.55.210:5556")

; This is our public endpoint for subscribers
backend := context.socket(zmq.PUB)
backend.bind("tcp://10.1.1.0:8100")

; Subscribe on everything
frontend.setsockopt_string(zmq.SUBSCRIBE, "")

; Shunt messages out to our own subscribers
loop
{
  ; Process all parts of the message
  message := frontend.recv_multipart()
  backend.send_multipart(message)
}

#Include %A_LineFile%\..\..\ZeroMQ\ZeroMQ.ahk