@echo off
cd "C:\Program Files\MongoDB\Server\8.0\bin"
start mongod.exe
timeout 4
start mongosh.exe
exit