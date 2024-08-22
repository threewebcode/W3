# Core Types

The composition of account type:
  - address
  - storage information
  - account storage

The state of account:
  - uninit
  - active
  - frozen

The field list of account storage:
  - last transactions
  - account balance
  - account status

The union type of common message:
  - common internal message
  - common external in message
  - common external out message

The data structure of common message:
  - message type
  - disabled
  - bounce
  - bounced
  - source address
  - destination address
  - currency value
  - fee
  - forward fee
  - timestamps

The reasons of skipping compute:
  - bad state
  - no state
  - no gas

The extra information of master chain configurations:
  - configuration address
  - configuration map of cell collection
  - global balance

The definition of the message type:
  - common message information
  - init state
  - cell body

The value list of reserve mode:
  - this amount
  - leave this amount
  - at most this amount
  - leave max this amount
  - before balance plus this amount
  - leave balance plus this amount
  - before balance minus this amount
  - leave before balance minus this amount

The enumeration list of send mode:
  - carry all remaining balance
  - carry all remaining incoming value
  - destroy account if zero
  - pay gas separately
  - ignore errors
  - none

The member fields of shard identity:
  - shard prefix bits
  - work chain id
  - shard prefix

The interface definition of state initialization:
  - split depth
  - special
  - code
  - data
  - libraries

The property list of storage information:
  - used storage
  - last paid
  - due payment

The data structure of transaction type:
  - address
  - timestamp
  - previous transaction hash
  - previous transaction logical time
  - out messages count
  - old status
  - end status
  - in message
  - out messages
  - total fees
  - state update
  - transaction description
  - raw cell data
  - hash value

The attribute list of transaction action phase:
  - boolean value of success
  - boolean value of valid
  - boolean value of no funds
  - account status change
  - total forward fee
  - total action fees
  - result code
  - result arguments
  - total actions
  - special actions
  - skipped actions
  - message created
  - action list hash
  - total message size

# BluePrint

The build variable is one instance of runner type. The runner is a function type. This function selects the compiler and runs the build task. The record is the collection of runner. The runner is found and executed as the command line. The first argument is used to detect the runner name and its mapping function.

The string manipulation and file system location are used to find the compiler and its target directory. The code items are imported from the specified file. The interface can only have the fields and empty method set. The configuration includes the network and plugins. The new type can be created by the equal operator. The interface is created by the definition syntax and does not use any operators. 

One plugin has the array of plugin runners. The plugin runner is runnable. The local variable declaration is let keyword plus the variable name plus the colon plus the variable type. 

All aspects of the network provider:
  - interface type
  - network method to tell the which network is used
  - sender method to find the message sender
  - api method to return the ton client
  - contract provider to offer the contract provider object by the input parameters
  - is contract deployed to detect whether the contract is on the chain
  - wait for deploy
  - deploy method to publish the contract on the ton chain
  - open method to produce the opened contract
  - ui method to manufacture the ui provider

The item can be added, obtained and removed through the storage interface. The actual implementation of this storage is json file in the file system. The whole utilities are divided into the subfields which contains the object, time, ton and selection. The compilable files can be found by the pattern and collection filter. The scripts can be found by the directory name and file extension.

The name and path are enough fields to describe a file. The question mark is used to detect whether the object is null or undefined. The error is found ahead of the method invocation. When the question mark appears the end of the fields, it means that this field is optional. The intersection two types can produce a new type. The compile hooks can be performed before and after the compile step.

The special file name is leveraged to denote its particular purpose because it is easy to be recognized. The method id is a function specifier which tells ton chain that this is query function in the smart contract. 
