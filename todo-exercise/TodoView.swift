//
//  ContentView.swift
//  todo-exercise
//
//  Created by Allan Gonzales on 2/1/24.
//

import SwiftUI
import ReSwift


struct TodoView: View {
    
    @ObservedObject private var storeWrapper: StoreWrapper
    
    @State private var textDetail = ""
    @State private var selectedTodoId: String = ""

    init() {
        self.storeWrapper = StoreWrapper(store: StoreProvider.shared.store)
    }
    
    var body: some View {
        NavigationView {
            getContent(pageType: self.storeWrapper.state.page)
        }
        
    }
    
    @ViewBuilder func getDetailView(pageType: PageType) -> some View {
        VStack(alignment: .leading) {
            
            Text(pageType == .addTodo ? "Add Todo" : "Update Todo")
                .font(.system(size: 24, weight: .bold, design: .default))
            TextField("Text...",
                      text: $textDetail)
                .autocapitalization(.none)
                .disableAutocorrection(true)
                .padding(.top, 20)
            Divider()
            Button(
                action: {
                    if pageType == .addTodo {
                        addTodo()
                    } else {
                        updateTodo()
                    }
                }, label: {
                    Text(pageType == .addTodo ? "Add" : "Update")
                    .font(.system(size: 16, weight: .bold, design: .default))
                    .frame(maxWidth: .infinity, maxHeight: 40)
                    .foregroundColor(Color.white)
                    .background(Color.blue)
                    .cornerRadius(10)
                }
                
            ).padding(.top, 20)
                .opacity(textDetail.isEmpty ? 0.5 : 1.0)
                .disabled(textDetail.isEmpty)
            Button(
                action: {
                    textDetail = ""
                    changePage(pageType: .list)
                }, label: {
                    Text("Cancel")
                    .font(.system(size: 16, weight: .bold, design: .default))
                    .frame(maxWidth: .infinity, maxHeight: 40)
                    .foregroundColor(Color.black)
                    .cornerRadius(10)
                }
            ).padding(.top, 20)
            Spacer()
        }
        .padding(30)
    }
    
    @ViewBuilder func getContent(pageType: PageType) -> some View {
        switch pageType {
        case .list:
            VStack {
                List {
                    ForEach(storeWrapper.state.todoList, id: \.id) { todo in
                        Text(todo.text)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .onTapGesture {
                                selectedTodoId = todo.id
                                textDetail = todo.text
                                changePage(pageType: .editTodo)
                            }
                    }
                    .onDelete(perform: deleteTodo)
                }
                .overlay(Group {
                    if storeWrapper.state.todoList.isEmpty {
                        VStack {
                            Image(systemName: "pencil.circle")
                                .resizable()
                                .frame(width: 100, height: 100)
                                .opacity(0.2)
                            Text("No list found")
                                .opacity(0.5)
                        }
                    }
                })
            }
            .navigationTitle("To do")
            .toolbar {
                Button {
                    changePage(pageType: .addTodo)
                } label: {
                    Image(systemName: "plus")
                }
            }
        case .addTodo, .editTodo:
            getDetailView(pageType: pageType)
        }
    }
    
    func addTodo() {
        let todo = Todo(id: UUID().uuidString, text: textDetail)
        storeWrapper.store.dispatch(AddTodo(todo: todo))
        textDetail = ""
        changePage(pageType: .list)
    }
    
    func editTodo() {
        let todo = Todo(id: UUID().uuidString, text: textDetail)
        storeWrapper.store.dispatch(AddTodo(todo: todo))
        textDetail = ""
        changePage(pageType: .list)
    }
    
    func updateTodo() {
        guard let todo = storeWrapper.state.todoList.filter({ $0.id == selectedTodoId }).first else { return }
        storeWrapper.store.dispatch(UpdateTodo(todo: todo))
        textDetail = ""
        changePage(pageType: .list)
    }
    
    func deleteTodo(at offsets: IndexSet) {
        storeWrapper.store.dispatch(DeleteTodo(indexSet: offsets))
    }
    
    func changePage(pageType: PageType) {
        storeWrapper.store.dispatch(ChangePageTodo(pageType: pageType))
    }
}
