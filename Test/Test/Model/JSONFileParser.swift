//
//  JSONFileParser.swift
//  Test
//
//  Created by Максим Соловьёв on 14.01.2021.
//

import Foundation

public class JSONFileParser {
    
    func parse<D: Decodable>(fileName: String) -> D? {
        
        if let fileResult = Bundle.main.url(forResource: fileName, withExtension: "json") {
            do {
                let data = try Data(contentsOf: fileResult)
                let jsonDecoder = JSONDecoder()
                let dataFromJson = try jsonDecoder.decode(D.self, from: data)
                return dataFromJson
            } catch {
                print(error)
            }
        }
        return nil
    }
    
}
