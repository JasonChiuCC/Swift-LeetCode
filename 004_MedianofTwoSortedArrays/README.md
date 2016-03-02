# 題目

輸入兩個陣列,合併排序後取中位數

例如: 

[1,2] [3,4] -> [1,2,3,4] m = (2+3)/2 = 2.5

[1,5,6,7,8,9] [2,3,4] -> [1,2,3,4,5,6,7,8,9] m = 5


# 想法一 (264-272 ms )
```Swift
class Solution {
    func findMedianSortedArrays(nums1: [Int], _ nums2: [Int]) -> Double {
        let mergeArray  = (nums1+nums2).sort(<) // 相加排序
        let mergeLen    = mergeArray.count
        var median      = 0.0
        
        if mergeLen%2 == 0 {
            let tmpVal = Double(mergeArray[(mergeLen/2)]+mergeArray[(mergeLen/2)-1])
            median = (tmpVal/2)
            //print("median = \(median)")
        } else {
            median = Double(mergeArray[(mergeLen/2)])
            //print("median = \(median)")
        }
        /*
        print("mergeArray   = \(mergeArray)")
        print("mergeLen     = \(mergeLen)")
        print("median       = \(median)")
        */
        return median
    }
}
let solution    = Solution()
let nums1       = [1,2]
let nums2       = [3,4]
print(solution.findMedianSortedArrays(nums1,nums2))
```

# 想法二
```Swift
// 減少一些 Code,基本上沒有差別
class Solution {
    func findMedianSortedArrays(nums1: [Int], _ nums2: [Int]) -> Double {
        let mergeArray  = (nums1+nums2).sort(<)
        let mergeLen    = mergeArray.count
        
        if mergeLen%2 == 0 {
            return Double(mergeArray[(mergeLen/2)]+mergeArray[(mergeLen/2)-1])/2
        } else {
            return Double(mergeArray[(mergeLen/2)])
        }
        return 0.0
    }
}
```