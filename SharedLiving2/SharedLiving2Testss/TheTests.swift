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
            repository.getAllExpenses().count,
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
            guard case RecordSEError.invalidAmount = error else {
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
            guard case RecordSEError.invalidSharePortions = error else {
                XCTFail("Expected invalidSharePortions error")
                return
            }
        }
    }
}
