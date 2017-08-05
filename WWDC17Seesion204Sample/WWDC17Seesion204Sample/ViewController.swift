//
//  ViewController.swift
//  WWDC17Seesion204Sample
//
//  Created by Elaine on 2017/7/30.
//  Copyright © 2017年 Stella. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationItem.titleView = TitleView(frame:.zero).contentView
        
        if #available(iOS 11.0, *) {
            self.view.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 10, leading: 100, bottom: 10, trailing: 0)
            self.viewRespectsSystemMinimumLayoutMargins = false
        } else {
            // Fallback on earlier versions
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

