# 題目

給一個字串 "PAYPALISHIRING" ,並根據傳入的 rows 並把字串改寫為 zigzag pattern

假設 rows = 3, 字串的 zigzag 寫法如下

寫的順序如下,由上往下,再往右上,再由上往下...類似閃電的寫法
```
|  ^    ^
|  / |  /|
| /  | / v
v    v
```

最後字串完成類似,因為傳入 3 ,所以有 3 列,傳入 5 就 5 列...
```
P   A   H   N
A P L S I I G
Y   I   R
```

然後回傳的字串順序為第一列由左向右,第二列由左向右.....
```
-> 1. P   A   H   N
-> 2. A P L S I I G
-> 3. Y   I   R
```
最後得到 "PAHNAPLSIIGYIR"

# 想法一 (答案正確但是會 TLE )
```Swift
class Solution {
    func convert(s: String, _ numRows: Int) -> String {
        //print(s)
        if numRows <= 1 {
            return s
        }
        
        let inputStrLen = s.characters.count 
        let strArray    = Array(s.unicodeScalars)
        //print("inputStrLen  = \(inputStrLen)")        
        //print("strArray     = \(strArray)")
        
        var NumColumns  = numRows
        var NumRows     = inputStrLen
        var array = Array<Array<String>>()
        for column in 0..<NumColumns {
            array.append(Array(count:NumRows, repeatedValue:String()))
        }

        var idx     = 0
        var idxChar = 0
        //var idx = 0
        
        var firstInit   = 0
        var second      = 0
        while idxChar < inputStrLen {
            //print("idx = \(idx)")
            if firstInit == 0 {
                for first in 0..<NumColumns {
                    if idxChar < inputStrLen {
                        //print("1 first = \(first) second = \(second) strArray = \(strArray[idxChar])")
                        array[first][second] = String(strArray[idxChar])  
                    }
                    idxChar = idxChar+1
                    
                }                   
            }
            else
            {
                for first in 1..<NumColumns {
                    if idxChar < inputStrLen {
                        //print("1 first = \(first) second = \(second) strArray = \(strArray[idxChar])")
                        array[first][second] = String(strArray[idxChar])  
                    }
                    idxChar = idxChar+1
                }                  
            }
            second = second+1
            for first in (NumColumns-2).stride(to: -1, by: -1) {
                    if idxChar < inputStrLen {
                        //print("2 first = \(first) second = \(second) strArray = \(strArray[idxChar])")
                        array[first][second] = String(strArray[idxChar])  
                    }
                    idxChar = idxChar+1
            } 
            second      = second+1
            firstInit   = firstInit+1
        }        
        
        var resultStr = ""
        for column in 0..<NumColumns {
            //print(array[column])
            for idx in 0..<array[column].count {
                if array[column][idx] != "" {
                    //print(array[column][idx])
                    resultStr = resultStr + array[column][idx]
                }
            }              
        }        
        //print(resultStr)
        return resultStr
    }
}
let solution    = Solution()
let strTest     = "nowtitnziewvunuvgpufytwhlgnffzvvproxmdzvhxqekmbsewzcryjeeyjlxhgmywmlalijiypvmrpqp
                   ptipcntdygafppgldrnobzybovnhlewcxhtbuoesuhajygxbzmralrbcnqjauietpxvllbffkfrilqlmc
                   coqwpsjidlclpwcmtnzwtghaxropfaujpkfgeqohbtvqpzekndgikpkjhyzmbvxqfdyjtnsvinnznujcz
                   rmlhwvqxweyrbqyeohadbxlpkkegvignurusomrkqpdrfbywkyzmxndhzjqvrwilnefcsxoioubwxbsib
                   twyibiikydbunojtvllscvjwyftaxdbqbczckjokoredhnydbjxfggdelwgkckbfmciynyibqmexbccen
                   alviozwnigrsjwengcafmbxyhwblziybttlkvhxdooxxkdlrhnytpvtyrwksektagfkdmjiczfalinepa
                   ckrzdqrzcjemfgsmsxybfdckdnusslswvkwycpyeaeqhkltciufqxhaawxsqimnewlcaccecgxkskfwuz
                   dkwmnyjksbufoydb"
print(solution.convert(strTest,199))
```

# 想法二 (修正一些步驟 Accepted 220 ms )
```Swift
/*
主要想法其實就是傳入參數為幾列就先建立幾個陣列
例如傳入 3 就建立 3 個陣列,每一個陣列儲存字串陣列

Array[0][]
Array[1][]
Array[2][]

然後就依序將字串放入陣列中,使用 append 插入字元到陣列最後面
*/
class Solution {
    func convert(s: String, _ numRows: Int) -> String {
        //print(s)
        if numRows <= 1 {
            return s
        }
        let inputStrLen         = s.characters.count 
        let strArray            = Array(s.unicodeScalars)
        //print("inputStrLen  = \(inputStrLen)")        
        //print("strArray     = \(strArray)")
        
        let NumColumns  = numRows
        let NumRows     = inputStrLen
        //print("NumColumns   = \(NumColumns)")
        //print("NumRows      = \(NumRows)")
        var array       = Array<Array<String>>()
        for column in 0..<NumColumns {
            array.append(Array(count:0, repeatedValue:String()))
        }

        array[0].append(String(strArray[0]))
        var two     = 0
        var idxChar = 1
        firstLoop :while true {
            for one in 1..<NumColumns {
                if strArray.indices.contains(idxChar) == false {
                    break firstLoop 
                }
                array[one].append(String(strArray[idxChar]))
                //print("[\(one)][\(two)] = \(strArray[idxChar])")
                idxChar = idxChar+1
                if idxChar >= inputStrLen {
                    break firstLoop 
                }
                
            }
            two = two+1
            
            for one in (NumColumns-2).stride(to: -1, by: -1) {
                if strArray.indices.contains(idxChar) == false {
                    break firstLoop 
                }            
                array[one].append(String(strArray[idxChar]))
                //print("[\(one)][\(two)] = \(strArray[idxChar])")
                idxChar = idxChar+1
                if idxChar >= inputStrLen {
                    break firstLoop 
                }                
            }         
            two = two+1
            
            //print("==================")
        }
        /*
        for column in 0..<NumColumns {
            print(array[column])
        }           
        */
        var resultStr = ""
        for column in 0..<NumColumns {
            for idx in 0..<array[column].count {
                    resultStr = resultStr + array[column][idx]
            }              
        }    
        //print(resultStr)
        return resultStr
    }
}
```

# 傳入參數注意
```
(1)
"A"
2

(2)
"nowtitnziewvunuvgpufytwhlgnffzvvproxmdzvhxqekmbsewzcryjeeyjlxhgmywmlalijiypvmrpqp
ptipcntdygafppgldrnobzybovnhlewcxhtbuoesuhajygxbzmralrbcnqjauietpxvllbffkfrilqlmc
coqwpsjidlclpwcmtnzwtghaxropfaujpkfgeqohbtvqpzekndgikpkjhyzmbvxqfdyjtnsvinnznujcz
rmlhwvqxweyrbqyeohadbxlpkkegvignurusomrkqpdrfbywkyzmxndhzjqvrwilnefcsxoioubwxbsib
twyibiikydbunojtvllscvjwyftaxdbqbczckjokoredhnydbjxfggdelwgkckbfmciynyibqmexbccen
alviozwnigrsjwengcafmbxyhwblziybttlkvhxdooxxkdlrhnytpvtyrwksektagfkdmjiczfalinepa
ckrzdqrzcjemfgsmsxybfdckdnusslswvkwycpyeaeqhkltciufqxhaawxsqimnewlcaccecgxkskfwuz
dkwmnyjksbufoydb"
199
```