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
    
    init(noteRealmObject: NoteRealmObject) {
        self.id = noteRealmObject.id
        self.title = noteRealmObject.title
        self.content = noteRealmObject.content
    }
    
    init(id: Int, title: String, content: String) {
        self.id = id
        self.title = title
        self.content = content
    }
}
