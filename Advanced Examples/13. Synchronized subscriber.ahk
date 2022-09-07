; Synchronized subscriber
; 
; Author: https://github.com/telppa/ahkzmq

#NoEnv
SetBatchLines -1

zmq := new ZeroMQ

context := zmq.context()

; First, connect our subscriber socket
subscriber := context.socket(zmq.SUB)
subscriber.connect("tcp://localhost:5561")
subscriber.setsockopt_string(zmq.SUBSCRIBE, "")

Sleep 1

; Second, synchronize with publisher
syncclient := context.socket(zmq.REQ)
syncclient.connect("tcp://localhost:5562")

; send a synchronization request
syncclient.send_string("")

; wait for synchronization reply
syncclient.recv_string("")

; Third, get our updates and report how many we got
nbr = 0
loop
{
  msg := subscriber.recv_string()
  if (msg = "END")
    break
  nbr += 1
}

MsgBox Received %nbr% updates

ExitApp

#Include %A_LineFile%\..\..\ZeroMQ\ZeroMQ.ahk