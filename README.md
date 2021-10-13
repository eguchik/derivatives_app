## Derivatives_app

- 紫外-可視吸収スペクトルの微分変換を行うアプリケーション。
- 微分次数、スムージング条件の変更に伴う微分スペクトルの変化をインタラクティブに可視化。

### Requirements

- R version >= 4.0.5
- RStudio

### Install

```R
install.packages('shiny')
install.packages('pracma')
install.packages('colorspace')
```

### Usage

```R
setwd('・・・/derivatives_app')
library('shiny')
runApp('app')
```

-  setwd() で derivatives_app フォルダを作業ディレクトリとし、``` runApp('app') ``` コマンドを入力してください。

- 作業ディレクトリの変更方法
  http://cse.naro.affrc.go.jp/takezawa/r-tips/r/06.html


### Document

- 紫外-可視吸収スペクトルを含むcsv ファイルをアップロードした後、微分次数、スムージング条件を指定して「プロット」をクリック。
- 「Download」 から計算した微分スペクトルを csv ファイルとしてダウンロードできます。

### References

- Procedures for Converting Electronic Absorption Spectra into Higher-Order Derivatives to Examine Photoinduced Spectral Changes

  https://www.journal.csj.jp/doi/10.1246/bcsj.20160032

- 微分変換で読み解く紫外可視吸収スペクトル ―光反応性材料の新しい挙動解析法―

  https://www.cmcbooks.co.jp/products/detail.php?product_id=5669
