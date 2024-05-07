////
////  SwiftyJSONify.swift
////  ebay-app
////
////  Created by Parth Patel on 11/10/23.
////
//
//import Foundation
//import SwiftyJSON
//
//
////let jsonString = """
////{
////    "name": "John",
////    "age": 30,
////    "city": "New York"
////}
////""
//if let jsonData = jsonString.data(using: .utf8) {
//    let swiftyJson = try? JSON(data: jsonData)
//
//    // Convert SwiftyJSON object to a native Swift type (e.g., Dictionary)
//    if let dictionary = swiftyJson?.dictionaryObject {
//        print("Converted to Dictionary: \(dictionary)")
//    }
//
//    // Convert SwiftyJSON object to Foundation object (e.g., Data)
//    if let jsonDataConverted = try? swiftyJson?.rawData() {
//        print("Converted to Data: \(String(data: jsonDataConverted, encoding: .utf8) ?? "")")
//    }
//}
//
