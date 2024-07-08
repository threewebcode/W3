# VIM Anatomy

The `vim.h` file is an important file. It is included in the every file. The constant variables  are defined by the define directive. Some functions are prefixed with `static` keyword so that its storage duration is the whole execution lifetime. The argument number and itself are the input parameters of the main function. The common functions are executed to finish the initialization work.

The commands from the command line options are performed before the main process logic. If there is startup script file, it is sourced as well. The main function is executed and the result is returned. The plugin files are read and parsed. The runtime file is also sourced and executed. If the gui is enabled, the gui is opened.

The final step is `main_loop` function. There is a function which can detect that it is not a terminal. The main loop enters into the normal mode and accepts the commands from the keyboard, update the content on the screen. The command line is scanned when the vim is started. The different command line patterns are recognized. It may be the last line number, the specified number, search pattern or inner commands. 

The environment variable is another import aspect which can affect the behaviors of the vim editor. The statement is selected on the basis of conditional variable's value. 

The `vim.h` header file contains almost everything about the vim editor. The keyboard is used to replace the mouse. All features and capabilities of mouse are depicted by the constant variables. The variables of vim is prefixed by double v characters. 

There are different modes of each action. The characters can be used to do the search and position the cursor. The special characters are used to denote the text block. When the character is typed, it undoes or redoes previous typing. 

Each event has a list of autocommands. The order of autocommands are important. The order determines  which is executed before the next one. The command and pattern are pairs. When the event happens, the command is executed automatically. The commands are showed by the pattern. The relationship between the command and pattern can be removed and cleaned. The functions are defined to represent the commands. 

The autocommands can be managed by the command line and the command name is autocmd. The command executed in the command mode is prefixed with `do` word. The current file information can be obtained from the file command. 

The column and row could be figured out when the cursor is known. The expression is evaluated and found the matched text around the cursor. The character is insert command. The different character means different insert commands. The insert command can be insert, replace and append. The edit command can happen in the visual mode. The first letter is `g` character. One function is used to support all kinds of edit modes. 


