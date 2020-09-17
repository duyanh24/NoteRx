//
//  SplashViewController.swift
//  NoteRx
//
//  Created by AnhLD on 9/17/20.
//  Copyright © 2020 AnhLD. All rights reserved.
//

import UIKit

class SplashViewController: BaseViewController, ViewModelBased {

    var viewModel: SplashViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        naviagteToHomeScreen()
    }
    
    private func naviagteToHomeScreen() {
        let homeViewModel = HomeViewModel()
        let homeViewController = HomeViewController.instantiate(withViewModel: homeViewModel)
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            appDelegate.window?.rootViewController = homeViewController
        }
    }
}
