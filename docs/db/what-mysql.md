# mysql　とは
MySQL とは、一言でいうと  
データを保存・検索・更新するためのデータベース管理システム（RDBMS）  
です。  

例えばECサイトなら、
```text
商品情報
会員情報
注文履歴
```
を保存しておき、必要な時に高速に取り出します。

イメージ
項目	例
Excelの
シート	テーブル
行	レコード（データ）
列	カラム
検索	SQL

例えば
会員テーブル：
id	name	age
1	田中	30
2	鈴木	25

30歳以上を検索するSQL：
```sql
SELECT *
FROM member
WHERE age >= 30;
```

特徴
オープンソース
無料版がある
Linux環境でよく使われる
Spring Bootとの相性が良い
Webシステムで非常に普及している

よく一緒に出る製品
MySQL
PostgreSQL
Oracle Database
SQL Server

これらはすべて「データベース管理システム」です。

ITエンジニア向けに一言で
```text
MySQL = SQLを使ってデータを管理するためのデータベースサーバー
```
です。

最近学んでいる Spring Boot の文脈なら、
```text
Spring Boot
    ↓ JDBC/JPA
MySQL
```

という構成で、アプリからMySQLに接続してデータを読み書きします。

# なぜ、Spring Bootとの相性が良い？
Spring Boot と MySQL の相性が良いと言われる理由は、

Spring Boot が MySQL に接続するための仕組みを最初から豊富に持っているから

です。

### ① JDBCドライバを追加するだけ
Mavenなら
```xml
<dependency>
    <groupId>com.mysql</groupId>
    <artifactId>mysql-connector-j</artifactId>
</dependency>
```

を追加し、
```properties
spring.datasource.url=jdbc:mysql://localhost:3306/sampledb
spring.datasource.username=root
spring.datasource.password=password
```

を設定するだけで接続できます。

### ② JPA/Hibernateとの組み合わせが強力

例えばテーブル
```sql
CREATE TABLE customer (
    id BIGINT,
    name VARCHAR(100)
);
```

に対して、
```java
@Entity
public class Customer {

    @Id
    private Long id;

    private String name;
}
```
を書くだけで、
```java
customerRepository.findAll();
```
のようにSQLをほとんど書かずに利用できます。

### ③ 利用実績が非常に多い
Webシステムの定番構成として
```text
Spring Boot
    ↓
MySQL
```
が昔から多く使われています。

そのため、
```text
書籍
サンプルコード
技術記事
エラー解決情報
```
が豊富です。

### ④ Spring Bootが自動設定してくれる
通常JavaでDB接続する場合、
```java
Class.forName(...);
Connection con = ...
PreparedStatement ps = ...
```
など大量の設定が必要です。

Spring Bootなら
```properties
spring.datasource.url=...
```

程度で自動設定されます。

これを **Auto Configuration（自動設定）** と呼びます。

本質的には  
Spring Boot は特別に MySQL 専用ではありません。

同じように
```text
PostgreSQL
Oracle
SQL Server
```
とも接続できます。

ただし現場や個人開発では
```text
Spring Boot + MySQL
```
の組み合わせが非常に普及しているため、
「Spring BootとMySQLは相性が良い」  
と言われることが多いです。  

あなたが最近作っているような Spring BootでCSVを読み込むアプリ をさらに発展させるなら、
```text
CSV
 ↓
Spring Boot
 ↓
MySQLへ登録
 ↓
Thymeleafで表示
```
という流れにすると、実務でよく見るWebシステムにかなり近くなります。

