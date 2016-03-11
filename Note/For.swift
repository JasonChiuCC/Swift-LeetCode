# 遍歷字串
let TArray      = Array(TStr.unicodeScalars)
for (index, char) in TArray.enumerate() { }   // 慢

# 遞增 / 遞減 迴圈
for idx in 0..<10 {
    print("idx = \(idx)")
}            

for idx in 10.stride(to: 0, by: -1) {
    print("idx = \(idx)")
} 

# 使用 Map 遞迴序列
var a1  = [1,2,3,4,5,6]
var a1m = a1.map({$0 * 2})
print(a1m) // [2, 4, 6, 8, 10, 12]