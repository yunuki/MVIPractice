//
//  MVIContainer.swift
//  MVIPractice
//
//  Created by 윤재욱 on 2023/09/03.
//

import Combine
import SwiftUI

class MVIContainer<Intent, Model>: ObservableObject {
    
    let intent: Intent
    let model: Model
    
    private var cancelBag: Set<AnyCancellable> = []
    
    init(intent: Intent, model: Model, modelChangePublisher: ObjectWillChangePublisher) {
        self.intent = intent
        self.model = model
        
        modelChangePublisher
            .receive(on: RunLoop.main)
            .sink(receiveValue: objectWillChange.send)
            .store(in: &cancelBag)
    }
}
