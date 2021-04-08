//
//  ViewController.swift
//  ios-interview-train-demo
//
//  Created by story5 on 2021/4/2.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let leetCode:LeetCode = LeetCode()
        print(leetCode.twoSum([2,7,11,15], 9))
        print(leetCode.twoSum([3,2,4], 6))
        print(leetCode.twoSum([2,5,5,11], 10))
    }
}

