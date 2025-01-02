//
//  UserViewModel.swift
//  Milestone: Projects 10-12
//
//  Created by sardar saqib on 02/01/2025.
//

import Foundation
import SwiftData

class UserViewModel: ObservableObject {
    
    
    func getUsers(modelContext: ModelContext){
        guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else {
            fatalError("unable to convert string into URL")
        }
        URLSession.shared.dataTask(with: URLRequest(url: url)) { data , response , error  in
            if let error = error {
                print("Error: Network request failed with \(error.localizedDescription)")
                return
            }
            guard let data = data else {
                print("Error: No data received")
                return
            }
            do {
                let users = try JSONDecoder().decode([UserModel].self, from: data)
                DispatchQueue.main.async {
                    for user in users {
                       modelContext.insert(user)
                    }
                }
               
            } catch let error as DecodingError {
                self.handleDecodingError(error)
            } catch let error as NetworkError{
                self.handleNetworkingError(error)
            } catch {
                print("Error: Decoding failed with \(error.localizedDescription)")
            }
            
        }.resume()
    }
    
    private func handleDecodingError(_ error: DecodingError) {
        switch error {
        case .keyNotFound(let codingKey, let context):
            print("Error: Key '\(codingKey.stringValue)' not found - \(context.debugDescription)")
        case .valueNotFound(_, let context):
            print("Error: Value not found - \(context.debugDescription)")
        case .typeMismatch(let type, let context):
            print("Error: Type mismatch '\(type)' - \(context.debugDescription)")
        case .dataCorrupted(let context):
            print("Error: Data corrupted - \(context.debugDescription)")
        @unknown default:
            print("Error: Unknown decoding error occurred")
        }
    }
    private func handleNetworkingError(_ error: NetworkError) {
        switch error {
        case .badUrl:
            print("There was an error creating the URL")
        case .invalidRequest:
            print("Did not get a valid response")
        case .badResponse:
            print("Did not get a 2xx status code from the response")
        case .badStatus:
            print("Failed to decode response into the given type")
        case .failedToDecodeResponse:
            print("An error occured downloading the data")
        }
    }
}

enum NetworkError: Error {
    case badUrl
    case invalidRequest
    case badResponse
    case badStatus
    case failedToDecodeResponse
}
