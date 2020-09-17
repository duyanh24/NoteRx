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
        viewModel.listNote.bind(to: noteTableView.rx.items) { tableView, row, note in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "NoteTableViewCell", for: IndexPath(row: row, section: 0)) as? NoteTableViewCell else {
                return UITableViewCell()
            }
            cell.setupData(note: note)
            return cell
        }.disposed(by: disposeBag)
    }
    
    private func setupTableView() {
        noteTableView.register(UINib(nibName: "NoteTableViewCell", bundle: nil), forCellReuseIdentifier: "NoteTableViewCell")
    }
    
    override func setupUI() {
        super.setupUI()
        setupBarButton()
        setupTableView()
    }
    
    private func setupBarButton() {
        let addBarButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNoteButtonClicked))
        navigationItem.rightBarButtonItem = addBarButton
        navigationItem.title = StringConstants.noteTitle
    }
    
    @objc private func addNoteButtonClicked() {
    }
}
