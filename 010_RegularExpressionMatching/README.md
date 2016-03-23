# 題目
```
實作正則表達式,提供 "." 和 "*" 運算

"." 表示任何"單一字元",例如 "a" == "." 或 "#" == "." 
注意 "." 只代表一個字元,所以如果你寫 "aa" 是不 match "." 的
就要改寫成 "aa" == ".." 兩個點


"*" 表示可以代表 0 個或多個"前面的一個字元"
例如 "a*", 前面一個字元是 "a", 所以"a*"表示只要是 0 個或多個 a 都 match
舉例:
""    == "a*"  => T
"a"   == "a*"  => T
"aaa" == "a*"  => T

PS: 這裡的 "*" 和真正的正則表達式意義不一樣
真正的正則表達 "*" 可以代表前面所有字元
但此題的 "*" 只表達前面那一個字元
另外 0+ 表示可以是 0 個或多個的意思

綜合比較:
(1) aac*a*b  : 把它括號起來看變成 aa(c*)(a*)b 表示 c 和 a 可以出現 0 次或多次,所以
"aab" == "aac*a*b"  => T   (都出現 0 次)

(2) aac*aa*b : 把它括號起來看變成 aa(c*)a(a*)b ,注意中間有個 a ,所以這個 a 一定會出現
"aab" == "aac*aa*b" => F
```

# 想法一 ()
```Swift
/* 完全沒有想法,參考 http://www.programcreek.com/2012/12/leetcode-regular-expression-matching-in-java/
使用遞迴方法來做,使用遞迴常常會讓人不知道跑到哪個地方
所以如果一個 function 使用到遞迴,只要特別注意 return 的那個地方
也就是不管跑到哪裡,最後一定會跑到某個條件成立的地方 return ,不然就變成無窮迴圈了

步驟紀錄,傳入 s 和 p 
(1) 檢查 p 長度, 如果 p.len == 0 , 再檢查 s.len 是否 == 0 
    是就 return T , 否則 return F 
    
(2) 如果 p.len 長度 == 1,會有 3 種情況
    - s.len < 0, retrun F           ( 特別注意,如果 s = "" , p=" *" 是 match 的, 不過這時候 p.len 不是 1 )
    - s[0] != p[0] 且 p[0] != "."    (注意還要檢查 p[0] 是否為 "." , 因為它可以代表任意字元)
    -     
*/
private extension String {
    subscript (index: Int) -> Character {
        return self[self.startIndex.advancedBy(index)]
    }
    subscript (range: Range<Int>) -> String {
        return self[self.startIndex.advancedBy(range.startIndex)..<self.startIndex.advancedBy(range.endIndex)]
    }
    
    func subString(startIndex: Int ) -> String {
        if startIndex >= self.length { return "" }
        return self[self.startIndex.advancedBy(startIndex)...self.endIndex.predecessor()]
    }    
    
    var length: Int { return self.characters.count }
}

//var a = "abc"
//print(a.subString(3))

class Solution {
    func isMatch(s: String, _ p: String) -> Bool {
        /*  s = "abc" and p = "" */
        if p.length == 0 {
            return (s.length == 0)      // ### 遞迴停止點
        }
        
        /* 特殊情況 */
        if p.length == 1 {
            if s.length == 0 {
                /*  s = "" and p = "a" */
                return false            // ### 遞迴停止點
            }
            else if ( p[0] == s[0] ) {
                return true            // ### 遞迴停止點
            }
            else if ( p[0] != s[0] ) && ( p[0] != "." ){
                /*  s = "abc" and p = "b" */
                return false            // ### 遞迴停止點
            }
            else {
                /*  s = "aa" and p = "a" */
                return isMatch(s.subString(1),p.subString(1))
            }
        }
        /*  以上是屬於特殊情況,真正要考慮的是下面的情形             */
        // ===========================================================
        /*  以下 Case 表示 p 長度 >= 2 , 會有 2 種情況
            Case 1:  如果 p[1] != "*" 
            e.g. aa / ab / a. / .. / .a / etc                       */ 
        if p[1] != "*" {
            if s.length < 1 {
                /* p >=2 且 p[1] != "*" 這時 s < 1 就一定是 false ( s = "" and p = aaa ) */
                return false
            }
            
            if ( p[0] != s[0] ) && ( p[0] != "." ) {
                /* 兩字串第一個 char 相比,且 p[0] 又不是 "." 那就一定是 false ( s = abc and p = bbb )*/
                return false
            }
            else {
                /* 表示 s.len >=1 , p[0] == s[0] or p[0] == "." */
                return isMatch(s.subString(1),p.subString(1))
            }
        }
        /* Case 2: 當 p[1] == "*"
           e.g. a* / .* / b* / etc
        */
        else {		
            if isMatch(s,p.subString(2)) {
                return true
            }

            var i = 0
            while ( i < s.length ) && ( s[i] == p[0] || p[0] == "." ) {
                if isMatch( s.subString(i+1), p.subString(2) ) {
                    return true
                }
                i = i + 1
            }
            return false;
        }
    }
}

let solution    = Solution()
let s           = "aa"
let p           = "a*"
print(solution.isMatch(s,p))

```