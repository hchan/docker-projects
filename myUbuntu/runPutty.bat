@REM note that putty uses "-P" uppercase for port
@REM putty root@localhost -P 22222 -i id.ppk
@REM I could figure out how to set UTF-8 by putty command line
@REM Settings in putty are Window->Translation.  Oh well ... use 'load'
putty -load my-ubuntu  -P 22222 -i id.ppk
