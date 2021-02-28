//
//  TaskHelper.swift
//  Virtual Tourist
//
//  Created by Julien Laurent on 2/26/21.
//

import Foundation
class TaskHelper {
    class func taskForGetRequest<ResponseType: Decodable>(url: URL, responseType: ResponseType.Type, completion: @escaping(ResponseType?, Error?)->Void){
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request){ data, response, error in
            guard let data = data else{
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                return
            }
            
            let decoder = JSONDecoder()
            
            do{
                let responseObject = try decoder.decode(ResponseType.self, from: data)
//                print("response object here")
//                print(responseObject)
                DispatchQueue.main.async {
                    completion(responseObject, nil)
                }
            }catch{
                DispatchQueue.main.async {
                    completion(nil, error)
                }
            }
        }
        task.resume()
    }
}
