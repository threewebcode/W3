# Diagram

1. Scalable Blockchain

```mermaid
flowchart LR
    subgraph 链下存储
        R[(IPFS)]
        S[(HDFS)]
    end

    subgraph 主链网络
        direction LR 
        A[(节点)]
        B[(节点)]
        A <-- 组建 --> B
    end

    subgraph 同构子网网络
        direction LR 
        H[(节点)]
        I[(节点)]
        H <-- 组建 --> I
    end

    subgraph 异构网络
        direction LR 
        O[(节点)]
        P[(节点)]
        O <-- 组建 --> P
    end

    主链网络 --> |存储接口| 链下存储
    同构子网网络 --> |链间标准接口| 主链网络
    主链网络 <-- 跨链 --> 异构网络
```

2. Editable Blockchain

```mermaid
flowchart LR
    subgraph 密码功能
        direction TB
        A[加密]
        B[解密]
        C[哈希]
        D[签名]
        E[验签]
        A ~~~ B ~~~ C ~~~ D ~~~ E
    end

    subgraph 抽象层
        F(接口抽象)
        G(统一封装)
        F ~~~ G
    end

    subgraph 实现层

        subgraph 国际算法
            H[软件实现]
            I[硬件实现]
        end

        subgraph 国密算法
            J[软件实现]
            K[硬件实现]
        end

        国际算法 ~~~ 国密算法

    end

    密码功能 --> |实现| 抽象层 --> |调用| 实现层

```

3. Dynamic Network

```mermaid
flowchart LR
    subgraph 区块链网络
        A[(节点)]
        B[(节点)]
        A <-- P2P协议--> B
    end
    subgraph 节点发现服务
        C(节点列表)
        D(心跳服务)
        E(黑名单记录)
        C ~~~ D ~~~ E
    end

    节点发现服务 <-- 节点动态管理--> 区块链网络

    F[(新建节点)] --> |加入| 区块链网络
    F[(新建节点)] --> |管控| 节点发现服务

    G[(无效节点)] --> |退出| 区块链网络
    G[(无效节点)] --> |管控| 节点发现服务
```

4. Verifiable Data

```mermaid
flowchart LR
    
    subgraph 区块链网络
        A[(全节点)]
        B[(全节点)]
        A <-- P2P协议 --> B
    end

    subgraph 门户网络
        direction TB
        C(状态数据)
        D(历史数据)
        E(索引数据)
        F(区块头数据)
        G(交易数据)
        J(服务接口)
        C ~~~ D
        E ~~~ F
        G ~~~ J
    end

    门户网络 --> |同步| 区块链网络
    H[(轻节点)] --> |同步| 区块链网络
    I[验证数据] --> |请求| 门户网络 & H
```


