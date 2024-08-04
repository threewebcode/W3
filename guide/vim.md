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

The command could be completed when the command expansion is enabled. The function is composed of prefix `ex` plus command name. When the command name is typed, the command action function is executed. The smile command can print out the characters which is like a smile picture. All of the commands can be found in the file named `ex_cmds.c`. The commands are listed in the header file. The command name and codes are mapped. 

The command line can be executed to change the content. It has the language capability. The control flow clauses can be used to orchestrate the commands. The comments are prefixed with double quote. The script and native commands are executed in the script file. The less command is mocked by the vim plugin ability. 

The keyboard event is captured and character is read. The function is invoked when the character is recognized. The content and screen is updated by the functions. The function has a related action name and keyboard character. The terminal and signal are used to capture the processing points. 

The window and prompt is defined in the terminal library. The particular header files are needed for the window system. The command is read to process the current file. The vim editor has block operation and script language. The command history can be used in the vim session. The command history can be listed by the history keyword. The command history can be scrolled by the key combination. 

The vim editor has the power of checking spell. The define directive is used to define the constant items. The structure type is used to represent the suggestion collection. The function prototype and concrete implementation are declared. 

The vim command arguments can affect the vim's behaviors during the startup period. When the file is loaded by the vim editor, the settings can be changed through the command line window. There are built-in commands and external commands. The window can also be spitted for different purpose. 

If you want to know the value of vim settings, you can use the set command plus the key name and question mark. The version command can tell you where are the paths used for loading the vim run commands. The shell command can be executed in the vim editor and the content can be also regarded as the command. The percent character in the command mode refers to the current file. However, it is the pair matching operator in the normal mode.

The vim has its grammar as the editing language. The macro and register is special powerful. All of the configurations and customizations can be done through the vim runtime commands files. The plugins and packages can also be added to expand its capabilities.

In the visual mode, you can select the content by character, line or block. The operations can be performed on the selected content. The window can be also separated for different purpose. When the help command is executed, a separate window is added. The shortcut keys are available for managing the windows. 

Multiple actions can be performed in the one mode. The mode can be switched. However, you can still do other mode's manipulations when keeping your current mode. The registers can be listed. If the register name is known, the pattern `register name + command` can be executed. There is a known register named system clipboard register. It name is called `+`. The clipboard is leveraged by manipulating this register.

The vim run command file can contain the vim scripts. The scripts and codes in the vim run command file will be executed when the vim is opened. The double quote is used to add the comments in the vim script file. Since many commands can be used in the vim editor, the commands can be grouped together as a vim script file. When the question marked is used, the set command will tell the current value of the option name. 

The key can be mapped with the existing command. When the new key is pressed, the correlated action is executed on the text object. The mode name is prefixed when you want to remap the new key. The abbreviation is same like mapping, but it has its own special scenarios. 

The motion has direction and scope. The direction are up, down, left, right. The scope is character, word, block, paragraph. The window can be splitted, switched and closed. 

The command list has call, cd, chdir, command, compiler, delete, edit, echo, eval, execute, exit, file, function, grep, insert, list, last, move, make, mark, normal, open, perl, python, pwd, read, right, ruby, shell, silent, visual, write and others. All of these commands can be executed in the command mode. 

The function in the `normal.c` file supports the operations in the normal mode. The help command provides the user manuals and developer manual. All of information can be referenced from the help command. It is important to know that vim is a programming language editor. It means that you can write the codes to make changes to the text objects. The grep, sed, awk commands are absorbed into this editor. 


