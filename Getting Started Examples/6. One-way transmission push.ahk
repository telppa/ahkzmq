; One-way transmission - push
; This example demonstrates the PUSH/PULL mode.
; Note: In this mode, the transmission is unidirectional, only the PUSH side can send and the PULL side can receive.
; It can be multiple PUSH to send to one PULL or one PUSH to send to multiple PULL, but the transmission direction is always PUSH to PULL.
; In this example, you must start the PULL.ahk first, and then the PUSH.ahk, otherwise there will be a "slow connection" problem.

#NoEnv
SetBatchLines -1

zmq := new ZeroMQ

context := zmq.context()
sender := context.socket(zmq.PUSH)
sender.bind("tcp://*:5557")

; bind() and connect() do not block.
; The sleep here is to wait for all PULL sockets to connect successfully.
; Otherwise the messages would likely all be sent to the PULL socket connected first, because the sending speed is very fast.
Sleep 1000

; If there are 2 PULL sockets connected, each PULL socket will receive 250 messages.
loop 500
  sender.send_string("OK")

ExitApp

#Include %A_LineFile%\..\..\ZeroMQ\ZeroMQ.ahk