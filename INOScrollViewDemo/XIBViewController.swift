//
//  XIBViewController.swift
//  INOScrollViewDemo
//
//  Created by angrybirds on 2017/4/10.
//  Copyright © 2017年 YuanMedia. All rights reserved.
//

import UIKit

class XIBViewController: UIViewController {
    
    @IBOutlet weak var scrollView: INOScrollView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        edgesForExtendedLayout = UIRectEdge(rawValue: 0)
        navigationController?.navigationBar.isTranslucent = false
        
        scrollView.autoScrollTimerInterval = 2.0
        view.layoutIfNeeded()
        scrollView.imageArray = [
            "http://wx3.sinaimg.cn/mw690/62eeaba5ly1fee5yt59wrj20fa08lafr.jpg",
            "http://wx4.sinaimg.cn/mw690/6a624f11ly1fed4bwlbb0j20go0h6q5h.jpg",
            "http://c.hiphotos.baidu.com/image/w%3D400/sign=c2318ff84334970a4773112fa5c8d1c0/b7fd5266d0160924c1fae5ccd60735fae7cd340d.jpg",
            "http://wx2.sinaimg.cn/mw690/af0d43ddgy1fdjzefvub1j20dw09q48s.jpg"
        ]
        
        scrollView.titleArray = [
            "111111",
            "222222",
            "333333",
            "444444",
        ]
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
