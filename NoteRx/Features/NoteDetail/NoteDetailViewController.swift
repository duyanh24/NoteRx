//
//  NoteDetailViewController.swift
//  NoteRx
//
//  Created by AnhLD on 9/17/20.
//  Copyright © 2020 AnhLD. All rights reserved.
//

import UIKit

class NoteDetailViewController: BaseViewController, ViewModelBased {
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var contentTextView: UITextView!
    
    var viewModel: NoteDetailViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func setupUI() {
        super.setupUI()
        setupBarButton()
    }
    
    private func setupBarButton() {
        let saveBarButton = UIBarButtonItem(title: StringConstants.save, style: .plain, target: self, action: #selector(saveNoteButtonClicked))
        navigationItem.rightBarButtonItem = saveBarButton
        navigationItem.title = StringConstants.noteDetail
    }
    
    @objc func saveNoteButtonClicked() {
        guard let title = titleTextField.text, title != "" else {
            self.showToast(message : "Chưa nhập chủ đề ")
            return
        }
//        guard let note = note else {
//            NoteRealmService.share.addNote(note: Note(title: title, content: contentTextView.text ?? ""))
//            navigationController?.popViewController(animated: true)
//            return
//        }
        let newNote = Note(id: 0, title: title, content: contentTextView.text ?? "", date: "")
        let newNoteObject = NoteRealmObject(note: newNote)
        newNoteObject.addNote()
        navigationController?.popViewController(animated: true)
    }
}
