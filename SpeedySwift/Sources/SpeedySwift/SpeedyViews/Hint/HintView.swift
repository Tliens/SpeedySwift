//
//  HintView.swift
//  SpeedySwift
//
//  Created by Quinn Von on 2020/4/29.
//  Copyright © 2020 Quinn Von. All rights reserved.
//

import Foundation
import UIKit

public class HintView:UIView{
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var title: UILabel!
    
    public override func awakeFromNib() {
        layer.shadowColor = Color.init(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        layer.shadowOffset = CGSize(width: 0, height: 14)
        layer.shadowRadius = 30
        layer.shadowOpacity = 1.0
        containerView.layer.masksToBounds = true
        containerView.layer.cornerRadius = 10
    }
    
}
