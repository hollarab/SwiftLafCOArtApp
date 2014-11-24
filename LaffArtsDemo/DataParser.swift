//
//  DataParser.swift
//  LaffArtsDemo
//
//  Created by hollarab on 11/23/14.
//  Copyright (c) 2014 a. brooks hollar. All rights reserved.
//

import UIKit

class DataParser: NSObject {
    
    
    class var sharedInstance :DataParser {
        struct Singleton {
            static let instance = DataParser()
        }
        
        return Singleton.instance
    }
    
    var artWorks:[WorkOfArt]? = nil
    
    //MARK: Data fetching
    func fetchData(completion:(worksOfArt:[WorkOfArt]?) ->() ) {
        let dataURL = NSURL(string:"https://raw.githubusercontent.com/saintsjd/lafayette-co-arts/master/lafayette-co-public-art.json")
        let dataOpt = NSData(contentsOfURL: dataURL!)
        if let data = dataOpt {
            var error:NSError? = nil
            let jsonObject : AnyObject! = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil)
            
            if let array = jsonObject as? NSArray {
                self.artWorks = WorkOfArt.parseObjsFromJSON(array)
                completion(worksOfArt:artWorks)
            }
        }
    }

   
}
