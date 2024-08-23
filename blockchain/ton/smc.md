# Smart Contract

1. generate the internal address
- return type: slice
- function specifier: impure and method id
- invoke random function to generate the address
- use the cell to store the data
- parse the cell and get the slice

# Parser

The namespace serves the purpose of separating the code items. The symbol value has the type and id. The symbol could be parameters, variables, functions, type names, global variables and constant variables. The symbol table is able to add and lookup the keywords. The source code can be represented by the file description. The file description holds the file name and its text content. 

The position and offset of source code can be obtained from the source location structure type. It is a story of parsing the source codes and putting the lexical items into the symbol table. The source code is a text and string type. The string operators are used to accomplish this parsing work. Since language rules are specified and known, the language items are recognized by applying pattern on the given text.


