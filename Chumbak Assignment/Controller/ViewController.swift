//
//  ViewController.swift
//  Chumbak Assignment
//
//  Created by GAURAV NAYAK on 06/07/19.
//  Copyright © 2019 CaffeineDevotee. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var profileImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.dropShadow(label: self.searchView)
        self.dropShadow(label: self.profileImageView)
    }
    
}

extension ViewController {
    func dropShadow(label: UIView) {
        label.layer.shadowColor = UIColor.gray.cgColor
        label.layer.shadowRadius = 6.0
        label.layer.shadowOpacity = 0.2
        label.layer.shadowOffset = CGSize(width: 4, height: 4)
        label.layer.masksToBounds = false
    }
}

