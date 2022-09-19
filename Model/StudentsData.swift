//
//  StudentsData.swift
//  OnTheMap
//
//  Created by Dhruv Shah on 09/09/22.
//

import Foundation

class StudentsData: NSObject {

    var students = [LocationResults]()

    class func sharedInstance() -> StudentsData {
        struct Singleton {
            static var sharedInstance = StudentsData()
        }
        return Singleton.sharedInstance
    }

}
