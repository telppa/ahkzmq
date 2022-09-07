; Weather update - client
; This example demonstrates receiving weather information from the server for a specified area.
; This example uses the PUB/SUB mode, also known as publish/subscribe mode.
; Note: In this mode, the client must use setsockopt to set the content to be subscribed, otherwise it will not receive any messages.
; The subscription can be set multiple times, or you can set a null value to subscribe all the contents, and you can also set the contents that you don't subscribe.
; If you do not synchronize a SUB and PUB socket, you may lose some of the started messages due to "slow connection".
; Advanced Examples 13 is an example of synchronize.

#NoEnv
SetBatchLines -1

zmq := new ZeroMQ

context := zmq.context()
socket := context.socket(zmq.SUB)
socket.connect("tcp://localhost:5556")

filter := "10001 "
socket.setsockopt_string(zmq.SUBSCRIBE, filter) ; subscribe messages starting with "10001 "

loop 5                                          ; receive 5 messages
  MsgBox % socket.recv_string()

ExitApp

#Include %A_LineFile%\..\..\ZeroMQ\ZeroMQ.ahk