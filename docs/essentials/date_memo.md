# 日付
### CURRENT_DATEの取得までの流れ
---
```text
DBの時刻は、DBサーバのOS時刻
 ↓
DBが参照
 ↓
CURRENT_DATE
CURRENT_TIMESTAMP
```

- OSの時刻確認
  - Linux
  - Shell
  - date

- 現在日時
```bash
date '+%Y-%m-%d %H:%M:%S'
```
実行結果
```text
2026-10-26 11:25:31
```

- ミリ秒付き
```bash
date '+%Y-%m-%d %H:%M:%S.%3N'
```
```text
2026-10-26 11:27:17.426
```
この .426 は見た目上は ミリ秒 (1/1000秒) です。

参考:  
| 書式 | 意味 | 例 | 用途 | 
| ---- | ----- | ----- | ----- | 
| %N | ナノ秒9桁 | 123456789 | -  | 
| %3N | ミリ秒3桁 | 123 | ログ | 
| %6N | マイクロ秒6桁 | 123456 | 詳細ログ・性能測定 | 
| %9N | ナノ秒9桁 | 123456789 | 超詳細な性能解析 | 

動作確認
```bash
date '+%Y-%m-%d %H:%M:%S.%N'; 
date '+%Y-%m-%d %H:%M:%S.%6N';
date '+%Y-%m-%d %H:%M:%S.%9N';
date '+%Y-%m-%d %H:%M:%S.%3N';
```
出力
```text
2026-10-27 04:16:26.581720227
2026-10-27 04:16:26.585
2026-10-27 04:16:26.587968
2026-10-27 04:16:26.590924441
```

### 関連コマンドなど
- タイムゾーン確認
```bash
timedatectl
```
```text
               Local time: 月 2026-10-26 11:28:35 JST
           Universal time: 月 2026-10-26 02:28:35 UTC
                 RTC time: 月 2026-10-26 02:28:35
                Time zone: Asia/Tokyo (JST, +0900)
System clock synchronized: yes
              NTP service: active
          RTC in local TZ: no
```

- NTP同期状態確認
```bash
timedatectl status
```
```text
               Local time: 月 2026-10-26 11:31:22 JST
           Universal time: 月 2026-10-26 02:31:22 UTC
                 RTC time: 月 2026-10-26 02:31:21
                Time zone: Asia/Tokyo (JST, +0900)
System clock synchronized: yes
              NTP service: active
          RTC in local TZ: no
```

### 参考
---
- AI先生
- 書籍たち

### memo
---
- date は時刻取得としては十分正確だが、%N の9桁表示が必ずしもナノ秒レベルの実測精度を保証するわけではない
- 
- 
