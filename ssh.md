# ssh接続計算機の作りかた.

URL: [https://github.com/m-agnet/HowTo.git](https://github.com/m-agnet/HowTo.git)

E401室内の計算機にssh接続するときの備忘録.

## mac初期化

- cmd+R+電源ボタン で初期化
- ディスクユーティリティ
  - 全内蔵データを消去.
- macOSを再インストール

## SSH key 作成

- `ssh-keygen -t ed25519`
- Enter passphrase と表示されるが, 何も入力せずに `Enter` .


## TP-link設定

- ブラウザで `tplinkwifi.net` を開く.
- タブで詳細設定に切り替える.
- ネットワーク 
  - DHCPサーバー
    - アドレス予約で「追加」
    - MACアドレスとIPアドレスを入力する. (これはターミナルで`ifconfig` とすることで確認できる.)
- NAT転送
    - 仮想サーバーで外部ポートを唯一のものにする.
  
## 外部の計算機から接続


- ~/.ssh/config　の中身に以下を追加.

```bash
  Host {接続するときに使いたい名前}
	HostName 157.80.51.236
	Port {外部ポート}
	User {接続先のユーザ}
    ProxyCommand            ssh -XC -W %h:%p ness1
```

- ターミナルで `ssh {接続するときに使いたい名前}` を入力.
