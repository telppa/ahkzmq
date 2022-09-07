; Send & recv multi frame binary - server

#NoEnv
SetBatchLines -1

zmq := new ZeroMQ

context := zmq.context()
socket := context.socket(zmq.REP)
socket.bind("tcp://*:5555")

loop 10000
{
  buf_arr := socket.recv_binary()                   ; the return value of recv_binary() must be parsed with parse_buffer_array()
  socket.send_string("4_recv.ico")
}

zmq.parse_buffer_array(str_out, buf_arr, 1)         ; save frame 1 to variable str_out
size := zmq.parse_buffer_array(var_out, buf_arr, 2) ; save frame 2 to variable var_out

f := FileOpen("4_recv.ico", "w")                    ; save the variable var_out to the file 4_recv.ico
f.RawWrite(var_out, size)
f.Close()

MsgBox % StrGet(&str_out)                           ; show frame 1

ExitApp

#Include %A_LineFile%\..\..\ZeroMQ\ZeroMQ.ahk