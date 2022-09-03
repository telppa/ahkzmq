; Report 0MQ version
; 
; Author: https://github.com/telppa/ahkzmq

#NoEnv
SetBatchLines -1

zmq := new ZeroMQ

MsgBox % "Current libzmq version is " zmq.version() ; libzmq = major + minor + patch
MsgBox % "Current ahkzmq version is " zmq.version("ahkzmq")
MsgBox % "Current major version is " zmq.version("major")
MsgBox % "Current minor version is " zmq.version("minor")
MsgBox % "Current patch version is " zmq.version("patch")

ExitApp

#Include %A_LineFile%\..\..\ZeroMQ\ZeroMQ.ahk