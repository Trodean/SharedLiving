//
//  Views.swift
//  SharedLiving2
//
//  Created by Yang Peng on 15/9/2026.
//

import SwiftUI

struct HouseholdDashboardView: View{
    let housemates = [
        Housemate(id:UUID(), name: "Phoebe"),
        Housemate(id: UUID(), name: "Jason"),
        Housemate(id: UUID(), name: "Yang"),
        Housemate(id:UUID(), name: "Luna"),
    ]
    
    var body: some View{
        NavigationStack{
            List {
                Section("Housemates") {
                    ForEach(housemates) {housemate in
                        Text(housemate.name)
                    }
                }
                Section("Recent Expense") {
                    Text("Groceries - $60.00")
                }
                
                Section("Upcoming Chore") {
                    Text("Kitchen Cleaning - Alex")
                }
            }
            .navigationTitle("Shared Living")
        }
    }
}
