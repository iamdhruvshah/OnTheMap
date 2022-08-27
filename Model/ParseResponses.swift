//
//  ParseResponses.swift
//  OnTheMap
//
//  Created by Dhruv Shah on 31/03/22.
//

import Foundation

//Structures for Parse Responses

struct StudentLocationResponse: Codable {
    let results: [LocationResults]
}
struct LocationResults: Codable {
    let firstName: String
    let lastName: String
    let createdAt: String
    let updatedAt: String
    let mapString: String
    let mediaURL: String
    let uniqueKey: String
    let objectId: String
    let longitude: Double
    let latitude: Double
}

struct PostLocationResponse: Codable {
    let objectId: String
    let createdAt: Date
}

struct UpdateLocationRespons: Codable {
    let updatedAt: Date
}
