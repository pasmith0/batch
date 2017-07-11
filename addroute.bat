@echo off
REM This adds a route to the cable modem at 192.168.0.1
REM from the 192.168.1.x net so we can access the
REM cable modem when the VPN is running.
REM 
route -p add 192.168.0.0 MASK 255.255.255.0 192.168.1.1
