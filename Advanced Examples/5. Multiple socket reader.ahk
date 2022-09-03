; Reading from multiple sockets
; This version uses a simple recv loop
; 
; Author: https://github.com/telppa/ahkzmq

#NoEnv
SetBatchLines -1

zmq := new ZeroMQ

context := zmq.context()

; Connect to task ventilator
; 连接任务分发器
receiver := context.socket(zmq.PULL)
receiver.connect("tcp://localhost:5557")

; Connect to weather server
; 连接气象更新服务
subscriber := context.socket(zmq.SUB)
subscriber.connect("tcp://localhost:5556")
subscriber.setsockopt_string(zmq.SUBSCRIBE, "10001 ") ; filter = "10001 "

; Process messages from both sockets
; We prioritize traffic from the task ventilator
loop
{
  ; Process any waiting tasks
  loop
  {
    try
      msg := receiver.recv_string(zmq.DONTWAIT)
    catch e
      if (e.extra = zmq.EAGAIN)
        break
    
    ; show task
    times++
    ToolTip % "tasks: " times " - " msg, 500, 500, 1
  }
  
  ; Process any waiting weather updates
  loop
  {
    try
      msg := subscriber.recv_string(zmq.DONTWAIT)
    catch e
      if (e.extra = zmq.EAGAIN)
        break
    
    ; show weather update
    ToolTip % "weather: " msg, 500, 550, 2
  }
  
  ; No activity, so sleep for 1 msec
  Sleep 1
}

ExitApp

#Include %A_LineFile%\..\..\ZeroMQ\ZeroMQ.ahk