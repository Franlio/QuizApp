//
//  Question.swift
//  QuizApp
//
//  Created by 廖翊淳 on 2020/3/12.
//  Copyright © 2020 Yi-Chun Liao. All rights reserved.
//

import Foundation

// Question structure conform to the Codable protocol
struct Question: Codable {
    
    
    // Check if the keys in JSON data files match the keys of the questions properties below
    var question:String?
    var answers:[String]?
    var correctAnswerIndex:Int?
    var feedback:String?
    
}
