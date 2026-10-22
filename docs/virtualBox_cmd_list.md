# VirtualBox のヘッドレス運用で関連コマンド群
## 項目一覧
1. 起動・停止（基本操作）
2. 状態確認
3. ネットワーク（SSH 用の確認）
4. スナップショット（安全な作業のため）
5. VM の設定変更（構造化された管理）
6. ディスク操作（安全な環境維持）
7. 自動起動（ヘッドレス運用の最適化）

## 1. 起動・停止（基本操作）
| 用途 | コマンド |
| --------- | ------------------------- | 
| ヘッドレス起動 | VBoxManage startvm "vMUbuntuDocker" --type headless | 
| 通常起動（GUI） | VBoxManage startvm "vMUbuntuDocker" --type gui| 
| 停止（ACPI シャットダウン）| VBoxManage controlvm "vMUbuntuDocker" acpipowerbutton| 
| 強制停止 | VBoxManage controlvm "vMUbuntuDocker" poweroff| 

## 2. 状態確認
| 用途 | コマンド |
|---------|-------------------------|
| 起動中の VM 一覧 | ``VBoxManage`` list ``runningvms`` |
| 全 VM 一覧 | ``VBoxManage`` list ``vms`` |
| VM の詳細情報 | ``VBoxManage`` showvminfo ``"vMUbuntuDocker"`` |
| VM の起動状態（簡易） | `VBoxManage showvminfo "vMUbuntuDocker" | grep State` |
| VM のネットワーク情報 | `VBoxManage showvminfo "vMUbuntuDocker" | grep NIC` |
| VM のストレージ情報 | `VBoxManage showvminfo "vMUbuntuDocker" | grep -i storage` |
| VM のスナップショット一覧 | ``VBoxManage ``snapshot ``"vMUbuntuDocker" ``list`` |
| VirtualBox のバージョン確認 | ``VBoxManage ``--version`` |
| ホストの USB デバイス一覧 | ``VBoxManage ``list ``usbhost`` |
| ホストの PCI デバイス一覧 | ``VBoxManage ``list ``hostpci`` |
| ホストのネットワークインターフェース一覧 | ``VBoxManage ``list ``hostonlyifs`` |
| ホストの DHCP サーバー一覧 | ``VBoxManage ``list ``dhcpservers`` |
| 拡張パックの状態確認 | ``VBoxManage ``list ``extpacks`` |
| VM のログディレクトリ確認 | `VBoxManage showvminfo "vMUbuntuDocker" | grep -i Log` |
| VM の CPU / メモリ設定確認 | `VBoxManage showvminfo "vMUbuntuDocker" | grep -E "Memory | CPU"` |
| VM の共有フォルダ一覧 | `VBoxManage showvminfo "vMUbuntuDocker" | grep -i Shared` |

## 3. ネットワーク（SSH 用の確認）
| 用途 | コマンド |
|---------|-------------------------|
| ゲストの IP アドレス取得| VBoxManage guestproperty get "vMUbuntuDocker" "/VirtualBox/GuestInfo/Net/0/V4/IP"| 
| ポートフォワード一覧（NAT）| VBoxManage list natnets| 
| ポートフォワード追加（例：SSH 22 → ホスト 2222）| VBoxManage modifyvm "vMUbuntuDocker" --natpf1 "ssh,tcp,,2222,,22"| 
| ポートフォワード削除| VBoxManage modifyvm "vMUbuntuDocker" --natpf1 delete ssh | 

## 4. スナップショット（安全な作業のため）
| 用途 | コマンド | 
|---------|-------------------------| 
| 作成 | VBoxManage snapshot "vMUbuntuDocker" take "before-update" | 
| 一覧 | VBoxManage snapshot "vMUbuntuDocker" list| 
| 復元 | VBoxManage snapshot "vMUbuntuDocker" restore "before-update"| 

## 5. VM の設定変更（構造化された管理）
| 用途 | コマンド | 
|---------|-------------------------| 
|CPU 数変更| VBoxManage modifyvm "vMUbuntuDocker" --cpus 2| 
|メモリ変更| VBoxManage modifyvm "vMUbuntuDocker" --memory 4096| 
|VRAM 変更| VBoxManage modifyvm "vMUbuntuDocker" --vram 16| 
|共有フォルダ追加| VBoxManage sharedfolder add "vMUbuntuDocker" --name shared --hostpath "/path/to/dir"| 

## 6. ディスク操作（安全な環境維持）
| 用途 | コマンド | 
|---------|-------------------------| 
|ディスク一覧| VBoxManage list hdds| 
|ディスク容量拡張（例：20GB → 40GB）| VBoxManage modifymedium disk /path/to/disk.vdi --resize 40000| 

## 7. 自動起動（ヘッドレス運用の最適化）
| 用途 | コマンド | 
|---------|-------------------------| 
|自動起動を有効化| VBoxManage modifyvm "vMUbuntuDocker" --autostart-enabled on | 
|自動起動の遅延設定（例：10秒）| VBoxManage modifyvm "vMUbuntuDocker" --autostart-delay 10 | 
