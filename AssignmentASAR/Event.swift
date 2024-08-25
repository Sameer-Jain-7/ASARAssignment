//
//  Event.swift
//  AssignmentASAR
//
//  Created by Sameer Jain on 24/08/24.
//

import Foundation

struct Event: Codable {
    let question: String
    let category: String
    let number_of_traders: Int
    let random_image_url: String
    let information: String
}

struct EventResponse: Codable {
    let events: [Event]
}


class DataLoader {
    func loadEvents() -> [Event] {
        guard let url = Bundle.main.url(forResource: "events", withExtension: "json") else {
            return []
        }
        do {
            let data = try Data(contentsOf: url)
            let eventResponse = try JSONDecoder().decode(EventResponse.self, from: data)
            return eventResponse.events
        } catch {
            print("Error loading JSON: \(error)")
            return []
        }
    }
}

