# ろんばと (Ronbato) 🗣️

オンラインでディベートができる SNS プラットフォーム。トピックを作成し、ユーザー同士で議論を交わすことができます。
**多様な視点からの議論を可視化し、理解を深めることを目指しています。**

> 注: このリポジトリは「ろんばと」というディベート SNS のコードで、2022 年から 1 年間サービス提供後に終了したものです。
> ronbato.com(失効済み)で公開していました。credential な情報は削除済みです。

## 🚀 デモ

過去のバージョン: http://ronbato.com (現在は利用不可)

## 🌟 特徴

- トピック作成と議論参加機能
- 賛成・反対の立場を明確にした議論構造
- 議論ツリーの視覚化
- ユーザー認証システム
- 閲覧数トラッキング

## 🛠 技術スタック

- **フレームワーク**: Ruby on Rails 7.0
  - Devise によるユーザー認証
  - Active Record によるデータベースモデリング
  - Views と Controller による MVC アーキテクチャ
- **データベース**: SQLite3 (開発), MySQL (本番)
- **その他**: JavaScript, SCSS, Webpacker, Turbolinks

## 💻 開発環境

### 前提条件

- Ruby 2.7 以上
- Node.js 14 以上
- SQLite3 (ローカル開発用)
- MySQL (本番環境用)

### 動作確認済み環境

```bash
% ruby -v
ruby 2.7.x

% rails -v
Rails 7.0.2
```

### 開発の始め方

1. 依存パッケージのインストール:

   ```bash
   bundle install
   yarn install
   ```

2. データベースのセットアップ:

   ```bash
   rails db:setup
   ```

3. 開発サーバーを起動:

   ```bash
   rails server
   ```

4. ブラウザで [http://localhost:3000](http://localhost:3000) を開いて結果を確認

## 🚀 デプロイ

### 自動デプロイ (過去の設定)

- 本サービスは Unicorn と Nginx を使用してデプロイされていました
- MySQL をデータベースとして使用

### 主要なモデル構造

- **User**: ユーザー情報と認証
- **Topic**: ディベートのトピック情報
- **State**: トピックに対する主張・意見
- **StateRelation**: 主張間の関係性（議論ツリー構造）
- **Participation**: ユーザーのトピック参加記録
