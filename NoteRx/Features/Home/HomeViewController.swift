//
//  HomeViewController.swift
//  NoteRx
//
//  Created by AnhLD on 9/17/20.
//  Copyright © 2020 AnhLD. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class HomeViewController: BaseViewController, ViewModelBased {
    @IBOutlet weak var noteTableView: UITableView!
    
    var viewModel: HomeViewModel!
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModelData()
        viewModel.getAllNote()
    }
    
    private func bindViewModelData() {
        viewModel.listNote.bind(to: noteTableView.rx.items) { tableView, row, element in
            let cell = UITableViewCell(style: .default, reuseIdentifier:"cell")
            cell.textLabel?.text = element.title
            return cell
        }.disposed(by: disposeBag)
    }
}
