# 題目

輸入一個字串,要找出字串中最長的迴文字串

要注意的是,迴文有兩種 (1) abba (2) aba 都算是迴文

另外要考慮到輸入 (1) 輸入空字元(直接回傳空字串) (2) 指輸入一個字元(直接回傳那一個字元) (3) 輸入兩個字元 aa / bb

# 想法一 (1352 -1424 ms )
```Swift
/*
最直接的想法,直接分成兩部分處理
一開始先對輸入字串檢查第一種的迴文,之後取得迴文最大長度
再來一樣對輸入字串檢查第二種的迴文,之後取得迴文最大長度
最後比較哪一種迴文有最大長度,就回傳此迴文
*/
extension String {
    subscript (r: Range<Int>) -> String {
        get {
            let startIndex = self.startIndex.advancedBy(r.startIndex)
            let endIndex = self.startIndex.advancedBy(r.endIndex)

            return self[Range(start: startIndex, end: endIndex)]
        }
    }
}
class Solution {
    func longestPalindrome(s: String) -> String {
        let strLen          = s.characters.count        // 傳入字串長度
        let strArray        = Array(s.unicodeScalars)   // 將字串轉為陣列
        
        // 如果輸入字串只有 1 個字元或空字串
        if  strLen <= 1 {
            return s
        }
        
        // 儲存遞迴的開頭,例如: "axcASDDSAjuyw41" 及儲存第一個 D 的位置 5
        var startPointArray1    = [Int](count: strLen, repeatedValue: -1)
        var maxLenStart1        = 0
        var maxLen1             = 0
        
        // 儲存遞迴的開頭,例如: "axcASDSAjuyw41" 及儲存第一個 D 的位置 5
        var startPointArray2    = [Int](count: strLen, repeatedValue: -1)
        var maxLenStart2        = 0
        var maxLen2             = 0

        
        
        //print("\(strArray)")
        // 首先找 2 個相鄰且相同的字元有幾個:abba
        for idx in 0..<strLen {
            if idx != (strLen-1) && strArray[idx] == strArray[idx+1] {
                startPointArray1[idx] = 0
                //print("\(strArray[idx]) = \(idx)")
            }
        }
        print("1 = \(startPointArray1)")
        // 測試第一種迴文
        for idx in 0..<strLen {
            if startPointArray1[idx] != -1 {
                //print(idx)   
                var start = idx
                var pre   = start-1
                var suc   = start+2
                while(true) {
                    if pre >= 0 && suc < strLen && strArray[pre] == strArray[suc] {
                        //print(strArray[pre])
                        pre = pre-1
                        suc = suc+1
                    } else {
                        pre = pre+1
                        suc = suc-1
                        if (suc-pre+1) > maxLen1 {
                            maxLen1      = suc-pre+1
                            maxLenStart1 = pre
                        }
                        break    
                    }
                }
            }
        }           
        print("1 maxLenStart2   = \(maxLenStart1)")
        print("1 maxlen         = \(maxLen1)")
        
        // 找前後相同的字元有幾個: aba
        for idx in 0..<strLen {
            if idx-1 >= 0 && idx != (strLen-1) && strArray[idx-1] == strArray[idx+1] {
                startPointArray2[idx] = 0
                //print("\(strArray[idx]) = \(idx)")
            }
        }
        //print("2 = \(startPointArray2)")
        for idx in 0..<strLen {
            if startPointArray2[idx] != -1 {
                var start = idx
                var pre   = start-1
                var suc   = start+1
                while(true) {
                    if pre >= 0 && suc < strLen && strArray[pre] == strArray[suc] {
                        //print(strArray[pre])
                        pre = pre-1
                        suc = suc+1
                    } else {
                        pre = pre+1
                        suc = suc-1
                        if (suc-pre+1) > maxLen2 {
                            maxLen2      = suc-pre+1
                            maxLenStart2 = pre
                        }
                        break    
                    }
                } 
            }
        }
        print("2 maxLenStart2   = \(maxLenStart2)")
        print("2 maxlen         = \(maxLen2)")
        
        
        // 看哪種迴文比較大
        if maxLen1 > maxLen2 {
            //print("maxLen1")
            //print(s[maxLenStart1...(maxLenStart1+maxLen1-1)])
            return s[maxLenStart1...(maxLenStart1+maxLen1-1)]
        } else {
            //print("maxLen2")
            //print(s[maxLenStart2...(maxLenStart2+maxLen2-1)])
            return s[maxLenStart2...(maxLenStart2+maxLen2-1)]
        }
        return ""
    }
}
let solution    = Solution()
let strTest     = "aa"
print(solution.longestPalindrome(strTest))
```

# 想法二(984 ms)
```Swift
// 把可以合併的合併
extension String {
    subscript (r: Range<Int>) -> String {
        get {
            let startIndex = self.startIndex.advancedBy(r.startIndex)
            let endIndex = self.startIndex.advancedBy(r.endIndex)
            return self[Range(start: startIndex, end: endIndex)]
        }
    }
}
class Solution {
    func longestPalindrome(s: String) -> String {
        let strLen          = s.characters.count        // 傳入字串長度
        let strArray        = Array(s.unicodeScalars)   // 將字串轉為陣列
        
        // 如果輸入字串只有 1 個字元或空字串
        if  strLen <= 1 {
            return s
        }
        
        // 儲存遞迴的開頭,例如: "axcASDDSAjuyw41" 及儲存第一個 D 的位置 5
        var startPointArray1    = [Int](count: strLen, repeatedValue: -1)
        var maxLenStart1        = 0
        var maxLen1             = 0
        
        // 儲存遞迴的開頭,例如: "axcASDSAjuyw41" 及儲存第一個 D 的位置 5
        var startPointArray2    = [Int](count: strLen, repeatedValue: -1)
        var maxLenStart2        = 0
        var maxLen2             = 0

        //print("\(strArray)")
        // 首先找 2 個相鄰且相同的字元有幾個:abba
        for idx in 0..<strLen {
            if idx != (strLen-1) {
                if strArray[idx] == strArray[idx+1] 
                {
                    startPointArray1[idx] = 0 
                }
                
                if idx-1 >= 0 && strArray[idx-1] == strArray[idx+1] 
                {
                    startPointArray2[idx] = 0  
                }
            }
        }
        /*
        print("1 = \(startPointArray1)")
        print("2 = \(startPointArray2)")
        */
        for idx in 0..<strLen {
            // 測試第一種迴文
            if startPointArray1[idx] != -1 {
                var start = idx
                var pre   = start-1
                var suc   = start+2
                while(true) {
                    if pre >= 0 && suc < strLen && strArray[pre] == strArray[suc] {
                        pre = pre-1
                        suc = suc+1
                    } else {
                        pre = pre+1
                        suc = suc-1
                        if (suc-pre+1) > maxLen1 {
                            maxLen1      = suc-pre+1
                            maxLenStart1 = pre
                        }
                        break    
                    }
                }
            }
            
            // 測試第二種迴文
            if startPointArray2[idx] != -1 {
                var start = idx
                var pre   = start-1
                var suc   = start+1
                while(true) {
                    if pre >= 0 && suc < strLen && strArray[pre] == strArray[suc] {
                        pre = pre-1
                        suc = suc+1
                    } else {
                        pre = pre+1
                        suc = suc-1
                        if (suc-pre+1) > maxLen2 {
                            maxLen2      = suc-pre+1
                            maxLenStart2 = pre
                        }
                        break    
                    }
                } 
            }            
        } 
        /*
        print("1 maxLenStart2   = \(maxLenStart1)")
        print("1 maxlen         = \(maxLen1)")
        print("2 maxLenStart2   = \(maxLenStart2)")
        print("2 maxlen         = \(maxLen2)")
        */
        return (maxLen1 > maxLen2) ? s[maxLenStart1...(maxLenStart1+maxLen1-1)] : s[maxLenStart2...(maxLenStart2+maxLen2-1)]
    }
}
```