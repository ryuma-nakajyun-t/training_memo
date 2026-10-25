# 座標チェック用の制約DDL
緯度経度を10進数で保持する  
前提なら、
DB制約でチェックしておくと不正データを防げます。  

緯度・経度の  
有効範囲は  
以下です。  
```text
緯度(Latitude)  : -90 ～ 90
経度(Longitude) : -180 ～ 180
```

PostgreSQL
```sql
CREATE TABLE location (
    id BIGSERIAL PRIMARY KEY,
    latitude  DECIMAL(10,7) NOT NULL,
    longitude DECIMAL(10,7) NOT NULL,

    CONSTRAINT chk_latitude
        CHECK (latitude BETWEEN -90.0 AND 90.0),

    CONSTRAINT chk_longitude
        CHECK (longitude BETWEEN -180.0 AND 180.0)
);
```

より  
実務的な例  
日本国内限定なら範囲をさらに絞れます。  
```text
緯度  : 約20 ～ 46
経度  : 約122 ～ 154
```

```sql
CONSTRAINT chk_latitude_jp
    CHECK (latitude BETWEEN 20.0 AND 46.0),

CONSTRAINT chk_longitude_jp
    CHECK (longitude BETWEEN 122.0 AND 154.0)
```

これにより、
```text
999.9999999
```
や
```text
35.6895
1397.1234
```
のようなデータを登録できなくなります。

システム設計書向け  
記載例  
```text
項目名      : 緯度
型          : DECIMAL(10,7)
必須        : ○
制約        : -90.0000000 ～ 90.0000000

項目名      : 経度
型          : DECIMAL(10,7)
必須        : ○
制約        : -180.0000000 ～ 180.0000000
```

マスタ設計としては、  
```sql
latitude  DECIMAL(10,7)
longitude DECIMAL(10,7)
```
＋
```sql
CHECK
```
による範囲制約を付けるのが最も素直で保守しやすい設計です。

### 参考
---
- AI先生
- 

### memo
---
- 
- 
- 
