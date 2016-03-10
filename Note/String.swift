# 字串長度
var s: String
let inputStrLen = s.characters.count 

# 根據索引(idx)取字串字元 - 很慢
let strIdx  = s.startIndex.advancedBy(idx)
let nowChar = s.characters[strIdx]

# 擷取字串
Swift 1.2 用法
位置(-)        9876543210
位置           0123456789    
var s       = "1234567890"
let idx     = s.startIndex.advancedBy(5)  
let idx2    = s.endIndex.advancedBy(-6)   
var range   = Range<String.Index>(start: idx2,end: idx)

var s1:String   = s.substringFromIndex(index)  // 由(From)字串第 5  位開始,包含第 5 位一直到最後  = [5...9]
var s2:String   = s.substringToIndex(index2)   // 由開頭到(To)字串第 -6 位開始,包含第 -6 位       = [0...3]
var s3          = s.substringWithRange(range)

print(s1) // 67890
print(s2) // 1234
print(s3) // 5

Swift 2.2 用法
位置(-)        9876543210
位置           0123456789
var s       = "1234567890"   
s[s.startIndex]                 // 1 取出字串中第 1 位
s[s.endIndex.predecessor()]     // 0 取出字串中最後 1 位
s[s.startIndex.successor()]     // 2 取出字串中最後 1 位的後面那一個

let index = s.startIndex.advancedBy(7)
s[index]  // 8 取出字串中第 7 位

// 下面兩種範圍是一樣的意思
let idx1 = s.startIndex.advancedBy(0)..<s.endIndex.advancedBy(-4)
let idx2 = s.startIndex.advancedBy(0)..<s.startIndex.advancedBy(6)
s[idx1]  // 123456  
s[idx2]  // 123456

