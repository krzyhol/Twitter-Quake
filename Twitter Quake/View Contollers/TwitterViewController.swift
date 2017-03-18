//
//  TwitterViewController.swift
//  Twitter Quake
//
//  Created by AppStarter on 05.03.2017.
//  Copyright © 2017 Krzysztof Hołtyn. All rights reserved.
//

import UIKit

final class TwitterViewController: UIViewController {

    @IBOutlet private weak var label: UILabel!
    
    var number: Int?
    
    override func viewWillAppear(_ animated: Bool) {
        if let number = number {
            label.text = String(number)
        }
    }
}
