# 題目

將輸入字串反轉輸出,例如 123 -> 321, -123 -> -321

注意正負號要一樣,另外要注意反轉完的數字是否有 overflow

此題目是傳入 Int 型態,不過各語言對 Int 可以儲存的大小不一定相同

例如 Swift Int 最大可儲存的範圍是 -9223372036854775808 ~ 9223372036854775807 ( -2^63 ~ 2^63)

這是因為 Swift 的 Int 會隨平台的位元改變,所以 32 位元/64 位元的 Int 都不同

不過這題只會判斷一般的 Int 狀況,也就是只會判斷 32 位元的 Int

所以最小~最大的範圍是 -2147483648 ~ 2147483647


# 想法一 (52 ms)
```Swift
/*
將傳入數字轉陣列在反轉,然後再轉為數字
在判斷是否 overflow
*/
class Solution {
    func reverse(x: Int) -> Int {
        if x == 0 {
            return x
        }
        let isPositive  = (x > 0) ? true : false
        let strArray    = Array((String(abs(x))+"").unicodeScalars)
        var resStr      = ""
        var resInt      = 0
        for idx in (strArray.count-1).stride(to: -1, by: -1) {
            //print(strArray[idx])
            resStr = resStr + String(strArray[idx])
        }
        //print(resStr)
        resInt = (isPositive) ? Int(resStr)! : -Int(resStr)!
        
        /*
        Int32.max =  2147483647
        Int32.min = -2147483648
        */
        if (isPositive == false && resInt <= Int(Int32.min)) || (isPositive == true && resInt > Int(Int32.max)) {
            return 0        
        }
        print(resInt)
        return resInt
    }
}
```

# 想法二(32 ms)
```Swift
//使用除法運算
class Solution {
    func reverse(x: Int) -> Int {
        if x == 0 {
            return x
        }
        let isPositive      = (x > 0) ? true : false
        var input           = x
        var ret             = 0
        while input != 0 {
            ret     = ret*10 + input%10;
            input   = input/10;
        }
        if (isPositive == false && ret <= Int(Int32.min)) || (isPositive == true && ret > Int(Int32.max)) {
            return 0        
        }        
        return ret
    }
}
```


# 傳入參數注意
```
1534236469
```