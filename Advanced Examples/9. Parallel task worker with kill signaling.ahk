; Task worker - design 2
; Adds pub-sub flow to receive and respond to kill signal
; 
; Author: https://github.com/telppa/ahkzmq

; 此例应与 “4. Parallel task ventilator.ahk” 联合使用

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

; Socket for control input
controller := context.socket(zmq.SUB)
controller.connect("tcp://localhost:5559")
controller.setsockopt_string(zmq.SUBSCRIBE, "")

; Process messages from receiver and controller
poller := zmq.Poller([[receiver, zmq.POLLIN]
                    , [controller, zmq.POLLIN]])
; Process messages from both sockets
loop
{
  socks := poller.poll()
  
  if (socks[1])
  {
    ; Do the work
    ; 完成任务（休眠指定时长）
    Sleep receiver.recv_string()
    
    ; Send results to sink
    ; 通知 sink 已完成任务
    sender.send_string("")
  }
  
  ; Any waiting controller command acts as 'KILL'
  ; 等待 sink 发出自杀信号
  if (socks[2])
    break
}

ExitApp

#Include %A_LineFile%\..\..\ZeroMQ\ZeroMQ.ahk