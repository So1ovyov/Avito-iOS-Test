//
//  JSONFileParser.swift
//  Test
//
//  Created by Максим Соловьёв on 14.01.2021.
//

import Foundation

public class JSONFileParser {
    
    var welcome: Welcome?
    
    init() {
        load()
    }
    
    func load() {
        if let fileResult = Bundle.main.url(forResource: "result", withExtension: "json") {
            
            do {
                let data = try Data(contentsOf: fileResult)
                let jsonDecoder = JSONDecoder()
                let dataFromJson = try jsonDecoder.decode(Welcome.self, from: data)
                self.welcome = dataFromJson
            } catch {
                print(error)
            }
        }
    }
    
}
