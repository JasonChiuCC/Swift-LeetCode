# 題目

輸入數字判斷是否為迴文,例如 12321,456654

注意:

1. 0 是迴文

2. 負數不是迴文

# 想法一 (416 ms)
```Swift
/*
直覺想法,先將傳入數字依序除10 取餘數,並存到陣列中
例如輸入數字為 123456,最後陣列為 [6,5,4,3,2,1]
然後對此陣列反轉,並依序比對陣列元素
如果是迴文數字,比對會全部一樣
*/
class Solution {
    func isPalindrome(x: Int) -> Bool {
        if x == 0 {
            return true
        } else if  x < 0 {
            return false
        }
        
        var intArray    = [Int]()
        var input       = x
        while input > 0 {
            intArray.append(input%10)
            input = input/10
        }
        
        for (index, item) in intArray.reverse().enumerate() {
        	if item == intArray[index] {
        	    continue
        	}else{
        	    return false
        	}
        }
        return true
    }
}

let solution    = Solution()
let strTest     = -2147483648
print(solution.isPalindrome(strTest))
```

# 想法二 (192 ms)
```Swift
/*
不使用額外陣列,直接儲存反轉後的數字,假設輸入 12345
revInt = 5  oriInt = 1234
revInt = 54  oriInt = 123
revInt = 543  oriInt = 12
revInt = 5432  oriInt = 1
revInt = 54321  oriInt = 0
*/
class Solution {
    func isPalindrome(x: Int) -> Bool {
        if x < 0 { return false }
        var oriInt  = x
        var revInt  = 0
        while oriInt > 0 {
            revInt  = revInt*10 + oriInt%10
            oriInt  = oriInt/10
            print("revInt = \(revInt)  oriInt = \(oriInt)")
        }
        return (x == revInt) ? true : false
    }
}
```