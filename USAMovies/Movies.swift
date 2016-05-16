//
//  Movies.swift
//  USAMovies
//
//  Created by Sherrie Ann Auer on 15/05/16.
//  Copyright © 2016 Sherrie Ann Auer. All rights reserved.
//

import Foundation

class Movies {
    
    var vRank = 0
    
    // Data Encapsulation
    private var _vName:String
    private var _vVideoUrl:String
    private var _vImageUrl:String
    private var _vRights:String
    private var _vPrice:String
    private var _vArtist:String
    private var _vImid:String
    private var _vGenre:String
    private var _vLinkToiTunes:String
    private var _vReleaseDte:String
    
    //This variable gets created from the UI
    var vImageData: NSData?
    
    
    //Make a getter
    
    var vName: String {
        return _vName
    }
    
    var vImageUrl: String {
        return _vImageUrl
    }
    
    var vVideoUrl: String {
        return _vVideoUrl
    }
    
    var vRights: String {
        return _vRights
    }
    
    var vPrice: String {
        return _vPrice
    }
    
    var vArtist: String {
        return _vArtist
    }
    
    var vImid: String {
        return _vImid
    }
    
    var vGenre: String {
        return _vGenre
    }
    
    var vLinkToiTunes: String {
        return _vLinkToiTunes
    }
    
    var vReleaseDte: String {
        return _vReleaseDte
    }
    
    
    init(data: JSONDictionary) {
        //If we do not initialize all properties we will get error message
        //Return from initializer without initializing all stored properties
        
        
        // Video name
        if let name = data["im:name"] as? JSONDictionary,
            vName = name["label"] as? String {
            self._vName = vName
        }else{
            //You may not always get data back from the JSON - you may want to display message
            // element in the JSON is unexpected
            
            _vName = ""
        }
        
        
        // The Video Image
        if let img = data["im:image"] as? JSONArray,
            image = img[2] as? JSONDictionary,
            immage = image["label"] as? String {
            _vImageUrl = immage.stringByReplacingOccurrencesOfString("100x100", withString: "600x600")
        }else{
            _vImageUrl = ""
        }
        
        
        //Video Url
        if let video = data["link"] as? JSONArray,
            vUrl = video[1] as? JSONDictionary,
            vHref = vUrl["attributes"] as? JSONDictionary,
            vVideoUrl = vHref["href"] as? String {
            self._vVideoUrl = vVideoUrl
        }else{
            _vVideoUrl = ""
        }
        
        //Rights
        if let rights = data["rights"] as? JSONDictionary,
            vrights = rights["label"] as? String{
            self._vRights = vrights
        }else{
            _vRights = ""
        }
        
        
        //Price
        if let price = data["im:price"] as? JSONDictionary,
            vprice = price["label"] as? String{
            self._vPrice = vprice
        }else{
            _vPrice = ""
        }
        
        
        //Artist
        if let artist = data["im:artist"] as? JSONDictionary,
            vartist = artist["label"] as? String{
            self._vArtist = vartist
        }else{
            _vArtist = ""
        }
        
        //Id
        if let id = data["id"] as? JSONDictionary,
            vattribute = id["attributes"] as? JSONDictionary,
            vid = vattribute["im:id"] as? String{
            self._vImid = vid
        }else{
            _vImid = ""
        }
        
        
        //Genre
        if let category = data["category"] as? JSONDictionary,
            vattributes = category["attributes"] as? JSONDictionary,
            vgenre = vattributes["term"] as? String{
            self._vGenre = vgenre
        }else{
            _vGenre = ""
        }
        
        
        // Link to the itunes
        if let linkid = data["id"] as? JSONDictionary,
            vlinkidtoitunes = linkid["label"] as? String{
            self._vLinkToiTunes = vlinkidtoitunes
        }else{
            _vLinkToiTunes = ""
        }
        
        
        //Release date
        if let releaseDt = data["im:releaseDate"] as? JSONDictionary,
            vattributes = releaseDt["attributes"] as? JSONDictionary,
            vrelreasedt = vattributes["label"] as? String{
            self._vReleaseDte = vrelreasedt
        }else{
            _vReleaseDte = ""
        }
        
    }
    
    
    
}