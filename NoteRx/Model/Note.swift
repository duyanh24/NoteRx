//
//  Note.swift
//  NoteRx
//
//  Created by AnhLD on 9/17/20.
//  Copyright © 2020 AnhLD. All rights reserved.
//

import Foundation

struct Note {
    var id = -1
    var title = ""
    var content = ""
    var date = ""
    
    init(noteRealmObject: NoteRealmObject) {
        self.id = noteRealmObject.id
        self.title = noteRealmObject.title
        self.content = noteRealmObject.content
        self.date = noteRealmObject.date.convertDateToString()
    }
    
    init(id: Int, title: String, content: String, date: String) {
        self.id = id
        self.title = title
        self.content = content
        self.date = date
    }
}
