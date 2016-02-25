# 題目

給一個陣列和目標,將陣列中的值兩兩相加

找出加起來會等於目標值,最後回傳此兩個值的索引值

Given nums = [2, 7, 11, 15], target = 9,

Because nums[0] + nums[1] = 2 + 7 = 9,

return [0, 1].

# 想法一

建立一個迴圈,傳入陣列多大就跑幾次

每一次迴圈中,把自己和其他陣列值相加(排除自己加自己)

一旦相加值符合目標值就回傳索引值

```Swift
class Solution {
    func twoSum(nums: [Int], _ target: Int) -> [Int] {
        /* 取陣列大小 */
        let arrayLen    = nums.count

        for index in 0..<arrayLen {
            let now = nums[index]
            var sum = 0
            //print("now = \(now) , sum = \(sum)")

            /* 自己和其他陣列值相加*/            
            for i in 0..<arrayLen {
                /* 排除自己加自己 */
                if i == index {
                    continue
                }
                sum = now + nums[i]
                //print("\(sum) = \(now) + \(nums[i])")
                
                /* 如果將加等於目標值就回傳 */
                if sum == target {
                    return [index,i]
                }
            }
        }
        return [0]
    }
}
let solution = Solution()
let arrayNum = [3,2,4]
let target   = 6
let result   = solution.twoSum(arrayNum,target)
print(result)
```

# 想法二

使用 Map 解題,假設傳入陣列是 [3,2,4] 目標是 6, 也可以說我們對每個陣列值所要找的數字是

3 要找 6-3 = 3

2 要找 6-2 = 4

4 要找 6-4 = 2

那我們就把要找的數字(3,4,2) 放到另一個 map 中

每一次迴圈就去 map 中找是否有符合的數字

```Swift
class Solution {
    func twoSum(nums: [Int], _ target: Int) -> [Int] {
        var maps = [Int: Int]() // 建立一個 map
        for index in 0..<nums.count {
            var value = nums[index]
            if let numValue = maps[value] {
                //print(maps[value]!)
                //print(index)
                return [maps[value]! , index ]
            } else {
                /* 將自己放入 map 中, key = 目標 - 自己, 值 = 索引值*/
                maps[target - value] = index
            }
        }
        return [0]
    }
}
let solution = Solution()
let arrayNum = [3,2,4]
let target   = 6
let result   = solution.twoSum(arrayNum,target)
print(result)
```

