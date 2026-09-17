//
//  TheTests.swift
//  SharedLiving2
//
//  Created by Yang Peng on 16/9/2026.
//

import XCTest
@testable import SharedLiving2

final class TheTests: XCTestCase {

    func testValidExpenseIsRecorded() throws {
        let repository = InMemorySERepository()
        let useCase = RecordUseCases(repository: repository)

        let yang = Housemate(
            id: UUID(),
            name: "Yang"
        )

        let shares = [
            Shares(
                housemate: yang,
                portions: 1
            )
        ]

        let expense = SharedExpenses(
            id: UUID(),
            title: "Groceries",
            amount: 60,
            category: .groceries,
            payer: yang,
            shares: shares,
            date: Date()
        )

        try useCase.execute(expense)

        XCTAssertEqual(
            repository.getAllexpenses().count,
            1
        )
    }

    func testInvalidAmountThrowsError() {
        let repository = InMemorySERepository()
        let useCase = RecordUseCases(repository: repository)

        let yang = Housemate(
            id: UUID(),
            name: "Yang"
        )

        let shares = [
            Shares(
                housemate: yang,
                portions: 1
            )
        ]

        let expense = SharedExpenses(
            id: UUID(),
            title: "Groceries",
            amount: 0,
            category: .groceries,
            payer: yang,
            shares: shares,
            date: Date()
        )

        XCTAssertThrowsError(
            try useCase.execute(expense)
        ) { error in
            guard case RecordSEError.invalid_amount = error else {
                XCTFail("Expected invalidAmount error")
                return
            }
        }
    }

    func testInvalidPortionsThrowsError() {
        let repository = InMemorySERepository()
        let useCase = RecordUseCases(repository: repository)

        let yang = Housemate(
            id: UUID(),
            name: "Yang"
        )

        let shares = [
            Shares(
                housemate: yang,
                portions: 0
            )
        ]

        let expense = SharedExpenses(
            id: UUID(),
            title: "Internet",
            amount: 80,
            category: .internet,
            payer: yang,
            shares: shares,
            date: Date()
        )

        XCTAssertThrowsError(
            try useCase.execute(expense)
        ) { error in
            guard case RecordSEError.invalid_share_portions = error else {
                XCTFail("Expected invalidSharePortions error")
                return
            }
        }
    }
    func testValidChoreIsAssigned() throws {
        let repository = InMemoryChoreRepo()
        let useCase = AHCUseCase(repository: repository)

        let yang = Housemate(
            id: UUID(),
            name: "Yang"
        )

        let chore = Chore(
            id: UUID(),
            title: "Clean Kitchen",
            assignee: yang,
            dueDate: Date(),
            isCompleted: false
        )

        try useCase.execute(chore)

        XCTAssertEqual(
            repository.getAllChores().count,
            1
        )
    }

    func testEmptyChoreTitleThrowsError() {
        let repository = InMemoryChoreRepo()
        let useCase = AHCUseCase(repository: repository)

        let yang = Housemate(
            id: UUID(),
            name: "Yang"
        )

        let chore = Chore(
            id: UUID(),
            title: "",
            assignee: yang,
            dueDate: Date(),
            isCompleted: false
        )

        XCTAssertThrowsError(
            try useCase.execute(chore)
        ) { error in
            guard case AssignChoreError.emptyTitle = error else {
                XCTFail("Expected emptyTitle error")
                return
            }
        }
    }

    func testPastDueDateThrowsError() {
        let repository = InMemoryChoreRepo()
        let useCase = AHCUseCase(repository: repository)

        let yang = Housemate(
            id: UUID(),
            name: "Yang"
        )

        let yesterday = Calendar.current.date(
            byAdding: .day,
            value: -1,
            to: Date()
        )!

        let chore = Chore(
            id: UUID(),
            title: "Clean Bathroom",
            assignee: yang,
            dueDate: yesterday,
            isCompleted: false
        )

        XCTAssertThrowsError(
            try useCase.execute(chore)
        ) { error in
            guard case AssignChoreError.invalidDueDate = error else {
                XCTFail("Expected invalidDueDate error")
                return
            }
        }
    }

    func testIncompleteChoreCanBeCompleted() throws {
        let repository = InMemoryChoreRepo()
        let useCase = CompleteChoreUseCase(repository: repository)

        let yang = Housemate(
            id: UUID(),
            name: "Yang"
        )

        let chore = Chore(
            id: UUID(),
            title: "Take Out Rubbish",
            assignee: yang,
            dueDate: Date(),
            isCompleted: false
        )

        repository.addChore(chore)

        let completedChore = try useCase.execute(chore)

        XCTAssertTrue(completedChore.isCompleted)
    }

    func testCompletedChoreCannotBeCompletedAgain() {
        let repository = InMemoryChoreRepo()
        let useCase = CompleteChoreUseCase(repository: repository)

        let yang = Housemate(
            id: UUID(),
            name: "Yang"
        )

        let chore = Chore(
            id: UUID(),
            title: "Take Out Rubbish",
            assignee: yang,
            dueDate: Date(),
            isCompleted: true
        )

        XCTAssertThrowsError(
            try useCase.execute(chore)
        ) { error in
            guard case CompleteChoreError.alreadyCompleted = error else {
                XCTFail("Expected alreadyCompleted error")
                return
            }
        }
    }
}


