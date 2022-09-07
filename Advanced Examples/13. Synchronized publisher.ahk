; Synchronized publisher
; 
; Author: https://github.com/telppa/ahkzmq

; 此例应启动5个 "13. Synchronized subscriber.ahk"

#NoEnv
SetBatchLines -1

zmq := new ZeroMQ

; We wait for 5 subscribers
SUBSCRIBERS_EXPECTED := 5

context := zmq.context()

; Socket to talk to clients
publisher := context.socket(zmq.PUB)
; set SNDHWM, so we don't drop messages for slow subscribers
publisher.setsockopt(zmq.SNDHWM, 1100000)
publisher.bind("tcp://*:5561")

; Socket to receive signals
syncservice := context.socket(zmq.REP)
syncservice.bind("tcp://*:5562")

; Get synchronization from subscribers
subscribers := 0
while (subscribers < SUBSCRIBERS_EXPECTED)
{
  ; wait for synchronization request
  msg := syncservice.recv_string()
  ; send synchronization reply
  syncservice.send_string("")
  subscribers += 1
  ToolTip +1 subscriber (%subscribers%/%SUBSCRIBERS_EXPECTED%)
}

; Now broadcast exactly 1M updates followed by END
loop 1000000
  publisher.send_string("Rhubarb")

publisher.send_string("END")

ExitApp

#Include %A_LineFile%\..\..\ZeroMQ\ZeroMQ.ahk