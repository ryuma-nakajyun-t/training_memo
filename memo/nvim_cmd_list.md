# Neovim Keymap — Formal & Technical Table
## 1. Normal Mode（通常モード）
### Movement（カーソル移動）
| 省略キー | ロングキー（正式名称） | 日本語の技術的説明 | 
|---------|-------------------------|----------------------| 
| h | cursor-left | カーソルを左へ1文字移動する基本モーション | 
| j | cursor-down | カーソルを1行下へ移動する基本モーション | 
| k | cursor-up | カーソルを1行上へ移動する基本モーション | 
| l | cursor-right | カーソルを右へ1文字移動する基本モーション | 
| w | word-forward | 次の「単語の先頭」へ移動するテキストモーション | 
| b | word-backward | 前の「単語の先頭」へ戻るモーション | 
| e | end-of-word | 単語の末尾へ移動するモーション | 
| 0 | line-begin | 行頭（最左）へ移動 | 
| $ | line-end | 行末（最右）へ移動 | 
| gg | goto-first-line | ファイルの最初の行へジャンプ | 
| G | goto-last-line | ファイルの最後の行へジャンプ | 
| f{char} | find-character-forward | 行内で指定文字を検索し、その位置へ移動 | 
| t{char} | till-character-forward | 指定文字の「直前」まで移動（fより細かい制御） | 
| ; | repeat-last-character-search | 直前の f/t 検索を繰り返す | 
| , | reverse-repeat-last-character-search | f/t の逆方向繰り返し | 

### Editing（編集操作）
| 省略キー | ロングキー（正式名称） | 日本語の技術的説明 | 
|---------|-------------------------|----------------------| 
| x | delete-character | カーソル位置の1文字を削除 | 
| dd | delete-line | 行全体を削除（レジスタに保存） | 
| yy | yank-line | 行全体をコピー（ヤンク） | 
| p | put-after | レジスタ内容をカーソル後に貼り付け | 
| u | undo | 直前の変更を取り消す | 
| <C-r> | redo | Undo をやり直す | 
| . | repeat-last-change | 直前の編集操作を再実行（最強の効率化キー） | 

### Changing（変更操作）
| 省略キー | ロングキー（正式名称） | 日本語の技術的説明 | 
|---------|-------------------------|----------------------| 
| cw | change-word | 単語を削除して挿入モードへ（変更） | 
| cc | change-line | 行全体を変更（行削除＋挿入） | 
| C | change-to-end-of-line | カーソル以降を変更 | 
| s | substitute-character | 1文字を置換して挿入モードへ | 
| S | substitute-line | 行全体を置換して挿入モードへ | 

### Searching（検索）
| 省略キー | ロングキー（正式名称） | 日本語の技術的説明 | 
|---------|-------------------------|----------------------| 
| / | search-forward | 前方へ検索（正方向） | 
| ? | search-backward | 後方へ検索（逆方向） | 
| n | search-next | 次の検索結果へ移動 | 
| N | search-previous | 前の検索結果へ移動 | 

### Window Management（ウィンドウ操作）
| 省略キー | ロングキー（正式名称） | 日本語の技術的説明 |
|---------|-------------------------|----------------------|
| <C-w>v | split-vertical | 垂直方向にウィンドウ分割 |
| <C-w>s | split-horizontal | 水平方向にウィンドウ分割 |
| <C-w>h/j/k/l | window-move-{direction} | 分割ウィンドウ間を移動 |
| <C-w>q | window-close | 現在のウィンドウを閉じる |

### Tab Management（タブ操作）
| 省略キー | ロングキー（正式名称） | 日本語の技術的説明 |
|---------|-------------------------|----------------------|
| gt | tab-next | 次のタブへ移動 |
| gT | tab-previous | 前のタブへ移動 |
| :tabnew | tab-new | 新しいタブを作成 |

## 2. Visual Mode（選択モード）
### Visual Selection
| 省略キー | ロングキー（正式名称） | 日本語の技術的説明 |
|---------|-------------------------|----------------------|
| v | visual-character | 文字単位の選択モード |
| V | visual-line | 行単位の選択モード |
| <C-v> | visual-block | 矩形選択（ブロック選択） |
| d | delete-selection | 選択範囲を削除 |
| y | yank-selection | 選択範囲をコピー |
| c | change-selection | 選択範囲を変更 |
| > / < | indent / unindent | 選択範囲のインデント調整 |
| o | swap-selection-endpoints | 選択範囲の始点・終点を入れ替え |

### Visual Block（矩形選択）
| 省略キー | ロングキー（正式名称） | 日本語の技術的説明 |
|---------|-------------------------|----------------------|
| <C-v> | visual-block | 矩形選択モード |
| I | insert-at-block-start | 選択ブロックの各行の先頭に挿入 |
| A | append-at-block-end | 選択ブロックの各行の末尾に挿入 |
| d / y / c | delete / yank / change block | ブロック範囲の削除・コピー・変更 |

## 3. Insert Mode（挿入モード）
| 省略キー | ロングキー（正式名称） | 日本語の技術的説明 |
|---------|-------------------------|----------------------|
| <Esc> | exit-insert-mode | 挿入モードを終了し Normal へ戻る |
| <C-h> | backspace | 1文字削除 |
| <C-w> | delete-word-backward | 単語単位で後方削除 |
| <C-u> | delete-to-line-begin | 行頭まで削除 |
| <C-o> | one-normal-command | 一時的に Normal モードのコマンドを1回だけ実行 |
| <C-r>{reg} | insert-register | レジスタ内容を挿入 |

## 4. Command-line Mode（コマンドライン）
| 省略キー | ロングキー（正式名称） | 日本語の技術的説明 |
|---------|-------------------------|----------------------|
| : | enter-command-line | コマンドラインモードへ入る |
| / | search-forward | 前方検索 |
| ? | search-backward | 後方検索 |
| <C-p> | command-history-previous | コマンド履歴の前へ |
| <C-n> | command-history-next | コマンド履歴の次へ |
| <C-r>{reg} | insert-register | レジスタ内容を挿入 |

## 5. Operator-Pending Mode（演算子 × モーション）
| 演算子（省略） | ロングキー（正式名称） | 日本語の技術的説明 | 
|----------------|-------------------------|----------------------| 
| d | delete-operator | 削除演算子（モーションと組み合わせて範囲削除） | 
| y | yank-operator | コピー演算子 | 
| c | change-operator | 変更演算子 | 

### 組み合わせ例
| 省略キー | ロングキー（正式名称） | 日本語の技術的説明 | 
|---------|-------------------------|----------------------| 
| dw | delete-word | 単語を削除 | 
| d$ | delete-to-end-of-line | 行末まで削除 | 
| d0 | delete-to-beginning-of-line | 行頭まで削除 | 
| y3j | yank-three-lines-down | 下方向に3行コピー | 
| ci" | change-inside-double-quote | " の内部を変更 | 
| ci( | change-inside-parentheses | () の内部を変更 | 
