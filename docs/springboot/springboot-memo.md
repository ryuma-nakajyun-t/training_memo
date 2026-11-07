# Spring Boot の基本基礎
Spring Boot を一言でいうと、
Javaで**Webアプリ**や**API**を素早く作るためのフレームワークです。

## 目的
- springbootの概念を把握する.

## 昔のSpringの特徴
昔のSpringは設定が多くて大変でした。  
例えば  普通のSpringだと、  
- Tomcat準備
- Spring設定
- XML設定
- ライブラリ管理
- DI設定
などを自分で行う必要がありました。

## SpringBootが解決
Spring Bootが解決したこと  
例えば 、REST API を1本作るだけなら、
```java
@RestController
public class HelloController {

    @GetMapping("/hello")
    public String hello() {
        return "Hello";
    }
}
```
だけで動きます。

起動も  
```bash
mvn spring-boot:run
```
だけです。

主な目的  
- ① Webサイトを作る(例)
  - Amazon
  - 楽天
  - 社内ポータル
のようなWebシステム

- ② REST APIを作る(例)
  - GET /users
  - POST /users
  - DELETE /users/1
スマホアプリやVue.js、Reactと連携するバックエンドです。

- ③ 業務システムを作る(例)
  - 受注管理
  - 在庫管理
  - 顧客管理
  - 売上管理
多くの企業システムで利用されています。

④ DBと連携する
PostgreSQLなら  
```text
spring.datasource.url=jdbc:postgresql://localhost:5432/sample  
```
だけで接続設定できます。  

Spring Bootの中身  
実は
```text
Spring Boot
├─ Spring Framework
├─ Tomcat
├─ Logging
├─ Jackson(JSON)
└─ Validation
```
をまとめて使いやすくしたものです。  

これまで触ってきた  
```text
Java  
↓  
ファイル処理
↓
DB
↓
Linux
```
は単体の技術ですが、

Spring Boot は  
```text
Java ＋ Web ＋ DB ＋ JSON ＋DI ＋ Tomcat
```
をまとめて業務アプリとして動かすための土台です。  

構造的には、
```text
Linux
    ↓
Java
    ↓
Spring Framework
    ↓
Spring Boot
    ↓
業務アプリ
```
という関係です。

よく見る  
- Java
- Spring Boot
- PostgreSQL
- AWS  
「Spring Boot」は、ほとんどの場合  
「Web APIや業務システムを作るための標準フレームワーク」  
 を意味しています。  

### 参考
---
- AI先生
- spring boot関連の書籍

### memo
---
- Webアプリ
- API
- フレームワーク
