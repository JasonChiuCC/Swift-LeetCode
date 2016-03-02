# 初始化陣列
let array = [Int](count: 300, repeatedValue: -1)

# 將字串轉為字串陣列
e.g. Hello -> ["H","e","l","l","o"]
(1)
let a = Array(aStr)
let b = Array(bStr)

(2)
let a = Array(aStr.utf16)
let b = Array(bStr.utf16)

(3)
let a = Array(aStr.unicodeScalars)
let b = Array(bStr.unicodeScalars)

# 將字串轉為字元陣列
var myString = "Hello"
let characters = [Character](myString.characters)

# 排序
Array.sort(<)