//
//  LeetCode.swift
//  ios-interview-train-demo
//
//  Created by story5 on 2021/4/2.
//

import Foundation

class LeetCode: NSObject {
    /** 1.两数之和
     * 暴力枚举
     */
    func twoSum(_ nums:[Int],_ target:Int) -> [Int] {
//        return twoSumL(nums,target);
        return twoSumDic(nums, target);
    }
    
    func twoSumL(_ nums:[Int],_ target:Int) -> [Int] {
        for i in 0...nums.count-1 {
            for j in i+1...nums.count-1 {
                if nums[i] + nums[j] == target {
                    return [i,j]
                }
            }
        }
        return [];
    }
    
    func twoSumDic(_ nums:[Int],_ target:Int) -> [Int] {
        var dic = [Int:Int]()
        for (index,num) in nums.enumerated() {
            let num2 = target - num
            if (dic.keys.contains(num2)) {
                return [dic[num2]!,index]
            }
            dic[num] = index;
        }
        return []
    }
}
