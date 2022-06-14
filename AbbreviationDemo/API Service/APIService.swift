//
//  APIService.swift
//  AbbreviationDemo
//
//  Created by Karthik on 09/06/22.
//

import Foundation

class APIService :  NSObject {
    
    private let sourcesURL =  "http://www.nactem.ac.uk/software/acromine/dictionary.py?sf="
    
    func apiToAcronymData(text:String, completion : @escaping (AcronymModel?) -> ()){
        let finalURL = sourcesURL + text
        URLSession.shared.dataTask(with: URL(string: finalURL)!) { (data, urlResponse, error) in
            if let data = data {
                
                let jsonDecoder = JSONDecoder()
                
                do {
                    let empData = try jsonDecoder.decode([AcronymModel].self, from: data)
                    if empData.count > 0, let data = empData.first {
                        completion(data)
                    }else {
                        completion(nil)
                    }
                }catch  let err {
                    print(err.localizedDescription)
                }
               
            }
            
        }.resume()
    }
    
}
