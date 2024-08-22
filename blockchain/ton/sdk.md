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


