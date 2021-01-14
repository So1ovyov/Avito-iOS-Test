//
//  ViewController.swift
//  Test
//
//  Created by Максим Соловьёв on 14.01.2021.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray
        
        let data = DataLoader().welcome
        print(data)
    }

}

