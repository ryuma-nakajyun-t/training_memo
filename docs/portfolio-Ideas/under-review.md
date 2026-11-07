# 個人で開発するなら

現在相性がいい、技術素養一覧
```text
DB
PostgreSQL
SQLチューニング
Linux
Ansible
```
これらの、組み合わせがシックリくるかも。  

「地理情報(GIS)を扱う業務システム」  
にすると  
単なる学習用CRUDから一気に実務感が出ます。  

### 提案一覧
---
- 案1: 全国施設検索システム
- 案2: 配送エリア管理システム
- 案3: 漁港データ管理
- 案4: 災害避難所検索

### 案1: 全国施設検索システム
--- 
```text
データ
都道府県
市区町村
緯度経度
人口データ
施設データ

機能
都道府県検索
半径5km検索
距離順ソート
ページング

技術
Spring Boot
PostgreSQL
PostGIS
```
実務ポイント  
100万件の施設データを投入

```sql
EXPLAIN ANALYZE
SELECT *
FROM facility
WHERE prefecture_id = 43
ORDER BY id
LIMIT 50;
```

インデックス有無で比較
```sql
CREATE INDEX idx_prefecture
ON facility(prefecture_id);
```
これは現場で普通にやる性能検証です。

### 案2: 配送エリア管理システム
--- 
ヤマトや佐川の縮小版
```text
テーブル
prefecture
city
delivery_area
customer
```
機能  
```text
配送先登録  
配送可能判定
```

緯度経度から距離計算
```sql
ST_DistanceSphere()
```

利用
```sql
SELECT *
FROM warehouse
ORDER BY
ST_DistanceSphere(
 point(lon,lat),
 point(130.5,33.5)
)
LIMIT 1;
```

### 案3: 漁港データ管理
--- 
魚市場好きならおすすめ
データ
```text
漁港
市場
緯度経度
漁獲量

機能
市場検索
距離検索
漁獲量ランキング
```

バッチ  
毎日CSV取込
```text
catch_20261024.csv
↓
Spring Batch
↓
DB投入
↓
集計
```

### 案4: 災害避難所検索
--- 
実務感が強い  
データ
```text
政府公開データ利用
避難所
緯度経度
収容人数
機能
現在位置から近い避難所検索
```

```sql
ORDER BY distance
LIMIT 10
```

学べるもの
```text
GIS
PostGIS
インデックス
API
キャッシュ
```

AI的におすすめ  
「全国魚市場・漁港検索システム」
の構築が楽しそうです。  
機能例
- 市場検索
- 都道府県検索
- 距離検索
- CSV一括取込
- バッチ集計
- 実行計画確認
- 100万件性能試験
- Ansible自動構築
- PostgreSQLバックアップ
- rsync同期

これなら  
```text
ただのSpring Boot学習
```
ではなく
```text
地理情報システム(GIS) + DB設計 + バッチ + Linux運用
```
になります。

第三者から見ても、  
```text
CRUDを勉強しました  
```
ではなく  
```text
PostgreSQL ＋ PostGIS  
```
で100万件データの距離検索を実装し、  
EXPLAIN ANALYZE で性能測定しました  
の方が
圧倒的に業務経験へ結び付きやすいです。  

特にPostGISは  
自治体、物流、不動産、地図、インフラ管理で実際に使われることがあるので、  
「GISとは？」を学んだ流れで作る題材としてもかなり良いと思います。  

### 学び・気づき
---
- オープンデータはxml形式のため、xpathの復習が必要になる。
- TBA
- TBA

### 疑問
---
- 100万件規模のデータをどのように収集するのか？おそらく、比較的大きくなりそうなトランザクションデータ
- 提案一覧から実現度(途中でやめてしまわない程度)
- TBA

### 参考
---
- AI先生
- 

### memo
---
- オープンデータ
  - [国土数値情報](https://nlftp.mlit.go.jp/ksj/index.html)
  - [基盤地図情報ダウンロードサービス](https://service.gsi.go.jp/kiban/)
  - [国土交通省気象庁](https://www.data.jma.go.jp/stats/etrn/index.php)
- おもしろいシステム
  - [フライトレーダ24](https://www.flightradar24.com)
    - OSSは確認できない。
      - 非公開
    - データ提供は確認できない。 
  - [船舶レーダ24](https://www.marinetraffic.com/jp/ais/home)
    - OSSは確認できない。
    - データ提供は確認できない。
- 
