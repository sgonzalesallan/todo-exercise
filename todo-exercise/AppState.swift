//
//  TodoListState.swift
//  todo-exercise
//
//  Created by Allan Gonzales on 2/1/24.
//

import Foundation
import ReSwift

struct AppState {
    
    var todoList: [Todo] = []
    
    var page: PageType = .list
    
    init() {}
    
}

enum PageType {
    case list, addTodo, editTodo
}
