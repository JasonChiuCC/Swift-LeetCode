# 遍歷字串
let TArray      = Array(TStr.unicodeScalars)
for (index, char) in TArray.enumerate() { }

# 遞增 / 遞減 迴圈
for idx in 0..<10 {
    print("idx = \(idx)")
}            

for idx in 10.stride(to: 0, by: -1) {
    print("idx = \(idx)")
} 