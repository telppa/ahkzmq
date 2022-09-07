; Send & recv string - client
; This example demonstrates sending 10,000 messages to the server and receiving 10,000 responses from the server.
; This example uses the REQ/REP mode, also known as request/response or question/answer mode.
; Note: In this mode, the order REQ_send-REP_receive-REP_send-REQ_receive is strictly followed.
; An error will be reported if the order is changed, e.g. REQ_send-REQ_send-REP_receive-REP_send-REQ_receive.

#NoEnv
SetBatchLines -1                       ; maximum speed

zmq := new ZeroMQ                      ; init ZeroMQ

context := zmq.context()               ; create a context
socket := context.socket(zmq.REQ)      ; create a socket with REQ
socket.connect("tcp://localhost:5555") ; connect to endpoint

loop 10000
{
  socket.send_string("Hello")          ; send "Hello" to server
  msg := socket.recv_string()          ; receiving response from the server
}

MsgBox Client received reply %msg%

ExitApp                                ; automatic resource release on exit

#Include %A_LineFile%\..\..\ZeroMQ\ZeroMQ.ahk