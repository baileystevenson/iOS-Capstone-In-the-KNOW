//
//  DateFormatter.swift
//  IntheKnow1
//
//  Created by mac on 2/21/23.
//

import Foundation

extension DateFormatter {
    static let activityDate: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter
    }()
    static let time: DateFormatter = {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter
    }()
}
