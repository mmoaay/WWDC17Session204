//
//  TitleView.swift
//  WWDC17Seesion204Sample
//
//  Created by Elaine on 2017/7/31.
//  Copyright © 2017年 Stella. All rights reserved.
//

import UIKit

class TitleView: UIView {

    @IBOutlet var contentView: UIView!
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        Bundle(for: self.classForCoder).loadNibNamed("TitleView", owner: self, options: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
