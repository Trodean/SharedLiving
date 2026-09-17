//
//  CompleteChoreUseCase.swift
//  SharedLiving2
//
//  Created by Yang Peng on 16/9/2026.
//

import Foundation

struct CompleteChoreUseCase {

    private let repository: any ChoreRepo

    init(repository: any ChoreRepo) {
        self.repository = repository
    }

    func execute(_ chore: Chore) throws -> Chore {
        guard !chore.isCompleted else {
            throw CompleteChoreError.alreadyCompleted
        }

        var completedChore = chore
        completedChore.isCompleted = true

        repository.updateChore(completedChore)

        return completedChore
    }
}
