//
//  FlickClient.swift
//  Virtual Tourist
//
//  Created by Julien Laurent on 2/25/21.
//

import Foundation
class FlickClient {
   
    private static var shareFlickClient: FlickClient = {
        let flickClient = FlickClient()
        return flickClient
    }()
    
    class func shared()->FlickClient{
        return shareFlickClient
    }
    
    
    static var api_key = "5583e10a87689289a9c33254c537a948"
    static let base = "https://api.flickr.com/services/rest/?"
    static let method = "flickr.photos.search"
    
    /*
     to download photo data
     */
    class func getPhotos(lat: Double, long: Double, completion: @escaping([Photo], Error?)->Void) {
        
        let params:[String: Any] = [
            "method": method,
            "api_key": api_key,
            "lat": lat,
            "lon": long,
            "per_page":100,
            "format": "json",
            "nojsoncallback":1,
            "extras":"url_m",
            "geo_context":2
        ]
        
        let requestParameter = requestParams(params: params)
        let url = URL(string: base + "\(requestParameter)")!
        
        let _ = TaskHelper.taskForGetRequest(url: url, responseType: FlickrPhotos.self) { response, error in
            
            if let response = response{
                completion(response.photos.photo, nil)
            }else{
                completion([], error)
            }
        
        }
    }
   
    class func getPhoto(photoStringUrl: String, completion: @escaping(Data?, Error?)->Void) {
        let url = URL(string: photoStringUrl)
        
        guard let urlValue = url else {
            DispatchQueue.main.async {
                completion(nil, nil) //no data there
            }
            return
        }
        let task = URLSession.shared.dataTask(with: URLRequest(url: urlValue)){data, response, error in
            DispatchQueue.main.async {
                completion(data, nil)
            }
        }
        task.resume()
    }
    
     class func requestParams(params: [String: Any])->String{
        var parts: [String] = []
        for param in params {
            parts.append("\(param.key)=\(param.value)")
        }
        let requestHeader = parts.sorted().joined(separator: "&")
        return requestHeader
    }
}
