//
//  Date+Extension.swift
//  NoteRx
//
//  Created by AnhLD on 9/17/20.
//  Copyright © 2020 AnhLD. All rights reserved.
//

import Foundation

extension Date {
    func convertDateToString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = StringConstants.dateFormat
        return formatter.string(from: self)
    }
}
