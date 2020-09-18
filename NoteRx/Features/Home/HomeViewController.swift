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
import RealmSwift

class HomeViewController: BaseViewController, ViewModelBased {
    @IBOutlet weak var noteTableView: UITableView!
    
    var viewModel: HomeViewModel!
    let disposeBag = DisposeBag()
    private var notificationToken: NotificationToken?
    private let addBarButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupObserver()
        bindViewModelData()
        handleAction()
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
        
        noteTableView.rx.itemSelected.subscribe(onNext: { [weak self] (indexPath) in
            guard let self = self, self.viewModel.listNote.value.indices.contains(indexPath.row) else {
                return
            }
            let noteDetailViewModel = NoteDetailViewModel(note: self.viewModel.listNote.value[indexPath.row])
            guard let noteDetailViewController = NoteDetailViewController.instantiate(withViewModel: noteDetailViewModel) else {
                return
            }
            self.navigationController?.pushViewController(noteDetailViewController, animated: true)
        }).disposed(by: disposeBag)
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
        navigationItem.rightBarButtonItem = addBarButton
        navigationItem.title = StringConstants.noteTitle
    }
    
    private func setupObserver() {
        let realm = try! Realm()
        notificationToken = realm.objects(NoteRealmObject.self).observe({ [weak self] _ in
            self?.viewModel.getAllNote()
        })
    }
    
    private func handleAction() {
        addBarButton.rx.tap.subscribe(onNext: { [weak self] _ in
            guard let self = self else {
                return
            }
            let noteDetailViewModel = NoteDetailViewModel(note: nil)
            guard let noteDetalViewController = NoteDetailViewController.instantiate(withViewModel: noteDetailViewModel) else {
                return
            }
            self.navigationController?.pushViewController(noteDetalViewController, animated: true)
        }).disposed(by: disposeBag)
    }
}
