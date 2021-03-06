//
//  BaseViewController.swift
//  NoteRx
//
//  Created by AnhLD on 9/17/20.
//  Copyright © 2020 AnhLD. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        navigationController?.navigationBar.isTranslucent = false
    }
}
