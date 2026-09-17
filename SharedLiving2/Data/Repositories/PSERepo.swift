//
//  PSERepo.swift
//  SharedLiving2
//
//  Created by Yang Peng on 17/9/2026.
//

import Foundation

// Stores shared expense records in a local JSON file so the data remains available after the app is reopened. It loads saved expenses when the repository is created and writes updates whenever a new expense is added.
final class PSERepo: SERepository {

    private var expenses: [SharedExpenses] = []

    private var fileURL: URL {
        FileManager.default
            .urls(for: .documentDirectory, in: .userDomainMask)[0]
            .appendingPathComponent("expenses.json")
    }

    init() {
        loadExpenses()
    }

    func addExpenses(_ expense: SharedExpenses) {
        expenses.append(expense)
        saveExpenses()
    }

    func getAllexpenses() -> [SharedExpenses] {
        expenses
    }

    private func saveExpenses() {
        do {
            let data = try JSONEncoder().encode(expenses)
            try data.write(to: fileURL)
        } catch {
            print(error.localizedDescription)
        }
    }

    private func loadExpenses() {
        do {
            let data = try Data(contentsOf: fileURL)

            expenses = try JSONDecoder().decode(
                [SharedExpenses].self,
                from: data
            )
        } catch {
            expenses = []
        }
    }
}
