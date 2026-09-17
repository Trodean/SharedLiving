//
//  Chore.swift
//  SharedLiving2
//
//  Created by Yang Peng on 15/9/2026.
//

import Foundation

struct Chore:  Identifiable, Codable {
    let id: UUID
    let title: String
    let assignee: Housemate
    let dueDate: Date
    var isCompleted: Bool
}
