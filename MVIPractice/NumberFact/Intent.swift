//
//  Intent.swift
//  MVIPractice
//
//  Created by 윤재욱 on 2023/09/02.
//

import Foundation

protocol NumberFactIntentProtocol {
    func increteButtonTapped()
    func decreteButtonTapped()
    func numberFactButtonTapped()
    func dismissNumberFactAlert()
}

struct NumberFactIntent {
    private let model: NumberFactModelStateProtocol & NumberFactModelActionProtocol
    private let service: NumberFactServiceProtocol
    
    init(model: NumberFactModelStateProtocol & NumberFactModelActionProtocol, service: NumberFactServiceProtocol) {
        self.model = model
        self.service = service
    }
}

extension NumberFactIntent: NumberFactIntentProtocol {
    func increteButtonTapped() {
        model.increte()
    }
    
    func decreteButtonTapped() {
        model.decrete()
    }
    
    func numberFactButtonTapped() {
        Task(priority: .background) {
            do {
                let fact = try await service.getNumberFact(number: model.count)
                await MainActor.run(body: {
                    model.update(numberFact: fact)
                })
            } catch(let error) {
                await MainActor.run(body: {
                    model.update(numberFact: error.localizedDescription)
                })
            }
        }
    }
    
    func dismissNumberFactAlert() {
        model.update(numberFact: nil)
    }
}
