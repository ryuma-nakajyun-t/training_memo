# mvn spring-boot:run
mvn spring-boot:run は、Mavenを使ってSpring Bootアプリケーションを起動するコマンドです。

構造で見ると、
```text
mvn        ← Mavenを実行
spring-boot:run
   ↑
   Spring Bootプラグインの run 処理を実行
```
何が起きている？

例えば Spring Boot のプロジェクトで
```bash
mvn spring-boot:run
```
を実行すると、
Maven が以下を自動で行います。  
- ソースコードをコンパイル
- 必要なライブラリを解決
- クラスパスを作成
- Spring Bootアプリを起動

つまり内部的には最終的に
```java
public static void main(String[] args)
```
を実行しているイメージです。

Javaコマンドとの違い  
普通のJavaなら
```bash
javac Main.java
java Main
```
ですが、  
Spring Bootではライブラリが大量にあるため  
```bash
java -cp xxx.jar:yyy.jar:zzz.jar ...
```
のような面倒な起動が必要になります。

そのため、  
Spring Bootプラグインが代わりにやってくれます。
```bash
mvn spring-boot:run
```
だけで起動できるのです。

典型的な流れ　　
開発中
```bash
mvn spring-boot:run
```

起動後
```text
Tomcat started on port(s): 8080
Started DemoApplication
```
となります。

ブラウザから
```text
http://localhost:8080
```
へアクセスできます。

実運用との違い

開発中は
```bash
mvn spring-boot:run
```

本番では通常
```bash
mvn package
```
でJAR作成後
```bash
java -jar target/demo-0.0.1.jar
```
で起動します。

理由は、
- 起動が速い
- Maven不要
- 本番環境にソースを置かない
- デプロイしやすい
ためです。

あなたが今見ているサンプルで考えると  
以前の話のように Spring Boot で HTTP の勉強をしているなら、  
```java
@RestController
public class HelloController {

    @GetMapping("/hello")
    public String hello() {
        return "Hello";
    }
}
```
を作成して、
```bash
mvn spring-boot:run
```
すると、
```text
http://localhost:8080/hello
```
で
Hello
が返ります。

これは  
```text
ブラウザ
  ↓ HTTP
Tomcat(Spring Boot内蔵)
  ↓
Controller
  ↓
レスポンス
```
という HTTP 通信の最も基本的な流れを確認するためによく使われます。

ネットワークの勉強をしたいなら、  
mvn spring-boot:run は単なる「起動ボタン」だと思うと分かりやすいです。  

実際に学ぶべき本体は、  
その後ろで動いている 
```text
HTTP → Tomcat → Spring MVC → Controller
```
 の流れです。  

### 参考
---
- AI先生

### memo
---
- 
- 
- 
