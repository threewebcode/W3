# VIM Anatonmy

The `vim.h` file is an important file. It is included in the every file. The constant variabes are defined by the define directive. Some functions are prefixed with `static` keyword so that its storage duration is the whole execution lifetime. The argument number and itself are the input parameters of the main function. The common functions are executed to finish the initialization work.

The commands from the command line options are performed before the main process logic. If there is startup script file, it is sourced as well. The main function is executed and the result is returned. The plugin files are read and parsed. The runtime file is also sourced and executed. If the gui is enabled, the gui is opened.

The final step is `main_loop` function. There is a function which can detect that it is not a terminal. The main loop enters into the normal mode and accepts the commands from the keyboard, update the content on the screen. The command line is scanned when the vim is started. The different command line patterns are recognized. It may be the last line number, the specified number, search pattern or inner commands. 

The environment variable is another import aspect which can affect the behaviors of the vim editor. The statement is selected on the basis of conditional variable's value. 


