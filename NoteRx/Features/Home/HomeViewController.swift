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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModelData()
        viewModel.getAllNote()
        setupObserver()
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
        noteTableView.delegate = self
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
    
    private func setupObserver() {
        let realm = try! Realm()
        notificationToken = realm.objects(NoteRealmObject.self).observe({ [weak self] _ in
            self?.viewModel.getAllNote()
        })
    }
    
    @objc private func addNoteButtonClicked() {
        let noteDetailViewModel = NoteDetailViewModel(note: nil)
        guard let noteDetalViewController = NoteDetailViewController.instantiate(withViewModel: noteDetailViewModel) else {
            return
        }
        navigationController?.pushViewController(noteDetalViewController, animated: true)
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard viewModel.listNote.value.indices.contains(indexPath.row) else {
            return
        }
        let noteDetailViewModel = NoteDetailViewModel(note: viewModel.listNote.value[indexPath.row])
        guard let noteDetailViewController = NoteDetailViewController.instantiate(withViewModel: noteDetailViewModel) else {
            return
        }
        navigationController?.pushViewController(noteDetailViewController, animated: true)
    }
}
