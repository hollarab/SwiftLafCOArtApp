//
//  WorkOfArt.swift
//  LaffArtsDemo
//
//  Created by hollarab on 11/23/14.
//  Copyright (c) 2014 a. brooks hollar. All rights reserved.
//

import UIKit

class WorkOfArt: NSObject {
    
    var title:String? = nil
    var address:String? = nil
    var artist:String? = nil
    var collection:String? = nil
    var latitude:Double? = nil
    var longitude:Double? = nil
    var year:Int? = nil
    var imageName:String? = nil
    
    class func parseObjsFromJSON(array:NSArray) -> [WorkOfArt]? {
        var worksOfArt:[WorkOfArt]? = []
        
        for workData in array {
            if let dic = workData as? [NSString:AnyObject] {
                var work = WorkOfArt()
                work.title = dic["title"] as? String
                work.address = dic["address"] as? String
                work.artist = dic["artist"] as? String
                work.collection = dic["collection"]  == nil ? "unknown" :  dic["collection"] as? String
                work.latitude = dic["latitude"] as? Double
                work.longitude = dic["longitude"] as? Double
                work.year = dic["year"] as? Int
                work.imageName = dic["image"] as? String
                worksOfArt!.append(work)
            }
        }
        
        return worksOfArt
    }
    
    private class func imageURLFromName(name:String?) -> NSURL? {
        if let n = name {
            return NSURL(string: "https://raw.githubusercontent.com/saintsjd/lafayette-co-arts/master/images/\(n)")
        }
        return nil
    }    
}

