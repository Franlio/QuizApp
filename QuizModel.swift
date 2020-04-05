//
//  QuizModel.swift
//  QuizApp
//
//  Created by 廖翊淳 on 2020/3/13.
//  Copyright © 2020 Yi-Chun Liao. All rights reserved.
//

import Foundation

protocol QuizProtocol {
    
    func questionsRetrieved(_ questions:[Question])
    
}

class QuizModel {
    
    var delegate:QuizProtocol?
    
    func getQuestions() {
        
        // Fetch the questions
        getRemoteJsonFile()
        
    }
    
    func getLocalJsonFile() {
        
        // Get bundle path to json file
        let path = Bundle.main.path(forResource: "QuestionData", ofType: "json")
        
        // Double check that the path isn't nil
        guard path != nil else {
            print("Couldn't find the json data")
            return
        }
        
        // Create URL object from the path
        let url = URL(fileURLWithPath: path!)
        
        do {
            // Get the data from the URL
            let data = try Data(contentsOf: url)
            
            // Try to decode the data into objects
            let decoder = JSONDecoder()
            let array = try decoder.decode([Question].self, from: data)
            
            // Notify the delegate of the parsed objects
            delegate?.questionsRetrieved(array)
            
        }
        catch {
            
            // Error: Could read the data at the URL
            
        }
    }
    
    func getRemoteJsonFile() {
        
        // Get a URL object
        let urlString = "https://codewithchris.com/code/QuestionData.json"
        
        let url = URL(string: urlString)
        
        guard url != nil else {
            
            print("Couldn't return the URL object")
            return
            
        }
        
        // Get a URL Session object
        let session = URLSession.shared
        
        // Get a data task object
        let dataTask = session.dataTask(with: url!) { (data, response, error) in
            
            // Check that there wasn't an error
            if error == nil && data != nil {
                
                do {
                    
                    // Create a JSON Decoder object
                    let decoder = JSONDecoder()
                    
                    // Parse the JSON
                    let array = try decoder.decode([Question].self, from: data!)
                    
                    // Use the main thread to notify the view controller for UI work
                    DispatchQueue.main.sync {
                        
                        // Notify the delegate, the view controller is our delegate
                        self.delegate?.questionsRetrieved(array)
                        
                    }
                    
                }
                catch {
                    
                    print("Could't parse JSON")
                    
                }
                
                
            }
            
        }
        
        // Call resume on the data task
        dataTask.resume()
        
    }
    
}
