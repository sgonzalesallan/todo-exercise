//
//  TodoReducer.swift
//  todo-exercise
//
//  Created by Allan Gonzales on 2/4/24.
//

import ReSwift


func appReducer(action: Action, state: AppState?) -> AppState {
    var state = state ?? AppState()

    switch action {
    case _ as ReSwiftInit:
        state.todoList = FileManagerHelper.shared.getTodoList()
    case let action as AddTodo:
        state.todoList.append(action.todo)
        FileManagerHelper.shared.save(state.todoList)
    case let action as DeleteTodo:
        state.todoList.remove(atOffsets: action.indexSet)
        FileManagerHelper.shared.save(state.todoList)
    case let action as UpdateTodo:
        state.todoList.removeAll { $0.id == action.todo.id }
        state.todoList.append(action.todo)
        FileManagerHelper.shared.save(state.todoList)
    case let action as ChangePageTodo:
        state.page = action.pageType
    default:
        break
    }

    return state
}
