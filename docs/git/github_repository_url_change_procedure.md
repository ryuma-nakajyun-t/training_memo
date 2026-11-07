# GitHubのURLを変更手順
```text
https://github.com/ryuma-nakajyun/
```
上を下にしたい
```text
https://github.com/ryuma-nakajyun-t/
```

そのURLは GitHubユーザー名（アカウント名） なので、
```text
https://github.com/ryuma-nakajyun/
↓
https://github.com/ryuma-nakajyun-t/
```
にしたい場合は、リポジトリ名変更ではなくユーザー名変更 を行います。

- 変更手順  
  - GitHub右上のプロフィール画像をクリック
  - Settings
  - 左メニューの Account
  - Change username または Username

現在の  
```text
ryuma-nakajyun
```
を
```text
ryuma-nakajyun-t
```
へ変更

GitHubの警告を確認して実行  
変更後の影響  
プロフィールURL  
```text
https://github.com/ryuma-nakajyun/
↓
https://github.com/ryuma-nakajyun-t/
```

リポジトリURLも  
```text
https://github.com/ryuma-nakajyun/springboot-pref
↓
https://github.com/ryuma-nakajyun-t/springboot-pref
```
になります。

ローカルリポジトリの修正

変更後は各リポジトリで
```bash
git remote -v
```
を確認し、
```bash
git remote set-url origin https://github.com/ryuma-nakajyun-t/ansible.git
git remote set-url origin https://github.com/ryuma-nakajyun-t/c.git
git remote set-url origin https://github.com/ryuma-nakajyun-t/db.git
git remote set-url origin https://github.com/ryuma-nakajyun-t/go.git
git remote set-url origin https://github.com/ryuma-nakajyun-t/go-basics.git
git remote set-url origin https://github.com/ryuma-nakajyun-t/java.git
git remote set-url origin https://github.com/ryuma-nakajyun-t/springboot-basic.git
git remote set-url origin https://github.com/ryuma-nakajyun-t/springboot-db-pref.git
git remote set-url origin https://github.com/ryuma-nakajyun-t/springboot-pref.git
  git remote set-url origin https://github.com/ryuma-nakajyun-t/springboot-thymeleaf.git
  git remote set-url origin https://github.com/ryuma-nakajyun-t/training_memo.git

```
のように変更します。

ちなみに、今あなたは springboot-pref の Settings ページを開いているようなので、  
まず、  
GitHub右上のプロフィール画像 → Settings → Account を開けばユーザー名変更画面に行けます。  

### 関連質問 
- 変更前に確認すべき影響
- ローカルのURLを一括更新する方法
- ユーザー名変更後の注意点
