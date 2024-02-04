//
//  StoreProvider.swift
//  todo-exercise
//
//  Created by Allan Gonzales on 2/4/24.
//

import ReSwift
import Combine

class StoreProvider {
    static let shared = StoreProvider()
    let store: Store<AppState>

    private init() {
        self.store = Store(
            reducer: appReducer,
            state: nil
        )
    }
}

class StoreWrapper: ObservableObject {
    @Published private(set) var state: AppState
    let store: Store<AppState>

    init(store: Store<AppState>) {
        self.state = store.state
        self.store = store

        store.subscribe(self)
    }
}

extension StoreWrapper: StoreSubscriber {
    func newState(state: AppState) {
        self.state = state
    }
}
