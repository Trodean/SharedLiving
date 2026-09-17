//
//  AssignChoreError.swift
//  SharedLiving2
//
//  Created by Yang Peng on 16/9/2026.
//

import Foundation

enum AssignChoreError: Error, LocalizedError {
    case emptyTitle
    case invalidDueDate
    case missingAssignee

    var errorDescription: String? {
        switch self {
        case .emptyTitle:
            return "Please enter a name for the chore."

        case .invalidDueDate:
            return "The due date cannot be earlier than today."

        case .missingAssignee:
            return "Please select a housemate for this chore."
        }
    }
}
