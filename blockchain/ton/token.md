# Token Contract

There are data, func, and tests item in the each section. The data is fift file. The func is all of source codes. The tests are about test codes in the func language. The smart contract address can be string format and can be converted into different parts by operator. The combination of dollar and smca are the operator of pack or unpack this conversion. The combination of file, arrow and B are the operator of perform the conversion between the file content and bytes. The string of character B, x and dot is able to output the bytes in the hex format. The transformation between the bag of cell and bytes are accomplished by the sequence of boc, B and arrow. There are slice and string append operation. 

The unsigned binary and ref cell can be appended into the stack. Each operation code has its name and number value. Every operation code can represent by a constant variable. The variable name is the name of the operation code and its value is the number format of the operation code. The constant variable is defined and exported from its own module. The compiler configuration is to tell all source code files which are to be compiled by the language compiler. 

The empty object corresponds to one empty cell bag. The concrete class is created to implement the contract interface. The parameters of constructor function are the contract address and initial state. The initial state includes the compiled binary code and initial data. The wallet is created from the provided address. The address is created on the basis of work chain id and initial data. The balance is the wallet data only if the state of the wallet is active. As a result, the state should be checked before fetching any data. 

To produce the message is the process of constructing the bag of cell. The double semicolon indicates the comments. Royalty parameters include royalty factor, royalty base, and royalty address. The comments state what kinds of data are storage in the current contract program. The storage items are owner address, next nft item index, cell reference(collection content and common content cell), nft item code, royalty parameters. 

The load data has the inline specifier and used in several place for data loading. The return type of the load data function is a tuple of several different type items. All of them are storage items. The get data function is standard library function of loading data from the contract storage. In essence, the get data function fetches a state storage tree under the hood. 

Both of impure and inline are the function specifiers of the save data function. The return type is an empty tuple. However, the input parameters are all of the data which need to be stored in the current program. The set data in the standard interface for data storage into the global chain storage. The nft item index and its owner address are the initial data of the initial state. The initial state of the nft item are its item code and its specific initial data. 

The item index in the collection, item binary code, amount, content data must be known when the nft item is planned to be deployed into the open network. The begin cell and end cell are the pair functions of building a cell type of data. The fist item in the cell message are the type or flag of the message which determines how the messages are processed. The sender address is the second item in the message cell. The operation code and query id are first and second items in the message body. 

The storage of nft item are the index in the collection, collection address, owner address and its content. The first item is flag value which indicates the different specific cases. The input parameters of send raw message are the message body and send mode. 

## Chinese Parts

智能合约地址包含两个部分：链标识和地址，目前只有一个主链和一个工作链，地址的总长度是4个字节加上32字节，当钱包
发送消息时，会检查目的地地址的合法性。地址具有测试网和主网的标识符，等同于说，一个地址可能只属于一个网络，如果
目标地址是未初始化状态的话，默认会强制关闭消息的弹回属性。所有权实体的描述和变更，首先有一个分类或者品类，具体
实体与这个品类关联并属于这个类别。不可拆分代币需要实现相关内部消息的处理接口，转移的接口的技术规范上对参数作出
了要求，有查询标识符，新所有者，响应地址，可选自定义数据项，发向新所有者的金额，发送给新所有者的数据包。

## TypeScript

Both integer and float point number are number types in the ts language. String is a type of representing the textual data. The boolean type represents a logical value. The null represents an intentional absence of any value. The symbol is a unique and immutable primitive value. The bigint represents integers with arbitrary precision. The object represents a non-primitive types. It includes array, function and user-defined type. There are two ways of declaring the array type. One is to use square bracket, the other is to use the array symbol type. The tuple is fixed-size array and each index can have different data type. The enumeration is a way to define a set named constants. The any type allows any kinds of values. The unknown type is similar to any, but it is more safer because type check is still performed. The void type indicates that the function does not return a value. The never type represents the values never occur. The union type allows a variable to have multiple types. The intersection type combines multiple types into one type.

The software development kits of ton network includes the wallet, contract, provider, ledger and data type as well as the data serialization. All of these stuffs can attach to one class or object. This object is imported and leveraged when beginning to interact with the ton network. 

## TonWeb

The core dependent object is fetch object implemented by the node.js language. It is used to send the http request. The different request has different request payload. The payload is determined by the function name. The recursive function is used to perform the block fetch and achieve the block subscription. Some actions can be executed when some block conditions are met. The memory is one area of data storage. 


