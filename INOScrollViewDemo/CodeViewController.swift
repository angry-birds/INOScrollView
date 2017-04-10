//
//  CodeViewController.swift
//  INOScrollViewDemo
//
//  Created by angrybirds on 2017/4/10.
//  Copyright © 2017年 YuanMedia. All rights reserved.
//

import UIKit

class CodeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        edgesForExtendedLayout = UIRectEdge(rawValue: 0)
        
        let tableView = UITableView.init(frame: view.frame, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        
        let header = INOScrollView(frame: CGRect.init(x: 0, y: 0, width: view.frame.size.width, height: 200))
        header.autoScrollTimerInterval = 2.0
        header.imageArray = [
            "http://wx3.sinaimg.cn/mw690/62eeaba5ly1fee5yt59wrj20fa08lafr.jpg",
            "http://wx4.sinaimg.cn/mw690/6a624f11ly1fed4bwlbb0j20go0h6q5h.jpg",
            "http://c.hiphotos.baidu.com/image/w%3D400/sign=c2318ff84334970a4773112fa5c8d1c0/b7fd5266d0160924c1fae5ccd60735fae7cd340d.jpg",
            "http://wx2.sinaimg.cn/mw690/af0d43ddgy1fdjzefvub1j20dw09q48s.jpg"
        ]
        
        tableView.tableHeaderView = header
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell.init(style: .default, reuseIdentifier: "cell")
        cell.textLabel?.text = "\(indexPath.row)"
        return cell
    }
    

}



