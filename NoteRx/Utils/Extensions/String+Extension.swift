//
//  String+Extension.swift
//  NoteRx
//
//  Created by AnhLD on 9/18/20.
//  Copyright © 2020 AnhLD. All rights reserved.
//

import Foundation

extension Optional where Wrapped == String {
    var isNilOrEmpty: Bool {
        return self == nil || self == ""
    }
}
