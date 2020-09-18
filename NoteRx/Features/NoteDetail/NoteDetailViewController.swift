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
        setupData()
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
        guard var note = viewModel.note else {
            let newNote = Note(id: 0, title: title, content: contentTextView.text ?? "", date: "")
            let newNoteObject = NoteRealmObject(note: newNote)
            newNoteObject.addNote()
            navigationController?.popViewController(animated: true)
            return
        }
        
        note.title = title
        note.content = contentTextView.text ?? ""
        let editNoteObject = NoteRealmObject(note: note)
        editNoteObject.updateNote()
        navigationController?.popViewController(animated: true)
    }
    
    private func setupData() {
        titleTextField.text = viewModel.note?.title
        contentTextView.text = viewModel.note?.content
    }
}
