//
//  Bundle-Main.swift
//  Moonshot
//
//  Created by sardar saqib on 30/12/2024.
//

import Foundation
extension Bundle {
    func decode<T: Codable>(file : String) -> T{
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("file not found")
        }
        guard let data = try? Data(contentsOf: url) else {
            fatalError("unable to load data from url")
        }
        
        let decoder = JSONDecoder()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "y-MM-dd"
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        
        do {
            return try decoder.decode(T.self, from: data)
        } catch DecodingError.keyNotFound(let key, let error) {
            fatalError("key \(key.stringValue) not found with error \(error)")
        } catch DecodingError.valueNotFound(_, let context) {
            fatalError("value not found \(context.debugDescription)")
        } catch DecodingError.typeMismatch(_, let context) {
            fatalError("type missmatch \(context.debugDescription)")
        } catch DecodingError.dataCorrupted(let context) {
            fatalError("json data corrupted \(context.debugDescription)")
        } catch let error {
            fatalError("unable to decode due to :\(error.localizedDescription)")
        }
    }
}
