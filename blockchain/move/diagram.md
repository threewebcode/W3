## 系统上下文

```mermaid
graph TD
    %% 定义角色
    User((跨链用户 / 应用))

    %% 定义核心系统
    subgraph Sui_Ecosystem [Sui 跨链生态系统]
        direction TB
        
        Sui_Source["<b>Sui 源链网络 (Instance A)</b><br/>(内置 JMT + ZKVM 节点)<hr/>* 维护 JMT 全局状态树<br/>* 生成 ZK 状态证明<br/>* 发布带状态根的 Checkpoint"]
        
        Sui_Target["<b>Sui 目标链网络 (Instance B)</b><br/>(内置 JMT + ZKVM 节点)<hr/>* 运行 ZK 轻客户端逻辑<br/>* 验证外部网络的状态根<br/>* 执行跨链资产/消息结算"]
    end

    %% 定义中继组件
    Relayer["<b>中继器服务 (Relayer)</b><br/>(无须许可的传输层)<hr/>负责搬运 JMT 根、ZK 证明及消息"]

    %% 定义交互流
    User -->|1. 发起跨链调用| Sui_Source
    
    Sui_Source -.->|提供证明包| Relayer
    Relayer -.->|提交 ZK 证明 & JMT 路径| Sui_Target
    
    Sui_Target -->|验证成功后结算| User

    %% 样式美化
    style Sui_Source fill:#e3f2fd,stroke:#1565c0,stroke-width:2px
    style Sui_Target fill:#e3f2fd,stroke:#1565c0,stroke-width:2px
    style Relayer fill:#fff3e0,stroke:#ef6c00,stroke-dasharray: 5 5
    style User fill:#f5f5f5,stroke:#333
```

```mermaid
graph TD
    %% 样式定义
    classDef primary fill:#f0f7ff,stroke:#0052cc,stroke-width:2px,color:#000;
    classDef secondary fill:#ffffff,stroke:#666,stroke-dasharray: 5 5,color:#333;
    classDef actor fill:#fff,stroke:#333,stroke-width:1px;

    %% 参与者
    User((跨链用户)):::actor
    
    subgraph Sui_Ecosystem [Sui 跨链互操作架构]
        direction TB

        subgraph Instance_A [Sui 网络 A - 源链]
            direction TB
            A_Core["<b>Sui 核心共识层</b><br/>(内置 JMT 状态机)"]
            A_Pub["<b>Checkpoint 发布</b><br/>(含 JMT 全局状态根)"]
            A_ZK["<b>ZKVM 证明服务</b><br/>(异步生成状态转换证明)"]
            
            %% A 内部逻辑顺序
            A_Core -->|1. 计算状态根| A_Pub
            A_Pub -->|2. 触发证明生成| A_ZK
        end

        subgraph Instance_B [Sui 网络 B - 目标链]
            B_Client["<b>ZK 轻客户端模块</b><br/>(内置验证逻辑)"]
            B_Exec["<b>结算与执行</b><br/>(跨链资产释放)"]
            
            B_Client --> B_Exec
        end

        %% 中继组件
        Relayer["<b>中继器 (Relayer)</b><br/>(无须信任的数据搬运工)"]
    end

    %% 跨网络交互流
    User -->|发起请求| A_Core
    A_Pub -.->|3. 提交状态根| Relayer
    A_ZK -.->|4. 提供 ZK 证明| Relayer
    Relayer -.->|5. 转发证明与路径| B_Client
    B_Exec -->|6. 完成跨链| User

    %% 类应用
    class A_Core,A_Pub,A_ZK,B_Client,B_Exec primary;
    class Relayer secondary;
```

## 容器图 (Sui 节点 JMT 核心集成)

```mermaid

graph TD
    %% 样式定义
    classDef container fill:#f0f7ff,stroke:#0052cc,stroke-width:2px,color:#000;
    classDef storage fill:#ffffff,stroke:#333,stroke-dasharray: 5 5,color:#333;
    classDef highlight fill:#e1f5fe,stroke:#01579b,stroke-width:3px;

    subgraph Sui_Node [Sui 验证节点 / 全节点]
        
        %% 核心逻辑容器
        Exec["<b>执行引擎 (Execution Engine)</b><br/>(Sui VM)<br/>处理事务并生成<br/>Object 变更集 (Writesets)"]:::container
        
        JMT_Mod["<b>JMT 模块 (JMT Module)</b><br/>(Jellyfish Merkle Tree)<br/>根据对象变更计算<br/>版本化的状态根"]:::highlight

        Consensus["<b>共识容器 (Consensus)</b><br/>(共识引擎)<br/>将状态根打包至<br/>最终确定的 Checkpoint"]:::container

        RPC["<b>RPC 证明服务 (RPC Service)</b><br/>(JSON-RPC)<br/>向外部客户端提供<br/>JMT 包含证明 (Inclusion Proof)"]:::container

        %% 存储层
        subgraph Data_Layer [持久化存储层]
            Obj_DB[("Object 存储<br/>(RocksDB)")]:::storage
            JMT_DB[("JMT 节点存储<br/>(LSM-Tree)")]:::storage
        end
    end

    %% 内部数据流转
    Exec -->|1. Object 变更集| JMT_Mod
    Exec -->|2. 原始对象数据| Obj_DB
    
    JMT_Mod -->|3. 节点持久化| JMT_DB
    JMT_Mod -->|4. 待确定的状态根| Consensus
    
    Consensus -->|5. 固化 Checkpoint + 状态根| RPC
    JMT_DB -.->|6. 获取路径数据| RPC

    %% 外部交互
    Client((轻客户端)) --- RPC

    %% 备注
    note["JMT 模块弥合了基于对象的执行<br/>与基于 Merkle 的全局状态之间的鸿沟"]
```
