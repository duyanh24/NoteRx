//
//  NoteRealmObject.swift
//  NoteRx
//
//  Created by AnhLD on 9/17/20.
//  Copyright © 2020 AnhLD. All rights reserved.
//

import Foundation
import RealmSwift

class NoteRealmObject: Object {
    @objc dynamic var id = 0
    @objc dynamic var title = ""
    @objc dynamic var content = ""
    @objc dynamic var date = Date()
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
    convenience init(id: Int, title: String, content: String, date: Date = Date()) {
        self.init()
        self.id = id
        self.title = title
        self.content = content
        self.date = date
    }
    
    convenience init(note: Note) {
        self.init()
        self.id = note.id
        self.title = note.title
        self.content = note.content
    }
    
    static func getAllNote() -> [Note] {
        do {
            let realm = try Realm()
            let results = realm.objects(NoteRealmObject.self).sorted(byKeyPath: "date", ascending: false)
            return Array(results.map { Note(noteRealmObject: $0) })
        } catch {
            return []
        }
    }
    
    static func getIdMax() -> Int {
        do {
            let realm = try Realm()
            return realm.objects(NoteRealmObject.self).map { $0.id }.max() ?? 0
        } catch {
            return 0
        }
    }
    
    static func getNoteById(id: Int) -> Note? {
        do {
            let realm = try Realm()
            guard let noteObject = realm.object(ofType: NoteRealmObject.self, forPrimaryKey: id) else {
                return nil
            }
            return Note(noteRealmObject: noteObject)
        } catch {
            return nil
        }
    }
    
    func updateNote(title: String, content: String) {
        do {
            let realm = try Realm()
            try realm.write {
                guard let noteObject = realm.object(ofType: NoteRealmObject.self, forPrimaryKey: id) else {
                    return
                }
                noteObject.title = title
                noteObject.content = content
                let newNoteObject = realm.create(NoteRealmObject.self, value: noteObject, update: .all)
                realm.add(newNoteObject)
            }
        } catch let error {
            print(error)
        }
    }
    
    func deleteNote() {
        do {
            let realm = try Realm()
            if let noteObject = realm.object(ofType: NoteRealmObject.self, forPrimaryKey: id) {
                try! realm.write {
                    realm.delete(noteObject)
                }
            }
        } catch {
            
        }
    }
}
