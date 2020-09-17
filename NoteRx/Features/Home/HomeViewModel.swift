//
//  HomeViewModel.swift
//  NoteRx
//
//  Created by AnhLD on 9/17/20.
//  Copyright © 2020 AnhLD. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class HomeViewModel: ViewModel {
    let listNote = PublishRelay<[Note]>()
    
    func getAllNote() {
        let notes = NoteRealmObject.getAllNote()
        listNote.accept(notes)
    }
}
