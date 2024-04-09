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
