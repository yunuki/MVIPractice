//
//  ContentView.swift
//  MVIPractice
//
//  Created by 윤재욱 on 2023/09/02.
//

import SwiftUI

struct ContentView: View {
    @StateObject var container: MVIContainer<NumberFactIntent, NumberFactModel>
    
    private var model: NumberFactModelStateProtocol {
        return container.model
    }
    
    private var intent: NumberFactIntentProtocol {
        return container.intent
    }
    
    var body: some View {
        
        let hasNumberFact = Binding<Bool>(
            get: { model.numberFact != nil },
            set: { _ in }
        )
        
        VStack {
            HStack {
                Button("-") { intent.decreteButtonTapped() }
                Text("\(model.count)")
                Button("+") { intent.increteButtonTapped() }
            }
            Button("Number fact") { intent.numberFactButtonTapped() }
                .alert(Text(model.numberFact ?? ""),
                       isPresented: hasNumberFact,
                       actions: { Button("OK") { intent.dismissNumberFactAlert() } })
        }
    }
}

extension ContentView {
    static func build() -> some View {
        let model = NumberFactModel()
        let intent = NumberFactIntent(model: model,
                                      service: NumberFactService())
        let container = MVIContainer(intent: intent,
                                     model: model,
                                     modelChangePublisher: model.objectWillChange)
        return ContentView(container: container)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView.build()
    }
}
