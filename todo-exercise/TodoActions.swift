//
//  TodoActions.swift
//  todo-exercise
//
//  Created by Allan Gonzales on 2/4/24.
//

import Foundation
import ReSwift

struct AddTodo: Action {
    let todo: Todo
}

struct UpdateTodo: Action {
    let todo: Todo
}

struct DeleteTodo: Action {
    
    let indexSet: IndexSet
}

struct EditTodo: Action {
    
    let todo: Todo
}

struct ChangePageTodo: Action {
    
    let pageType: PageType
}
