//
//  NoteDetailViewModel.swift
//  NoteRx
//
//  Created by AnhLD on 9/17/20.
//  Copyright © 2020 AnhLD. All rights reserved.
//

import Foundation

class NoteDetailViewModel: ViewModel {
    var note: Note?
    
    init(note: Note?) {
        self.note = note
    }
}
