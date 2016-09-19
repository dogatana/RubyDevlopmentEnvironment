## Ruby 開発環境構築講座 Windows編 Kindle化

### はじめに

『Ruby 開発環境構築講座 Windows編』という書籍が達人出版会から電子書籍として出版されている。形式は PDF と EPUB。

PDFはそのままで、EPUBはkindlegenでmobi形式に変換してkindleで読むことができるが、特性を活かすならやはりmobi形式が有効。

それで読み始めたが、誤字、構成がおかしい箇所などが散見されたので、それらを修復してKindleで読めるようにすることを試みてみた。

### 必要なもの

* Ruby 開発環境構築講座 Windows編 V1.0.1
* kindlegen
* Ruby
* 本リポジトリの \*.rb

### 利用方法

1. コマンドプロンプトから rake を実行する
2. OEBPS の下に book.mobi が作成されるので、それをKindleへ転送