; Send & recv binary - server

#NoEnv
SetBatchLines -1

zmq := new ZeroMQ

context := zmq.context()
socket := context.socket(zmq.REP)
socket.bind("tcp://*:5555")

loop 10000
{
  buf_arr := socket.recv_binary()                ; the return value of recv_binary() must be parsed with parse_buffer_array()
  socket.send_string("2_recv.ico")
}

size := zmq.parse_buffer_array(var_out, buf_arr) ; converts the received object buf_arr to the variable var_out

f := FileOpen("2_recv.ico", "w")                 ; save the variable var_out to the file 2_recv.ico
f.RawWrite(var_out, size)
f.Close()

ExitApp

#Include %A_LineFile%\..\..\ZeroMQ\ZeroMQ.ahk