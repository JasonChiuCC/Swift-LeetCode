# 題目

給兩個 link node list,對每個 list 中的 node 兩兩相加

最後回傳相加完的 Head Node,相加超過 10 進位到下一個 Node

Input: (2 -> 4 -> 3) + (5 -> 6 -> 4)

Output: 7 -> 0 -> 8

# 想法一 (620 ms)
```Swift
/* 
要注意如果還有進位,要自行加入一個 Node 在最後面
注意如果 input 的 list 數量不一致,要自行增加缺少的 Node ,例如:
input: 
[1,8]
[0]

因為第一個 list 有兩個,所以要自行增加一個 Node 才可以相加

Expected:
[1,8]
Definition for singly-linked list.
Input: (2 -> 4 -> 3) + (5 -> 6 -> 4)
Output: 7 -> 0 -> 8
*/
public class ListNode {
    public var val : Int
    public var next: ListNode?
    public init(_ val: Int) {
        self.val  = val
        self.next = nil
    }
}
 
class Solution {
    func addTwoNumbers(l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        var node1       = l1
        var node2       = l2
        var node3       = ListNode(0)   // 指向相加完成的 Node
        var nodeHead    = ListNode(0)   // 指向回傳的第一個 Node
        nodeHead = node3
        
        var quotient    = 0             // 商數
        var sum         = 0             // 相加數    
         
        // 檢查是否超過 10
        sum = node1!.val + node2!.val 
        if (sum/10) >= 1 {
            quotient  = 1
            node3.val = (sum%10) 
        }else{
            node3.val =  sum    
        }
                    
        repeat{
            // 檢查 list 是否還有 next Node
            if node1!.next != nil || node2!.next != nil {

                // 如果 list Node 數量不一致,自行加入缺少的 Node
                if let nextNode = node1!.next {
                    node1 = nextNode
                } else {
                    let newNode     =  ListNode(0)
                    node1!.next     = newNode
                    node1           = node1!.next
                }
            
                if let nextNode = node2!.next {
                    node2 = nextNode
                } else {
                    let newNode     =  ListNode(0)
                    node2!.next     = newNode
                    node2           = node2!.next
                }
               
                // 建立相加完的 Node 
                let tmpNode =  ListNode(0)
                sum = node1!.val + node2!.val + quotient
                if (sum/10) >= 1 {
                    quotient    = 1
                    tmpNode.val = (sum%10)
                }else{
                    quotient    = 0
                    tmpNode.val = sum   
                }                
                node3.next  = tmpNode
                node3       = node3.next!
            }else{
                break
            }
        }while(true)
        if quotient == 1 {
            let tmpNode =  ListNode(quotient)
            node3.next  = tmpNode
        }
        return nodeHead
    }
}

/* 測試方法,用來顯示 list val */
func listNode(listNode: ListNode){
    var node = listNode
    repeat{
        print("# \(node.val) #")
        if node.next != nil {
            node = node.next!    
        } else {
            return
        }
    }while(true)
}

/* List 1 */
var l1_1 = ListNode(2)
var l1_2 = ListNode(4)
var l1_3 = ListNode(3)
l1_1.next = l1_2
l1_2.next = l1_3 


/* List 2 */
var l2_1 = ListNode(5)
var l2_2 = ListNode(6)
var l2_3 = ListNode(4)
l2_1.next = l2_2
l2_2.next = l2_3

//listNode(l1_1)
//listNode(l2_1)

let solution    = Solution()
let result      = solution.addTwoNumbers(l1_1,l2_1)
listNode(result!)
```
