; Task worker
; Connects PULL socket to tcp://localhost:5557
; Collects workloads from ventilator via that socket
; Connects PUSH socket to tcp://localhost:5558
; Sends results to sink via that socket
; 
; Author: https://github.com/telppa/ahkzmq

#NoEnv
SetBatchLines -1

zmq := new ZeroMQ

context := zmq.context()

; Socket to receive messages on
receiver := context.socket(zmq.PULL)
receiver.connect("tcp://localhost:5557")

; Socket to send messages to
sender := context.socket(zmq.PUSH)
sender.connect("tcp://localhost:5558")

; Process tasks forever
loop
{
  ; Do the work
  ; 完成任务（休眠指定时长）
  Sleep receiver.recv_string()
  
  ; Send results to sink
  ; 通知 sink 已完成任务
  sender.send_string("")
}

#Include %A_LineFile%\..\..\ZeroMQ\ZeroMQ.ahk