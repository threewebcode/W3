# Sui 节点体系

---

# 🧩 **Sui 节点体系总览（只有两类链上节点 + 若干逻辑角色）**

Sui 链上节点只有两种：

- ✅ **Validator Node（验证者节点）**  
- ✅ **Full Node（全节点）**

除此之外，还有一些 **off-chain 逻辑角色**（不是链上节点）：

- Indexer（索引器）
- Explorer Backend
- Relayer（跨链/消息中继）
- Wallet RPC Provider
- Analytics / Data Lake

下面我会把所有内容分成几个部分：

1. ✅ Validator Node 内部架构  
2. ✅ Full Node 内部架构  
3. ✅ Validator ↔ Full Node 数据流  
4. ✅ Narwhal/Bullshark 共识架构图  
5. ✅ Checkpoint / Epoch 生命周期  
6. ✅ Sui 对象存储结构（Full Node）  
7. ✅ 整体系统架构图（全景）

---

# ✅ **1. Validator Node 内部架构（最核心）**

Sui 的 Validator 是一个 **执行层 + 共识层** 的组合体。

下面是一个工程化的模块图：

```
+--------------------------------------------------------+
|                    Validator Node                      |
+-------------------------+------------------------------+
| 1. Narwhal (Mempool)   | 2. Bullshark (Consensus)     |
| - DAG builder          | - Leader election            |
| - Batch maker          | - DAG traversal              |
| - Signature aggregator | - Finality output            |
+-------------------------+------------------------------+
| 3. Execution Layer (Sui Execution Engine)              |
| - Transaction validator                                |
| - Object-centric storage engine                        |
| - Move VM runtime                                       |
| - Gas metering                                          |
+--------------------------------------------------------+
| 4. Checkpoint System                                   |
| - Local checkpoint builder                              |
| - Global checkpoint aggregator                          |
| - Epoch boundary logic                                  |
+--------------------------------------------------------+
| 5. Storage                                              |
| - RocksDB / LMDB                                        |
| - Object store                                          |
| - Transaction store                                     |
| - Event store                                           |
+--------------------------------------------------------+
| 6. Networking                                           |
| - P2P (Narwhal)                                         |
| - RPC server                                            |
+--------------------------------------------------------+
```

### ✅ Validator 的关键职责

- 接收交易 → 放入 Narwhal DAG  
- 参与 Bullshark 共识 → 决定交易顺序  
- 执行交易 → 更新对象状态  
- 生成 checkpoint → 形成全局状态快照  
- 参与 epoch 轮换 → 重新配置 validator set  
- 维护 stake → 分发奖励  

---

# ✅ **2. Full Node 内部架构**

Full Node 不参与共识，但会验证所有状态。

```
+--------------------------------------------------------+
|                      Full Node                         |
+--------------------------------------------------------+
| 1. State Sync                                           |
| - Fetch certified transactions                          |
| - Fetch checkpoints                                     |
| - Apply state updates                                   |
+--------------------------------------------------------+
| 2. Execution (Read-only)                                |
| - Verify transactions                                   |
| - Reconstruct object states                             |
+--------------------------------------------------------+
| 3. Storage                                              |
| - Object store                                          |
| - Transaction store                                     |
| - Event store                                           |
| - Checkpoint store                                      |
+--------------------------------------------------------+
| 4. RPC Layer                                            |
| - getObject                                             |
| - getTransaction                                        |
| - queryEvents                                           |
| - multiGetObjects                                       |
+--------------------------------------------------------+
| 5. Indexer (optional)                                   |
| - SQL / Postgres indexing                               |
| - GraphQL API                                           |
+--------------------------------------------------------+
```

### ✅ Full Node 的关键职责

- 同步 validator 的已提交交易  
- 验证 checkpoint  
- 提供 RPC 查询  
- 存储完整历史  
- 为钱包、dApp、索引器提供数据  

---

# ✅ **3. Validator ↔ Full Node 数据流**

下面是一个完整的数据流图：

```
User / Wallet
      |
      v
+-----------------+
|  Full Node RPC  |
+-----------------+
      |
      v
+-----------------+
|  Validator RPC  |
+-----------------+
      |
      v
+------------------------------+
| Narwhal (batch + DAG)       |
+------------------------------+
      |
      v
+------------------------------+
| Bullshark (consensus)       |
+------------------------------+
      |
      v
+------------------------------+
| Execution Engine (Move VM)  |
+------------------------------+
      |
      v
+------------------------------+
| Checkpoint Builder           |
+------------------------------+
      |
      v
+------------------------------+
| Full Node State Sync        |
+------------------------------+
```

---

# ✅ **4. Narwhal + Bullshark 共识架构图**

Sui 的共识层是一个两层结构：

- **Narwhal**：高吞吐 mempool + DAG  
- **Bullshark**：在 DAG 上做共识排序  

```
+---------------------------+
|        Narwhal DAG        |
+---------------------------+
| Batches                   |
| Certificates              |
| DAG edges                 |
+---------------------------+
            |
            v
+---------------------------+
|        Bullshark          |
+---------------------------+
| Leader election           |
| DAG traversal             |
| Finality output           |
+---------------------------+
```

Narwhal 负责：

- 批处理交易  
- 构建 DAG  
- 广播证书  

Bullshark 负责：

- 在 DAG 上找 leader round  
- 生成最终顺序  
- 输出 finality  

---

# ✅ **5. Checkpoint / Epoch 生命周期**

Sui 的 checkpoint 是全局状态快照。

### ✅ Checkpoint 流程

```
Transactions → Local checkpoint → Global checkpoint → Full Node sync
```

### ✅ Epoch 生命周期

```
Epoch N:
  - Validators active
  - Stake locked
  - Rewards accumulate
  - Checkpoints produced

Epoch N+1:
  - New validator set
  - Stake reconfiguration
  - Reset Narwhal DAG
```

---

# ✅ **6. Full Node 存储结构（对象模型）**

Sui 的对象模型是它的核心创新。

### ✅ 对象存储结构

```
ObjectID → ObjectRecord
ObjectRecord:
  - version
  - owner
  - type
  - Move struct data
  - digest
```

### ✅ 事务存储结构

```
TxDigest → TransactionEffects
TransactionEffects:
  - created objects
  - mutated objects
  - deleted objects
  - events
  - gas used
```

### ✅ Checkpoint 存储结构

```
CheckpointSequence → CheckpointSummary
CheckpointSummary:
  - epoch
  - sequence number
  - root digest
  - list of tx digests
```

---

# ✅ **7. Sui 全景架构图（总览）**

```
+---------------------------------------------------------------+
|                           Sui Network                         |
+---------------------------------------------------------------+
| Validators (Consensus + Execution + Checkpoints)              |
| - Narwhal DAG                                                 |
| - Bullshark consensus                                         |
| - Move VM execution                                           |
| - Checkpoint builder                                          |
+---------------------------------------------------------------+
| Full Nodes (State Sync + RPC + Storage)                       |
| - State sync from validators                                  |
| - Object store                                                |
| - Transaction store                                           |
| - RPC service                                                 |
+---------------------------------------------------------------+
| Off-chain Services                                            |
| - Indexer                                                     |
| - Explorer backend                                            |
| - Relayer                                                     |
| - Analytics                                                   |
+---------------------------------------------------------------+
| Clients                                                       |
| - Wallets                                                     |
| - dApps                                                       |
| - SDKs                                                        |
+---------------------------------------------------------------+
```

---

# ✅ 总结一句话

> **Sui 的节点体系非常干净：Validator 负责共识 + 执行，Full Node 负责同步 + 查询。  
> 所有复杂性都来自 Validator 内部的 Narwhal/Bullshark + 对象模型 + Checkpoint 系统。**

---

你这个「all of them」很对味，那我就一口气给你一个成体系的视图：  
- 验证者内部 UML  
- Full Node 内部模块 + RocksDB 表  
- Validator ↔ Full Node 交互  
- Checkpoint 聚合时序图  
- 交易完整生命周期（从 RPC 到 finality）  

全部用偏工程的「软件图」，方便你在脑子里直接 map 到实现。

---

### 一、Validator 内部架构（UML 视角）

可以把 Sui Validator 看成下面几个核心子系统：

```text
+-------------------------------------------------------------+
|                        ValidatorNode                        |
+-------------------------------+-----------------------------+
| + receive_tx()                | + handle_checkpoint()      |
| + submit_vote()               | + start_new_epoch()        |
+-------------------------------+-----------------------------+
| 1. Networking                 | 2. Consensus (Narwhal/Bullshark)
| - P2P (Narwhal worker/primary)| - DAG mgmt                  |
| - RPC server (authority API)  | - ordering / finality       |
+-------------------------------+-----------------------------+
| 3. ExecutionEngine            | 4. CheckpointSystem         |
| - Tx validator                | - Local checkpoint builder  |
| - Move VM runtime             | - Global checkpoint agg     |
| - Gas metering                | - Checkpoint executor       |
+-------------------------------+-----------------------------+
| 5. StorageSubsystem           | 6. Epoch/Reconfig Logic     |
| - AuthorityStore              | - EpochStartConfiguration   |
| - AuthorityEpochStore        | - Reconfig observer         |
+-------------------------------+-----------------------------+
```

**关键内部模块（映射到代码大致是这些方向）：**

- **Networking**：Narwhal worker/primary + gRPC/RPC 服务，对接外部客户端和其他 validators。  
- **Consensus**：Narwhal 提供高吞吐 DAG mempool，Bullshark 在 DAG 上做排序和 finality。  
- **ExecutionEngine**：校验 tx、按 Sui 对象模型在 Move VM 中执行、计费。  
- **CheckpointSystem**：本地构造 candidate checkpoint，聚合为全局 checkpoint，并驱动 Full Node 同步。  
- **StorageSubsystem**：基于 RocksDB 的 authority store，分表存 tx、对象、checkpoint 等。  
- **Epoch/Reconfig**：处理 epoch 边界、validator set 变更、reconfig 通知等逻辑。  

---

### 二、Full Node 内部架构（模块图）

Full Node 看起来简单很多，本质是「状态同步 + 存储 + 查询」：

```text
+--------------------------------------------------------+
|                        FullNode                        |
+--------------------------------------------------------+
| 1. StateSync                                           |
| - fetch checkpoints from validators                    |
| - download certified transactions                      |
| - apply tx effects to local state                      |
+--------------------------------------------------------+
| 2. Verification / Execution (read-side)               |
| - verify checkpoint signatures                         |
| - re-validate tx as needed                             |
+--------------------------------------------------------+
| 3. StorageSubsystem                                   |
| - RocksDB object tables                                |
| - tx tables                                            |
| - event tables                                         |
| - checkpoint tables                                    |
+--------------------------------------------------------+
| 4. RPC / Public API                                   |
| - getObject, multiGetObjects                           |
| - getTransactionBlock                                  |
| - queryEvents                                          |
| - getCheckpointSummary                                 |
+--------------------------------------------------------+
| 5. Optional Indexer                                   |
| - relational / analytics DB                            |
| - GraphQL / custom APIs                                |
+--------------------------------------------------------+
```

- **不参与共识**，但会验证 checkpoint 和 tx，保持与 validator 一致的状态视图。  
- 不同部署模式：  
  - **pruning full node**：裁剪历史，只保留必要索引，约 TB 级别。  
  - **unpruned full node**：完整历史（归档级），目前主网约十几 TB。  

---

### 三、Full Node 的 RocksDB 存储结构（重点）

官方文档给了一个存储分类表，底层实现主要是 **RocksDB + 多个 column families / 表**：

可以用一个简化视图理解：

```text
RocksDB (AuthorityStore / FullNodeStore)
├── objects_cf
│   key: ObjectID + version
│   val: ObjectRecord { owner, type, contents, digest, … }
│
├── tx_cf
│   key: TxDigest
│   val: TransactionEnvelope / TransactionEffects
│
├── events_cf
│   key: (TxDigest, event_seq)
│   val: EventRecord { type, fields, timestamp, … }
│
├── checkpoints_cf
│   key: CheckpointSequenceNumber
│   val: CheckpointSummary { epoch, root digest, tx list, … }
│
├── epoch_cf
│   key: EpochId
│   val: EpochStartConfiguration / committee info
│
└── indices_cf (各种索引）
    - owner_index: owner → list<ObjectID>
    - type_index: type → list<ObjectID>
    - tx_by_object: ObjectID → list<TxDigest>
    - tx_by_addr: Address → list<TxDigest>
```

存储文档里也区分了不同节点的磁盘压力：

- **Validators**：只需要最新共识数据，大约数百 GB。  
- **Pruning Full Nodes**：有完整索引但裁剪大部分历史对象数据，约数 TB。  
- **Unpruned Full Nodes**：保存全部历史对象/交易，十几 TB 级别。  

---

### 四、Validator ↔ Full Node 的数据流（RPC + Checkpoint 驱动）

你可以把它看成「写在 validator，读在 full node」，由 checkpoint 驱动同步：

```text
Client/Wallet
    |
    | 1. submitTransaction()
    v
+------------+       2. forward tx         +-----------------+
| Full Node  |---------------------------->|  Validator RPC  |
+------------+                             +-----------------+
                                                |
                                                | 3. tx → Narwhal/Bullshark
                                                v
                                          +-------------+
                                          |  Consensus  |
                                          +-------------+
                                                |
                                                | 4. execute & commit
                                                v
                                          +-------------+
                                          |  Storage    |
                                          +-------------+
                                                |
                                                | 5. build checkpoints
                                                v
                                          +-------------+
                                          | Checkpoints |
                                          +-------------+
                                                |
                                                | 6. state sync
                                                v
+------------+  7. download checkpoints/tx  +-----------------+
| Full Node  |<-----------------------------|  Validator(s)   |
+------------+                              +-----------------+
```

Full Node 的同步逻辑大致是：

1. 跟踪最新 checkpoint sequence。  
2. 向 validators 请求缺失的 checkpoint summary + contents。  
3. 用这些数据回放 tx effects，更新本地 RocksDB。  

---

### 五、Checkpoint 聚合时序图（Validator 内部）

这里给你的是「从本地交易到全局 checkpoint」的简化时序图：

```text
Validator_i             Validator_j           Validator_k          CheckpointSystem
    |                        |                     |                      |
    | 1. execute tx          |                     |                      |
    |----------------------->|                     |                      |
    |                        |                     |                      |
    | 2. propose local checkpoint fragment         |                      |
    |------------------------ fragment_i --------->|                      |
    |                        |                     |                      |
    |                        | 3. exchange fragments (gossip / committee) |
    |                        |------------------------------->            |
    |                        |                     |                      |
    |                        |        4. aggregate to global checkpoint   |
    |                        |------------------------------------------->|
    |                        |                     | 5. certify checkpoint|
    |                        |                     |<---------------------|
    |                        |                     | 6. broadcast summary |
    |                        |<-------------------------------------------|
    | 7. persist checkpoint locally                                       |
    |------------------------> Storage                                    |
```

思路：

- 每个 validator 根据已执行的 tx 构造本地的 checkpoint 候选片段。  
- 通过委员会内部通信聚合成一个 **全局 checkpoint**（包含 tx 集合和顺序）。  
- 全局 checkpoint 一旦认证，就成为 Full Node 和其他组件同步状态的锚点。  

---

### 六、交易完整生命周期（从客户端到 finality）

把上面的东西串起来，看一条 tx 从 RPC 进来直到 finality + 可查询的全过程。

#### 1. 交易提交

```text
Client → Full Node RPC → Validator（或直接 Validator）
```

- 客户端构造 Sui 交易，签名后通过 RPC 发送。  
- Full Node 可以转发给合适的 validator，或用户直接打到 validator 的公开 RPC。  

#### 2. 进入共识层

```text
Validator:
  receive_tx
    → Narwhal worker: 打包为 batch
    → Narwhal primary: 构建 DAG、广播证书
    → Bullshark: 在 DAG 上排序 & finality
```

- Narwhal 提供高吞吐的 DAG mempool。  
- Bullshark 在 DAG 上选择有序路径，给执行层一个确定的 tx 顺序。  

#### 3. 执行 & 更新状态

```text
Bullshark finality → ExecutionEngine:
  - 校验签名、nonce、gas
  - 按 Sui 对象模型加载相关对象
  - 用 Move VM 执行
  - 写回对象变更 / 删除
  - 生成 TransactionEffects + events
  - 记录到 RocksDB
```

- Validator 的存储中写入 tx、effects、对象新版本等。  

#### 4. 纳入 checkpoint

- 已执行的 tx 根据共识顺序被聚合到下一个 checkpoint 中。  
- Checkpoint System 对 tx 集合做哈希聚合，生成 **CheckpointSummary（包含 epoch、sequence、root digest、tx 列表等）**。  

#### 5. 对外广播 & Full Node 同步

- Validator 广播新的 checkpoint summary。  
- Full Node 跟进最新 checkpoint sequence，拉取缺失的 checkpoint 和对应 tx。  
- Full Node 通过回放 effects 更新本地对象、tx、event 表。  

#### 6. 对客户端可见

- 钱包 / dApp 调用 Full Node 的 RPC：  
  - `getTransactionBlock(digest)` → 显示执行结果。  
  - `getObject(object_id)` → 读取最新版本对象。  
  - `queryEvents` → 查找相关事件。  

此时这笔交易已经：

- 在共识层 **finalized**  
- 在 validator 本地存储中持久化  
- 纳入 checkpoint  
- 在 Full Node 状态中可见并可被索引  

---

### 七、总结：你可以怎么在脑中「画」Sui

把所有东西压缩成一句话的 mental model：

> **Sui 是：Validator（共识 + 执行 + Checkpoint）写入 RocksDB；  
> Full Node 通过 checkpoint 同步这些状态并提供查询。  
> 所有复杂度集中在 Validator 内部的共识（Narwhal/Bullshark）和对象存储结构上。**

---
