//
//  Errors.swift
//  SharedLiving2
//
//  Created by Yang Peng on 16/9/2026.
//

import Foundation

import Foundation

enum RecordSEError: Error, LocalizedError {
    case invalidAmount
    case noExpenseShares
    case invalidSharePortions

    var errorDescription: String? {
        switch self {
        case .invalidAmount:
            return "The expense amount must be greater than $0."

        case .noExpenseShares:
            return "Please select at least one housemate to share this expense."

        case .invalidSharePortions:
            return "Each selected housemate must have at least one portion."
        }
    }
}
