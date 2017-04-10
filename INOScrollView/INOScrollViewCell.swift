//
//  INOScrollViewCell.swift
//  StaffSigning
//
//  Created by angrybirds on 2017/4/7.
//  Copyright © 2017年 YuanMedia. All rights reserved.
//

import UIKit

class INOScrollViewCell: UICollectionViewCell {
    
    
    var imageView: UIImageView!
    var titleLabel: UILabel!
    
    
    /// 是否显示Label
    var showTextLabel: Bool = false{
        
        didSet{
            if !showTextLabel {
                self.titleLabel.isHidden = true
            }else{
                self.titleLabel.isHidden = false
            }
        }
        
    }
    
    /// 文本框的高度
    var titleLabelHeight: CGFloat = 30.0 {
        didSet{
            titleLabel.frame = CGRect.init(x: 0, y: frame.size.height - self.titleLabelHeight, width: frame.size.width, height: self.titleLabelHeight)
        }
    }
    
    /// 文字的大小
    var titleLabelFont: UIFont = UIFont.systemFont(ofSize: 14) {
        didSet{
            titleLabel.font = self.titleLabelFont
        }
    }
    
    /// Label的颜色
    var titleLabelColor: UIColor = UIColor(red: 200/255.0, green: 200/255.0, blue: 200/255.0, alpha: 0.5) {
        didSet{
            titleLabel.backgroundColor = self.titleLabelColor
        }
    }
    
    /// 文字的颜色
    var titleLabelTextColor: UIColor = UIColor.white {
        didSet{
            titleLabel.textColor = self.titleLabelTextColor
        }
    }
    
    /// 图片的ContentModel
    var INOScrollViewContentMode: UIViewContentMode = .scaleAspectFill {
        didSet{
            imageView.contentMode = self.INOScrollViewContentMode
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height))
        imageView.clipsToBounds = true
        imageView.contentMode = INOScrollViewContentMode
        addSubview(imageView)
        
        titleLabel = UILabel(frame: CGRect(x: 0, y: imageView.frame.height - 40, width: frame.size.width, height: 40))
        titleLabel.text = ""
        addSubview(titleLabel)
        
        print(titleLabel.frame)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
