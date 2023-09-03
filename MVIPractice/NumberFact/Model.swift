//
//  Model.swift
//  MVIPractice
//
//  Created by 윤재욱 on 2023/09/02.
//

import Combine

protocol NumberFactModelStateProtocol {
    var count: Int { get }
    var numberFact: String? { get }
}

protocol NumberFactModelActionProtocol {
    func increte()
    func decrete()
    func update(numberFact: String?)
}

final class NumberFactModel: ObservableObject, NumberFactModelStateProtocol {
    @Published var count: Int = 0
    @Published var numberFact: String? = nil
}

extension NumberFactModel: NumberFactModelActionProtocol {
    func increte() {
        count += 1
    }
    
    func decrete() {
        count -= 1
    }
    
    func update(numberFact: String?) {
        self.numberFact = numberFact
    }
}
