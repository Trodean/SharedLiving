//
//  CompleteChoreError.swift
//  SharedLiving2
//
//  Created by Yang Peng on 16/9/2026.
//

import Foundation

enum CompleteChoreError: Error, LocalizedError {
    case alreadyCompleted

    var errorDescription: String? {
        switch self {
        case .alreadyCompleted:
            return "This chore has already been completed."
        }
    }
}
