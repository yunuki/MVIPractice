//
//  Service.swift
//  MVIPractice
//
//  Created by 윤재욱 on 2023/09/03.
//

import Foundation

protocol NumberFactServiceProtocol {
    func getNumberFact(number: Int) async throws -> String
}

struct NumberFactService: NumberFactServiceProtocol {
    func getNumberFact(number: Int) async throws -> String {
        let (data, _) = try await URLSession.shared.data(from: URL(string: "http://numbersapi.com/\(number)")!)
        return String(decoding: data, as: UTF8.self)
    }
}
