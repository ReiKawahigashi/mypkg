# 演算コマンド
![test](https://github.com/ReiKawahigashi/mypkg/actions/workflows/test.yml/badge.svg)

## 目次
1[コマンドについて]\
2[使い方]\
3[使用ソフトウェア]\
4[テスト環境]\
5[ライセンス]

## コマンドについて
受信した数値を２倍するコマンド

## 使い方
### 1.リポジトリをコピー
```
cd ~/ros2_ws/src
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
以下は例として５を入力する。
```
$ ros2 topic pub /input_number std_msgs/msg/Int32 "{data: 5}"
```
double_calculator を起動しているターミナルには次のようなログが表示される。\
以下は例として入力した５の２倍した数が１０であることを示している。
```
[INFO] [double_calculator]: Received: 5, Published: 10
```

## 使用ソフトウェア
・Python\
・ROS2

## テスト環境
Ubuntu 24.04 LTS

## ライセンス
・本コマンドは三条項BSDライセンスの下にて、使用および複製が許可されています。\
・© 2025 Rei Kawahigashi
