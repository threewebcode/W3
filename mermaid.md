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

4. Key Technologies

```mermaid
block-beta
    columns 11 
    a["科学问题"]:3 space:1 b["研究内容"]:4 space:1 c["研究目标"]:2
    
    block:ga:3
            columns 1
            d("交易性能")
            e("共识效率")
            f("兼容性")
    end
    space:1
 
    block:gb:4
            columns 2
            h("多核CPU处理")
            i("高并发转移集")
            j("可信账本数据库")
            k("交易事务并行处理")
            l("多源设备分布式存储")
            m("共识算法")
            n("DID零知识证明")
            o("跨链技术")
            p("节点自适应网络技术")
            q("数据完整性验证")            
    end   

    space

    block:gc:2
        columns 1
        u("通过关键技术提高交易性能")
        v("通过关键技术提供共识效率")
        w("通过关键技术提供网络兼容性")
    end

    ga --> gb 
    gb --> gc
```

5. Application

```mermaid
flowchart LR
    a["核心关键技术"] --> b["新型区块链软硬件平台"] --> c["示范应用"] --> d["供应链金融"] & e["数据治理"] & f["电池供应链溯源"]
```


