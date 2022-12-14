//
//  RequestBodiesUdacity.swift
//  OnTheMap
//
//  Created by Dhruv Shah
//

import Foundation

//Body
struct LogInStruct: Codable {
    var udacity: Udacity
}

struct Udacity: Codable {
    var username: String
    var password: String
}

//New Locations
struct StudentLocation: Codable {
    var objectId: String?
    var uniqueKey: String?
    var firstName: String?
    var lastName: String?
    var mapString: String?
    var mediaURL: String?
    var latitude: Double?
    var longitude: Double?
    var createdAt: String?
    var updatedAt: String?
}

