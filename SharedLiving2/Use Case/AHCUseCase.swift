//
//  AHCUseCase.swift
//  SharedLiving2
//
//  Created by Yang Peng on 16/9/2026.
//

import Foundation

struct AHCUseCase {

    private let repository: any ChoreRepo

    init(repository: any ChoreRepo) {
        self.repository = repository
    }

    func execute(_ chore: Chore) throws {
        guard !chore.title
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .isEmpty else {
            throw AssignChoreError.emptyTitle
        }

        guard chore.dueDate >= Calendar.current.startOfDay(for: Date()) else {
            throw AssignChoreError.invalidDueDate
        }

        repository.addChore(chore)
    }
    func getAllChores() -> [Chore] {
        repository.getAllChores()
    }
}
