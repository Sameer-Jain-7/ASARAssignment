//
//  SingleEvent.swift
//  AssignmentASAR
//
//  Created by Sameer Jain on 25/08/24.
//

import Foundation

struct SingleEvent: Codable {
    let question: String
    let category: String
    let numberOfTraders: Int
    let randomImageUrl: String
    let information: String
    let probabilityHistory: [ProbabilityHistory]
    let users: [User]
    let eventDetails: EventDetails
    let averageYesPercentage: String
    let averageNoPercentage: String
    
    struct ProbabilityHistory: Codable {
        let timestamp: String
        let yesPercentage: Double
        let noPercentage: Double
    }
    
    struct User: Codable {
        let userforyes: String
        let amountInvestedYes: Double
        let userforno: String
        let amountInvestedNo: Double
    }
    
    struct EventDetails: Codable {
        let volumeOfMoney: String
        let startDate: String
        let endDate: String
    }
}


class EventLoader {
    func decodeEventFromFile() -> SingleEvent? {
        guard let url = Bundle.main.url(forResource: "singleEvent", withExtension: "json") else {
            print("Failed to locate singleEvent.json in bundle.")
            return nil
        }
        
        do {
            let data = try Data(contentsOf: url)
            let singleEvent = try JSONDecoder().decode(SingleEvent.self, from: data)
            return singleEvent
        } catch {
            print("Failed to decode JSON: \(error)")
            return nil
        }
    }
}

