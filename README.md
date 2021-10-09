







### Derivatives_app

- 紫外-可視吸収スペクトルの微分変換を行うアプリケーションです。
- 微分次数、スムージング条件の変更に伴い、インタラクティブにグラフのプロットを変更します。



### Requirements

- R version 4.0.5
- RStudio



### Install

```R
install.packages('shiny')
install.packages('pramca')
install.packages('colorspace')
```



### Usage

```R
library('shiny')
runApp('derivatives_app')
```

※ derivatives_appフォルダが置かれているフォルダを作業ディレクトリとし、runApp() コマンドを入力してください。



### Document

- 紫外-可視吸収スペクトルのデータが入ったcsvファイルをアップロードした後、微分次数、スムージング条件を指定して「プロット」をクリック。
- 「Download」 ボタンから計算した微分スペクトルをcsvファイルとしてダウンロードできます。



### References

- Procedures for Converting Electronic Absorption Spectra into Higher-Order Derivatives to Examine Photoinduced Spectral Changes

  https://www.journal.csj.jp/doi/10.1246/bcsj.20160032

- 微分変換で読み解く紫外可視吸収スペクトル ―光反応性材料の新しい挙動解析法―

  https://www.cmcbooks.co.jp/products/detail.php?product_id=5669