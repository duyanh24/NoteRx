//
//  NoteDetailViewController.swift
//  NoteRx
//
//  Created by AnhLD on 9/17/20.
//  Copyright © 2020 AnhLD. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class NoteDetailViewController: BaseViewController, ViewModelBased {
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var contentTextView: UITextView!
    
    private let saveBarButton = UIBarButtonItem(title: StringConstants.save, style: .plain, target: self, action: nil)
    var viewModel: NoteDetailViewModel!
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setupUI() {
        super.setupUI()
        setupBarButton()
        setupInitData()
        bindData()
        handleAction()
    }
    
    private func setupBarButton() {
        navigationItem.rightBarButtonItem = saveBarButton
        navigationItem.title = StringConstants.noteDetail
    }
    
    private func setupInitData() {
        titleTextField.text = viewModel.note.title
        contentTextView.text = viewModel.note.content
    }
    
    private func bindData() {
        titleTextField.rx.text.subscribe(onNext: { [weak self] (noteTitle) in
            guard let self = self else {
                return
            }
            guard let noteTitleNotNil = noteTitle else {
                self.saveBarButton.isEnabled = false
                return
            }
            self.viewModel.note.title = noteTitleNotNil
        }).disposed(by: disposeBag)
        
        titleTextField.rx.text
            .map { !$0.isNilOrEmpty }
            .bind(to: saveBarButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        contentTextView.rx.text.subscribe(onNext: { [weak self] (noteContent) in
            guard let self = self, let noteContent = noteContent else {
                return
            }
            self.viewModel.note.content = noteContent
        }).disposed(by: disposeBag)
    }
    
    private func handleAction() {
        saveBarButton.rx.tap.subscribe(onNext: { [weak self] _ in
            guard let self = self else {
                return
            }
            let editNoteObject = NoteRealmObject(note: self.viewModel.note)
            editNoteObject.addNote()
            self.navigationController?.popViewController(animated: true)
        }).disposed(by: disposeBag)
    }
}
