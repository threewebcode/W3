# VIM Anatonmy

The `vim.h` file is an important file. It is included in the every file. The constant variabes are defined by the define directive. Some functions are prefixed with `static` keyword so that its storage duration is the whole execution lifetime. The argument number and itself are the input parameters of the main function. The common functions are executed to finish the initialization work.

The commands from the command line options are performed before the main process logic. If there is startup script file, it is sourced as well. The main function is executed and the result is returned. The plugin files are read and parsed. The runtime file is also sourced and executed. If the gui is enabled, the gui is opened.


