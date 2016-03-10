# 初始化陣列
let array           = [Int](count: 300, repeatedValue: -1)
let array           = [String]()
let array:[Int]     = [1, 2, 3]
let array:[Int]     = []
let array:[Int]     = [1, 2]

# 初始化 Optional 陣列
let array: Int?[]       = [1, 2, nil, 4, 5]
let array: [Int?]       = [1, 2, nil, 4, 5]
let array: Array<Int?>  = [1, 2, nil, 4, 5]
let array               = [String?](count:64, repeatedValue: nil)

# 陣列長度
array.count

# 將字串轉為字串陣列
e.g. Hello -> ["H","e","l","l","o"]
// 轉陣列但元素為 Character
let array = Array(aStr.characters)
let array = Array(aStr.utf16)
let array = Array(aStr.unicodeScalars)

// 轉陣列且元素為 String
aStr.characters.map { String($0) }

# 將字串轉為字元陣列
let myString    = "Hello"
let characters  = [Character](myString.characters)
let characters  = Array(myString.characters)

# 將字串陣列轉字串
let strTest = array.joinWithSeparator("")

# 排序
Array.sort(<)

# 陣列加入元素
array.append("$")

# 陣列移除元素
strArray.removeAtIndex(0) 