//
//  ContentView.swift
//  SharedLiving2
//
//  Created by Yang Peng on 15/9/2026.
//

import SwiftUI

struct ContentView: View {

    @StateObject private var expenseViewModel: EViewModel
    @StateObject private var choreViewModel: ChoreViewModel

    init() {
        let expenseRepo = PSERepo()
        let expenseUseCase = RecordUseCases(
            repository: expenseRepo
        )

        let choreRepo = PChoreRepo()

        let assignChoreUseCase = AHCUseCase(
            repository: choreRepo
        )

        let completeChoreUseCase = CompleteChoreUseCase(
            repository: choreRepo
        )

        _expenseViewModel = StateObject(
            wrappedValue: EViewModel(
                recordUseCase: expenseUseCase
            )
        )

        _choreViewModel = StateObject(
            wrappedValue: ChoreViewModel(
                assignUseCase: assignChoreUseCase,
                completeUseCase: completeChoreUseCase
            )
        )
    }

    var body: some View {
        MainTabView(
            expenseViewModel: expenseViewModel,
            choreViewModel: choreViewModel
        )
    }
}

#Preview {
    ContentView()
}
