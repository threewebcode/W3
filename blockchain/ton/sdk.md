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


