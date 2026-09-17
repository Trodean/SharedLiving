//
//  PChoreRepo.swift
//  SharedLiving2
//
//  Created by Yang Peng on 17/9/2026.
//

import Foundation

final class PChoreRepo: ChoreRepo {
    private var chores:[Chore] = []
    
    private var fileURL: URL {
        FileManager.default
            .urls(for: .documentDirectory, in: .userDomainMask)[0]
            .appendingPathComponent("chore.json")
    }
    
    init() {
        loadChores()
    }
    
    func addChore(_ chore:Chore) {
        chores.append(chore)
        saveChores()
    }
    
    func updateChore(_ chore: Chore) {
        guard let index = chores.firstIndex(where: {
            $0.id == chore.id
        }) else {
            return
        }
        chores[index] = chore
        saveChores()
    }
    func getAllChores() -> [Chore] {
        chores
    }
    
    private func saveChores() {
        do {
            let data = try JSONEncoder().encode(chores)
            try data.write(to: fileURL)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func loadChores() {
        do {
            let data = try Data(contentsOf: fileURL)
            chores = try JSONDecoder().decode(
                [Chore].self, from: data
            )
        } catch {
            chores = []
        }
    }
}
