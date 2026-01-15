# 演算コマンド
![test](https://github.com/ReiKawahigashi/mypkg/actions/workflows/test.yml/badge.svg)

## コマンドについて
受信した数値を2倍するコマンド

## 使い方
### 1.リポジトリをクローン、ビルド
```
$ git clone https://github.com/ReiKawahigashi/mypkg
$ cd mypkg
$ colcon build --packages-select mypkg
$ source install/setup.bash
```

### 2.ノードの起動
別ターミナルで以下を実行
```
$ ros2 run mypkg double_calculator
```

### 3.コマンド実行例
さらに別ターミナルを開き、input_number トピックに整数値を送信する。\
以下は例として5を入力する。
```
$ ros2 topic pub /input_number std_msgs/msg/Int32 "{data: 5}"
```
double_calculator を起動しているターミナルには次のようなログが表示される。\
以下は例として入力した5の2倍した数が10であることを示している。
```
data: 10
```

## 使用ソフトウェア
- Python\
- ROS2

## テスト環境
Ubuntu 24.04 LTS

## ライセンス
- 本コマンドは三条項BSDライセンスの下にて、使用および複製が許可されています。\
- © 2025 Rei Kawahigashi
