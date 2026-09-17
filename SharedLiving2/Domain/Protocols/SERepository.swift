//
//  Repository.swift
//  SharedLiving2
//
//  Created by Yang Peng on 16/9/2026.
//

import Foundation

protocol SERepository {
    func addExpenses(_ expense: SharedExpenses)
    func getAllexpenses() -> [SharedExpenses]
}
