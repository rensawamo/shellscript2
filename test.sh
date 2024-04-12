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


# 配列のindex 変更
echo '配列 index指定して要素を変更'
array2=(item0 [2]=item2 [4]=item4)
echo ${array2[0]}
array2[0]="変更"
echo ${array2[0]}


# 配列のすべての要素を参照
echo '配列全参照'
array=(item1 item2 'item3 item4' item5)

function echo_array_items() {
  echo $1
  echo $2
  echo $3
  echo $4
  echo $5
  echo -----------------------
}

echo Use '"${array[@]}"'
echo_array_items "${array[@]}" # echo_array_items "${array[0]}" "${array[1]}" ... と同じ

echo Use '"${array[*]}"'
echo_array_items "${array[*]}" # echo_array_items "${array[0]} ${array[1]} ..." と同じ


# 配列への要素の追加
echo '配列要素の追加'
array=(item1 item2 item3)
echo "${array[@]}"

# 先頭に追加
array2=(item_a item_b "${array[@]}")
echo "${array2[@]}"

# 末尾に追加
array3=("${array[@]}" item_c item_d)
echo "${array3[@]}"

# 自身の末尾に追加
array+=(item_e item_f) # array=("${array[@]}" item_e item_f) と同じ
echo "${array[@]}"


# 配列の インデックス番号の取得
echo 'index番号の取得'
array=(item0 [2]=item2 [4]=item4)
echo ${!array[@]}

# if
echo 'if'
if grep -n test test.txt; then
  echo $?
  echo success
else
  echo $?  # 終了コードが 0 以外だったらこちらに入る
  echo fail
fi


# ./test.sh test 実行で成功パターン
echo './test.sh test 実行'
[ "$1" = "test" ]
echo '[ コマンドの終了ステータス':$?

if [ "$1" = "test" ]; then
  echo success
else
  echo fail
fi


# 条件連結
echo ' ./test.sh a b   実行ファイル結合子と 条件結合'
if [ \( "$1" = "a"  -o "$2" = "b" \) -a -f test.txt ]; then
    echo '第１引数がaまたは第２引数がbで、かつtest.txtが存在しています！'
fi

# わかりやすくかく
if [[ ( "$1" = "a"  || "$2" = "b" ) && -f test.txt ]]; then
  echo '第１引数がaまたは第２引数がbで、かつtest.txtが存在しています！'
fi


# ./test.sh text.txt 実行 して case 分岐
echo 'case による条件分岐'
file="$1"

case "$file" in
  *.csv)
    echo this is csv
    ;;
  *.txt)
    echo this is txt file
    ;;
  special-* | important-*)
    echo this is special file
    ;;
  *)
    echo "Invalid file: $file"
    ;;
esac


# for
echo '引数 for 文'
for arg in "$@"; do # for の後に続く変数名には $ をつけない
    echo $arg       # 参照するときは $ をつける
done

echo 'array の for 文'
array=(abc 'def ghi' jkl;)
for element in "${array[@]}"; do
    echo $element
done


# パターンマッチング
echo 'パターンマッチング'
var=hoge-fuga
if [[ $var == hoge-* ]]; then
  echo success
else
  echo fail
fi


# case
echo 'case'
file="$1"

case "$file" in
  *.csv)
    echo this is csv
    ;;
  special-* | important-*)
    echo this is special file
    ;;
  *)
    echo "Invalid file: $file"
    ;;
esac


# list for
# ./test.sh 'aaa bbb' ccc ddd
echo 'list for'
for arg in "$@"; do # for の後に続く変数名には $ をつけない
    echo $arg       # 参照するときは $ をつける
done

array=(aaa 'bbb ccc' ddd)
for element in "${array[@]}"; do
    echo $element
done

#  $# -gt 0  引数の数が0より大きいか
#  shift
echo 'while'
while [[ $# -gt 0 ]]; do
  echo $1
  shift
done

# 関数の定義
echo '関数'
function echo_self_args()
{
  echo $1
  echo "$2"
  echo ${3}
  echo "${4}"
  echo $#
  echo "$@"
}

echo_self_args arg1 arg2 'arg3 arg4' arg5



# 関数名の取得
function echo_value1()
{
  local var1=local1
  echo ${FUNCNAME[0]} ':$var1:1:' $var1

  echo ${FUNCNAME[0]} ':$var2:1:' $var1

}

function echo_value2()
{
  local var1=local2
  echo ${FUNCNAME[0]} ':$var1:1:' $var1

  local var2=local2
  echo ${FUNCNAME[0]} ':$var2:1:' $var1

  echo_value1

  echo ${FUNCNAME[0]} ':$var1:2:' $var1
  echo ${FUNCNAME[0]} ':$var2:2:' $var1
}

var1=global
echo 'global :$var1:1:' $var1
echo 'global :$var2:1:' $var2

echo_value2

echo 'global :$var1:2:' $var1
echo 'global :$var2:2:' $var2


# 関数の終了ステータス
function return_test()
{
  if [[ -z $1 ]]; then
    echo 'arg1 is empty.'
    return 1
  fi

  echo $1
}
return_test test
echo '終了ステータス': $?
echo ---
return_test
echo '終了ステータス': $?


# 標準リダイレクト
cat hello.txt

tr hoge fuga < hello.txt


var1=value
text=$(cat << EOF
    arg1: $1       # 位置パラメータや変数なども展開される
    var1: $var1    # コメントも出力されてしまう
EOF
)
echo "$text"


