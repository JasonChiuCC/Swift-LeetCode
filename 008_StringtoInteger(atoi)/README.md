# 題目

輸入字串轉成數字回傳,要考慮比較多東西

# 想法一 (TLE)
```Swift
class Solution {
    func myPow(a:Int, _ b:Int) -> (Int,Bool) {
        var n = 1
        for idx in 0..<b {
            let (result, didOverflow) = Int.multiplyWithOverflow(n,a)
            print("result       = \(result)")
            print("didOverflow  = \(didOverflow)")
            if didOverflow == true {
                print("=OverFlow=")
                return (0,true)
            }
            else
            {
                n = result
            }
        }
        //print("n = \(n)")
        return (n,false)
    } 
    func myAtoi(str: String) -> Int {
        if str == "" {
            return 0
        }

        var strArray    = str.characters.map { String($0) }
        let isPositive  = ( strArray[0] != "-") ? true : false
        //print("isPositive   = \(isPositive)")
        //print("strArray     = \(strArray)")
        //print("strLen       = \(strLen)")


        var resultArray = [String]()
        for idx in 0..<strArray.count {
            print("idx = \(idx)  strArray[idx] = \(strArray[idx])")
            if strArray[idx] != "+" && strArray[idx] != "-" && strArray[idx] != " " {
                //strArray.removeAtIndex(idx) 
                resultArray.append(strArray[idx])
            }
        }
        print("resultArray  = \(resultArray)")
        let strLen      = resultArray.count
        var ten         = (strLen-1)        
        print("strLen       = \(strLen)")        
    
        var result = 0
        for idx in 0..<strLen {
            //print("ten  = \(myPow(10, ten))  idx= \(idx) strArray = \(strArray[idx])")
            // -2147483648 ~ 2147483647
            switch resultArray[idx] {
                case "0":
                    print("0")
                case "1": 
                    print("1")
                    let (powResult, didPowOverflow) = myPow(10, ten)
                    if didPowOverflow == true {
                        return 0
                    }
                    let (addResult, didAddOverflow) = Int.addWithOverflow(result,1*powResult)
                    if didAddOverflow == true {
                        return 0
                    }
                    result = addResult
                case "2": 
                    //print("2")
                    let (powResult, didPowOverflow) = myPow(10, ten)
                    if didPowOverflow == true {
                        return 0
                    }
                    
                    let (addResult, didAddOverflow) = Int.addWithOverflow(result,2*powResult)
                    if didAddOverflow == true {
                        return 0
                    }
                    result = addResult
                                    
                case "3": 
                    //print("3")
                    let (powResult, didPowOverflow) = myPow(10, ten)
                    if didPowOverflow == true {
                        return 0
                    }
                    
                    let (addResult, didAddOverflow) = Int.addWithOverflow(result,3*powResult)
                    if didAddOverflow == true {
                        return 0
                    }
                    result = addResult
                case "4": 
                    //print("4") 
                    let (powResult, didPowOverflow) = myPow(10, ten)
                    if didPowOverflow == true {
                        return 0
                    }
                    
                    let (addResult, didAddOverflow) = Int.addWithOverflow(result,4*powResult)
                    if didAddOverflow == true {
                        return 0
                    }
                    result = addResult
                case "5": 
                    //print("5") 
                    let (powResult, didPowOverflow) = myPow(10, ten)
                    if didPowOverflow == true {
                        return 0
                    }
                    
                    let (addResult, didAddOverflow) = Int.addWithOverflow(result,5*powResult)
                    if didAddOverflow == true {
                        return 0
                    }
                    result = addResult
                case "6": 
                    //print("6") 
                    let (powResult, didPowOverflow) = myPow(10, ten)
                    if didPowOverflow == true {
                        return 0
                    }
                    
                    let (addResult, didAddOverflow) = Int.addWithOverflow(result,6*powResult)
                    if didAddOverflow == true {
                        return 0
                    }
                    result = addResult
                case "7": 
                    //print("7") 
                    let (powResult, didPowOverflow) = myPow(10, ten)
                    if didPowOverflow == true {
                        return 0
                    }
                    
                    let (addResult, didAddOverflow) = Int.addWithOverflow(result,7*powResult)
                    if didAddOverflow == true {
                        return 0
                    }
                    result = addResult
                case "8": 
                    //print("8") 
                    let (powResult, didPowOverflow) = myPow(10, ten)
                    if didPowOverflow == true {
                        return 0
                    }
                    
                    let (addResult, didAddOverflow) = Int.addWithOverflow(result,8*powResult)
                    if didAddOverflow == true {
                        return 0
                    }
                    result = addResult
                case "9": 
                    //print("9") 
                    let (powResult, didPowOverflow) = myPow(10, ten)
                    if didPowOverflow == true {
                        return 0
                    }
                    
                    let (addResult, didAddOverflow) = Int.addWithOverflow(result,9*powResult)
                    if didAddOverflow == true {
                        return 0
                    }
                    result = addResult
                default : 
                    print("default") 
                    return 0
            }
            
            ten = ten-1
            //print("result = \(result)")
            //print(result > Int(Int32.max))
        }
        print("result = \(result)")
        if !isPositive {
            result = -result
        }
        if (isPositive == false && result <= Int(Int32.min)) || (isPositive == true && result > Int(Int32.max)) {
            return 0        
        }
        return result
    }
}

let solution    = Solution()
let strTest     = "        1199g7805318"
print(solution.myAtoi(strTest))
```

# 想法二 (84 ms)
```Swift
extension Character
{
    func unicode() -> UInt32
    {
        let characterString = String(self)
        let scalars = characterString.unicodeScalars
        return scalars[scalars.startIndex].value
    }
}
class Solution {
    /*  
      去除空白,只會回傳第一組字串
      e.g. "  +012 123" -> 回傳 +012 後面 123 捨棄,這是題目規定的
      注意不要回傳 +012123 
      Your first test case has a space in between two different digit groups, 
      and atoi only consider the first group which is '0' and convert into intege
    */
    func Trim(input:String, _ removeChar:Character)-> String {
        var resArray    = [String]()
        var result      = ""
        var isChar      = false
        
        for char in input.characters {
            if char == removeChar && isChar == true {
                    break
            }
            
            if char != removeChar {
                isChar = true
                resArray.append(String(char))
            }
            //print("resArray = \(resArray)")
        }
        //print("resArray = \(resArray)")
        return resArray.joinWithSeparator("")
    }    
    
	/* 檢查是否為數字
       0 -> 48 , 1 -> 49   .... 9 -> 57 */
	func isDigit(char: Character) -> Bool {
			if char.unicode() >= 48 && char.unicode() <= 57 {
				return true
			} else {
				return false
			}
		return false
	}    
    
	func myAtoi(str: String) -> Int {
	    let trimSpaceStr  = Trim(str," ")
		if trimSpaceStr.characters.count == 0 {
			return 0
		}
		
		var strArray    = Array(trimSpaceStr.characters)
		var resStr      = ""
		var isNeg       = false  // 是否為負數
		var hasVal      = false  // 是否有數字字元,有可能傳入的字串都不是數字
		var index       = 0
		
		// (1) Check first char is "-" or "+"
        if strArray[0] == "-" {
		    isNeg = true
		    strArray.removeAtIndex(0) 
		} else if strArray[0] == "+" {
		    strArray.removeAtIndex(0) 
		} 		
		
		/* 
		(2) Get char and must be digit if not then break
		e.g. "123#$2" -> 123
		     "123  2" -> 123 */
		for (index, char) in strArray.enumerate() {
			if isDigit(char) {
				hasVal = true
				resStr.append(char)
			} else {
				break
			}
		}
		//print("resStr = \(resStr)")
		

		if !hasVal {
		    // 都沒有數字
			return 0
		} 
		else if resStr.characters.count > 10 {
		    /* 題目提到:
		    如果沒有任何數字,回傳 0
		    If no valid conversion could be performed, a zero value is returned. 
		    
		    // 如果數字大於可儲存的範圍(-2147483648 ~ 2147483647),回傳 INT_MAX / INT_MIN
		    If the correct value is out of the range of representable values, 
		    INT_MAX (2147483647) or INT_MIN (-2147483648) is returned. */
			if isNeg {
				return Int(Int32.min)
			} else {
				return Int(Int32.max)
			}
		} else {
			if isNeg {
			    let result = Int(resStr)! * -1
			    return (result < Int(Int32.min)) ? Int(Int32.min) : result
			} else {
			    let result = Int(resStr)!
			    return (result > Int(Int32.max)) ? Int(Int32.max) : result
			}
		}
		return 0
	}

}

let solution    = Solution()
//let strTest     = "+-2"
let strTest     = "-2147483649"
print(solution.myAtoi(strTest))
```

# 想法三
```Swift
/*
整理過後的 Code,不使用 Obj-C 的方法
*/
extension Character
{
    func unicode() -> UInt32
    {
        let characterString = String(self)
        let scalars = characterString.unicodeScalars
        return scalars[scalars.startIndex].value
    }
}
class Solution {
    func Trim(input:String, _ removeChar:Character)-> String {
        var resArray    = [String]()
        var isChar      = false
        
        for char in input.characters {
            if char == removeChar && isChar == true {
                    break
            }
            if char != removeChar {
                isChar = true
                resArray.append(String(char))
            }
        }
        return resArray.joinWithSeparator("")
    }    
    
	func isDigit(char: Character) -> Bool {
        return (char.unicode() >= 48 && char.unicode() <= 57) ? true : false 			
	}    
    
	func myAtoi(str: String) -> Int {
	    let trimSpaceStr  = Trim(str," ")
		if trimSpaceStr.characters.count == 0 {
			return 0
		}
		
		var strArray    = Array(trimSpaceStr.characters)
		var resStr      = ""
		var isNeg       = false  // 是否為負數
		var hasVal      = false  // 是否有數字字元,有可能傳入的字串都不是數字
		var index       = 0
		
        if strArray[0] == "-" {
		    isNeg = true
		    strArray.removeAtIndex(0) 
		} else if strArray[0] == "+" {
		    strArray.removeAtIndex(0) 
		} 		
		
		for (index, char) in strArray.enumerate() {
			if isDigit(char) {
				hasVal = true
				resStr.append(char)
			} else {
				break
			}
		}

		if !hasVal {
			return 0
		} else if resStr.characters.count > 10 {
		    return (isNeg) ? Int(Int32.min) : Int(Int32.max)
		} else {
		    let result = Int(resStr)!
			if isNeg {
			    return ( result * -1 < Int(Int32.min)) ? Int(Int32.min) : result * -1
			} else {
			    return ( result > Int(Int32.max)) ? Int(Int32.max) : result
			}
		}
		return 0
	}

}
```

# 傳入參數注意
```
1. 加法/乘法溢位
2. 字串前加 "-","+","多個空格"
3. 輸入字串中有"非數字的字串" (123defgg555)
4. 如果有多個空格,只取最前面一組數字("  +1 23" => 只取 +1 ,後面 23 捨棄)
```