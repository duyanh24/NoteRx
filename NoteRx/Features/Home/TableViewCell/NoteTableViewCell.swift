//
//  NoteTableViewCell.swift
//  NoteRx
//
//  Created by AnhLD on 9/17/20.
//  Copyright © 2020 AnhLD. All rights reserved.
//

import UIKit

class NoteTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }
    
    func setupData(note: Note) {
        titleLabel.text = note.title
        dateLabel.text = note.date
    }
}
