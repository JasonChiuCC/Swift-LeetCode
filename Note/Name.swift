# 命名
Elem                Element   


# 顯示物件類型
let v1  :String         = "testing"
let v2  :[String]       = ["one", "two"]
let v3  :Any            = "testing"

let v1Mirror            = Mirror(reflecting: v1)
let v2Mirror            = Mirror(reflecting: v2)
let v3Mirror            = Mirror(reflecting: v3)
    
print(v1Mirror.subjectType)  // Prints "String"
print(v2Mirror.subjectType)  // Prints "Array<String>"
print(v3Mirror.subjectType)  // Prints "String"
