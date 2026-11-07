# シェルスクリプトでネットワークのチューニング
「シェルスクリプトでネットワークのチューニング」というと、  
実際には、  
ネットワーク処理の**無駄を減らす**こと を指すことが多いです。  

例えば、  
ファイル転送処理を考えます。  
悪い例
```bash
scp largefile.dat server:/tmp/
```
毎回全量転送します。

良い例
```bash
rsync -av --update ./ server:/data/
```
変更されたファイルだけ転送します。

結果として
```text
通信量削減
転送時間短縮
サーバ負荷削減
```
になります。

並列化  
遅い例  
```bash
for host in host1 host2 host3
do
    ssh "$host" uptime
done
```
1台ずつ実行します。

改善例  
```bash
for host in host1 host2 host3
do
    ssh "$host" uptime &
done

wait
```
同時実行します。

例えば、1台10秒かかるなら  
```text
直列: 約30秒  
並列: 約10秒
```  
になります。  

接続回数削減  
遅い例  
```bash
ssh server "mkdir -p /tmp/test"
ssh server "cp a.txt /tmp/test"
ssh server "ls /tmp/test"
```
3回接続しています。  

改善例  
```bash
ssh server '
mkdir -p /tmp/test
cp a.txt /tmp/test
ls /tmp/test
'
```
1回の接続で済みます。  
SSH接続は、**意外と重い**ので効果があります。  

DNS問い合わせ削減  
遅い例
```bash
for i in {1..100}
do
    ping www.example.com -c 1
done
```
100回名前解決します。

改善例
```bash
IP=$(getent hosts www.example.com | awk '{print $1}')

for i in {1..100}
do
    ping "$IP" -c 1
done
```
名前解決を1回にできます。

圧縮して送る
例えばログ収集なら
```bash
tar czf logs.tar.gz logs/
scp logs.tar.gz server:/backup/
```
圧縮してから送ることで通信量を削減できます。

実務でよくあるチューニング
- rsync
- SSH
- Ansible
では次の考え方が多いです。

処理しない
```bash
cmp file1 file2
```
差分がなければ転送しない。

必要なファイルだけ送る
```bash
rsync --exclude='*.log'
```

並列で実行する
```bash
ansible-playbook -f 10 site.yml
```
fork数を増やす。

この考え方は以前話していた  
「コンパイルが必要か確認してからコンパイルする」  
と同じです。  

ネットワークチューニングでは、  
- 送らなくてよいデータは送らない
- 接続しなくてよいなら接続しない 
- 待たなくてよいなら並列化する
の3つです。  
これはシェルスクリプトでも非常に効果の高いチューニング方針です。  

