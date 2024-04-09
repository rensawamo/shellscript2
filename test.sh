#!/bin/bash

# 位置パラメータ
echo '位置パラメータ'
function echo_args() {
  echo '引数の数' $#
  echo '第1引数' $1
  echo '第2引数' $2
  echo '第3引数' $3
  echo --------------------
}

echo '"$@"'の場合
echo_args "$@" # echo_args "$1" "$2" "$3" ... と同じ
echo '"$*"'の場合
echo_args "$*" # echo_args "$1 $2 $3 ..." と同じ


# $$ パラメータ
echo '$$パラメータ'
echo $$ # プロセスID

(sleep 1; echo 'end') & # 非同期
echo $! # プロセスID
wait $! # プロセスの終了を待つ。$! は最後に実行されたバックグランドプロセスのプロセスIDなので値は変わっていない。

# こちらは waitが実行されてから 出力される
# 配列
echo '配列'
array=(item1 item2 'item3 item4' item5)

# 参照
echo '${array[0]}': ${array[0]}
echo '${array[1]}': ${array[1]}
echo '${array[2]}': ${array[2]}
echo '${array[3]}': ${array[3]}

echo '要素数の参照'
echo ${#array[@]}
