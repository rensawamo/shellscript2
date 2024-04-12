https://github.com/rensawamo/shellscripts/tree/main  の続き


###  位置パラメータを集合的に扱う
- $* :  全ての位置パラメータを結合 ("arg1 2 3 ")
- $@ :  全ての位置パラメータを個別に処理 ("arg1", "2",  "3" )

### 非同期 & wait
```sh
# 非同期
(sleep 10; echo 'end')
# 終了まで待つ
wait 
```

### $$ 
- $$ : 実行されたshellのプロセスID を持つ
- $  : バックグラウンドのプロセスIDを持つ


### shellで配列を作る
```sh
# 複合代入
array=(item1 item2 'item3 item4' item5)

# 参照
echo '${array[0]}': ${array[0]}
```

### 配列の要素数の取得
```sh
${#変数名[@]}
```

### 配列のindex番号を定義して 要素を変更
```sh
echo '配列 index指定して要素を変更'
array2=(item0 [2]=item2 [4]=item4)
echo ${array2[0]}
array2[0]="変更"
echo ${array2[0]}

item0
変更 
```

### 配列のすべての要素を参照する
- {array[@]} :  "${array[0]}" "${array[1]}" ...と個別に取り出す
- ${array[*]} : "${array[0]} ${array[1]} ... と全体をひとまとめに取り出す


### 配列に要素の追加
- array に itam_a と item_bを順番に先頭に追加
```sh
(item_a item_b "${array[@]}")
```


### 配列のインデックス番号を取得
```sh
echo ${!array[@]}
```

###  shell の if 文 の書き方
shell では ステータスコード 0 or それ以外 で分岐

```sh
if 条件1; then
  条件1が真の場合の処理1
  条件1が真の場合の処理2
elif 条件2; then
  条件2が真の場合の処理
elif 条件3; then
  条件3が真の場合の処理
  if 条件4; then
    条件3, 4が真の場合の処理
  fi
else
  上記全ての条件が偽である場合の処理
fi
```


### [ ] を使ったif 分岐
[ ]  の中で 終了ステータスの判定が行われる
、if との間、第1引数との間にそれぞれスペースを空ける。
演算子と他の引数との間にもスペースを空ける。
最後の引数として ] を渡す。
```sh
# 引数の 第一引数が testか
if [ "$1" = "test" ]; then
  echo success
else
  echo fail
fi
```


### コマンド演算子 の真となる条件

```sh
- str : strが空文字でも未定義でもない
- n str : 空文字でない(未定義は許容する)
- z str : 空文字である
- str1 = str2  :  等価
```


### 整数の 比較
```sh
int1 -eq int2 :  等価
int1 -ne int2  : not 等価
int1 -lt int2  : less than int1 < int2
int1 -le int2  :  less than or equql int1 <= int2
int2 -gt int2  :  greater than int1 > int2
int2 -ge int2  :  greater than or equal int1 < int2
```


### ファイルの評価
```sh
-d file	:  file が存在し、ディレクトリである
-e file	:  file が存在する(-a と同じ)
-f file	:  file が存在し、通常のファイルである
```

### 演算結合子
```sh
-a  :  AND
-o  : OR
```

### [[]]で ANDとORをつけることができる
```sh
if [[ ( "$1" = "a"  || "$2" = "b" ) && -f test.txt ]]; then
  echo '第１引数がaまたは第２引数がbで、かつtest.txtが存在しています！'
fi
```

#### [[]] 内でのパターンマッチング
パターンマッチング
```sh
[[ $var == hoge-* ]]
```


### case による条件分岐
```sh
case 文字列 in
  パターン1)
    処理1
    ;;
  パターン2)
    処理2
    ;;
  *)
    処理3
    ;;
esac

```

### for 分岐
for 文の書き方 $ のつけるタイミングに注意
```sh
for 変数 in 変数s; do # for の後に続く変数名には $ をつけない
  繰り返す処理  # 参照するときは $ をつける
done

```


### array for 
```sh
array=(aaa 'bbb ccc' ddd)
for element in "${array[@]}"; do
    echo $element
done
```


###  [[]] 内で パターンマッチングを行う
```sh
後方一致
if [[ $var == hoge-* ]]; then 
```


###  case 文 
```sh
case 文字列 in
  パターン1)
    処理1
    ;;
  パターン2)
    処理2
    ;;
  *)
    処理3
    ;;
esac
```


###  list for 文
```sh
for 変数 in 単語リスト; do
  繰り返す処理
done
```


###  while は 指定した条件が真であるときに処理をつづける
```sh
while [[ $# -gt 0 ]]; do
  echo $1
  shift
done
```

###  関数の定義
```sh
function 関数名() 
{
  処理
}
```

### 関数名の取得
以下の形は 常に 関数名の取得になる
```sh
${FUNCNAME[0]}
``` 


###  関数の終了ステータス
return に 終了ステータスを明記した場合は、 その数字が終了ステータスになる
```sh
return 1
```


###  標準エラー

以下の  Hello という文字列を hello.txtに出力するというのは
>1 の省略系である
```sh
echo 'Hello' > hello.txt
```

- 標準入力 : 0
- 標準出力 : 1
- 標準エラー出力 : 2


### 不要なエラー出力を破棄する場合
dev/null で処理を行わない
```sh
./myscript.sh 2> /dev/null # 不要なエラー出力の破棄
```

### ヒアドキュメントを使う
- EOF:  終了文字列 

ファイルではなく直接シェルスクリプト内に入力文字列を書きたい場合はヒアドキュメントを使う
```sh
コマンド << EOF
ヒアドキュメントとして入力される内容
EOF
```





