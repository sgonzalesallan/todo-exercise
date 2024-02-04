//
//  FileManagerHelper.swift
//  todo-exercise
//
//  Created by Allan Gonzales on 2/1/24.
//

import Foundation

class FileManagerHelper {
    static let shared = FileManagerHelper()

    private init() {}

    private let todosFilePath: URL = {
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            fatalError("no directory.")
        }
        return documentsDirectory.appendingPathComponent("todos.json")
    }()

    func save(_ todos: [Todo]) {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(todos)
            try data.write(to: todosFilePath)
        } catch {
            print("Error saving todos to file: \(error)")
        }
    }
    
    func add(todo: Todo) {
        var todos = getTodoList()
        todos.append(todo)
        save(todos)
    }
    
    func getTodoList() -> [Todo] {
        do {
            let data = try Data(contentsOf: todosFilePath)
            let decoder = JSONDecoder()
            let todos = try decoder.decode([Todo].self, from: data)
            return todos
        } catch {
            print("Error loading todos from file: \(error)")
            return []
        }
    }
}
