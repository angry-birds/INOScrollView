//
//  ViewController.swift
//  INOScrollViewDemo
//
//  Created by angrybirds on 2017/4/10.
//  Copyright © 2017年 YuanMedia. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    let dataArray = ["xib实现", "纯代码实现"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        edgesForExtendedLayout = UIRectEdge(rawValue: 0)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath {
        case IndexPath(row: 0, section: 0):
            self.performSegue(withIdentifier: "toNibVC", sender: self)
        case IndexPath(row: 1, section: 0):
            self.performSegue(withIdentifier: "toCodeVC", sender: self)
        default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell.init(style: .default, reuseIdentifier: "cell")

        cell.textLabel?.text = dataArray[indexPath.row]
        return cell
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
}

