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

# 想法三(152 ms)
```Swift
/*使用 Manacher 演算法
http://articles.leetcode.com/longest-palindromic-substring-part-ii
實際做法有幾個步驟
1.  將原字串 S 改為 T ,字元之間加上 #,主要用於不管 S 為奇偶數都可變為 T 奇數(非必須)
2.  開始由左向右掃描字串
3.  每次掃到 i 位置時先檢查是否在 R 內
      => 不在 R 內 -> 重新計算 P 
      => 在   R 內 -> 找鏡像 i' 的 P 值(以 C 為中心) 是否大於 R,沒有就可以直接使用,有的話只能使用 R-i 來當作 P
4.  計算 P 值(如果根據 3 已經得到 P 值後,直接從 P 值+1 的位置開始算,避免又重複計算一次)
5.  檢查 i 位置加上 P[i] 是否大於 R,如果是代表 R 可以繼續擴大,並且 C 移動到 i 目前的位置

結論: 
非常難用文字理解,需要實際畫圖才能理解流程
此演算法重點在於"使用之前就計算好的 P 值"(使用鏡像的 P 值)
所以可以減少重複計算的時間
*/
extension String {
    subscript (r: Range<Int>) -> String {
        get {
            let startIndex  = self.startIndex.advancedBy(r.startIndex)
            let endIndex    = self.startIndex.advancedBy(r.endIndex)
            return self[Range(start: startIndex, end: endIndex)]
        }
    }
}
class Solution {
    // 將原始字串 S 加入 # ,並在最前加入^,最後加入 $,目的是避免在迴圈中對陣列 out of range 
    func preProcess(s:String) -> String {
        let strArray    = Array(s.unicodeScalars)
        var sb          = [String]()
        sb.append("^")
        for i in 0..<s.characters.count  {
            sb.append("#")
            sb.append(String(strArray[i]))
        }
        sb.append("#")
        sb.append("$")
        return sb.joinWithSeparator("") // 字串陣列轉字串
    }

    func longestPalindrome(s: String) -> String {
        if  (s.characters.count) <= 1 {
            return s
        }    
        let TStr        = preProcess(s)
        let TArray      = Array(TStr.unicodeScalars)
        let TLen        = TStr.characters.count
        var P           = [Int](count: TLen, repeatedValue: -1) // 記錄 i 位置的字元最大迴文長度
        var C           = 0                                     // 記錄中心點位置,會變動
        var R           = 0                                     // 記錄最右邊的 Range
        //print(TLen)
        //print(TStr)
        //print(TArray)
        //print(preProcess(s).characters.count)
        
        for i in 1..<(TLen-1) {
            /*
            找目前 i 位置的鏡像,以 C 為中心 to i' = C - (i-C)
            例如:  a b c a b c a b c 
                   0 1 2 3 4 5 6 7 8
            假設 C 位於 4,而目前 i 位在 6 ,則 i 的鏡像 i' = 2 (以 C 為中心的對稱位置)
            */
            let i_mirror    = 2*C-i  
            
            
            if R > i  // 檢查目前位置 i 是否在 R 裡面
            {
                /*
                如果是,則直接把鏡像的 P 值給他
                但這裡還要特別注意,如果鏡像的 P 值大於 R-i
                表示在鏡像的那個位置的迴文範圍已經超出 R 的鏡像範圍,這邊就只能把 R-i 給他
                */
                P[i] = min(R-i, P[i_mirror])  
            }
            else
            {
                // 沒有在 R 裡面,需要重新計算 P 值
                P[i] = 0    
            }
            
            // 計算 P 值的地方,以目前 i 的位置重複往前和往後比較,如果相同則目前 i 位置的 P 值 +1
            while TArray[i + 1 + P[i]] == TArray[i - 1 - P[i]] {
                P[i] = P[i]+1
            }
            
            // 如果目前位置 i 的 P 值比目前的 R 還大,則將 R 擴張,並且中心點ㄉ移動到 i 的位置
            if i + P[i] > R {
              C = i
              R = i + P[i]
            }
        }
        
        var maxLen      = 0;
        var centerIndex = 0;
        for i in 1..<(TLen-1) {
            if P[i] > maxLen {
              maxLen        = P[i]
              centerIndex   = i
            }
        }
        //print("maxLen       = \(maxLen)")
        //print("centerIndex  = \(centerIndex)")
        var result      = ""
        for i in centerIndex-maxLen...centerIndex+maxLen {
            if TArray[i] != "#" {
                result = result+String(TArray[i])
            }
        }
        //print(result)
        return result
    }
}
```

想法四(194 ms)
```Swift
// 整理 Code 
class Solution {
    func preProcess(s:String) -> String {
        let strArray    = Array(s.unicodeScalars)
        var sb          = [String]()
        sb.append("^")
        for i in 0..<s.characters.count  {
            sb.append("#")
            sb.append(String(strArray[i]))
        }
        sb.append("#")
        sb.append("$")
        return sb.joinWithSeparator("")
    }
	func longestPalindrome(s: String) -> String {
        if  (s.characters.count) <= 1 {
            return s
        } 	
        let SArray      = Array(s.characters)
        let TStr        = preProcess(s)
        let TArray      = Array(TStr.unicodeScalars)
        let TLen        = TStr.characters.count
        var P           = [Int](count: TLen, repeatedValue: -1) // 記錄 i 位置的字元最大迴文長度
        var C           = 0                                     // 記錄中心點位置,會變動
        var R           = 0                                     // 記錄最右邊的 Range
		var maxP        = 0 
		var maxPIndex   = 0
		
		for (index, char) in TArray.enumerate() {
			if index == 0 || index == TLen - 1 {
				continue
			}
			//print("index = \(index) / char = \(char)")
			
			// (1)
			P[index] = R > index ? min(P[2*C-index], R-index) : 1
			
			// (2)
			while   index + P[index] < TLen - 1 && 
			        index - P[index] > 0        && 
			        TArray[index + P[index]] == TArray[index - P[index]]
			{
				P[index] = P[index]+1
			}
			
			// (3)
			if index + P[index] > R {
			    C = index
				R = index + P[index]
			}
			
			// (4)
			if maxP < P[index] {
				maxP        = P[index]
				maxPIndex   = index
			}
		}
		//print(maxP)
		//print(maxPIndex)
		//print(P)
		let startPos    = maxPIndex / 2 - maxP / 2
		let endPos      = startPos + maxP - 2
		return String(SArray[startPos...endPos])
	}
}
```
