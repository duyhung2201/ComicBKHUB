//
//  ComicAPIManager.swift
//  project2
//
//  Created by HoaPQ on 3/11/19.
//  Copyright © 2019 HoaPQ. All rights reserved.
//

import UIKit
import SwiftyJSON

class ComicApiManage: NSObject {
    static let shared : ComicApiManage = ComicApiManage()
    
    enum HTTPMethods : String {
        case get = "GET"
        case post = "POST"
        case put = "PUT"
        case delete = "DELETE"
    }
    
    public let hostUrl = "https://mbcomic-app.herokuapp.com/"
    typealias CompletionDict = (_ succes: Bool, _ data: [String : Any]?) -> ()
    
    typealias Completion = (_ succes: Bool, _ data: Any?) -> ()
    
    func getComicById(id_comic: Int, completion: @escaping Completion) {
        let request = NSMutableURLRequest(url: URL(string: "\(hostUrl)comics?id=\(id_comic)")!, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        request.httpMethod = HTTPMethods.get.rawValue
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest) { (data, response, error) in
            if let responseHTTP = response as? HTTPURLResponse {
                if responseHTTP.statusCode == 200 || responseHTTP.statusCode == 201 {
                    if (error != nil) {
                        DispatchQueue.main.async {
                            completion(false , nil)
                        }
                    } else {
                        let json = JSON(data!)
                        let data = DetailModel(json: json)
                        DispatchQueue.main.async {
                            completion(true, data)
                        }
                        
                    }
                } else {
                    DispatchQueue.main.async {
                        completion(false , nil)
                    }
                }
            }
        }
        dataTask.resume() 
    }
    
  
    
    //MARK: - Spin Code
//    func getHomeComics(completion : @escaping CompletionDict) {
//        
//        let request = NSMutableURLRequest(url: NSURL(string: "\(hostUrl)comics/home")! as URL,
//                                          cachePolicy: .useProtocolCachePolicy,
//                                          timeoutInterval: 10.0)
//        request.httpMethod = HTTPMethods.get.rawValue
//        let session = URLSession.shared
//        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
//            if let responseHTTP = response as? HTTPURLResponse {
//                if responseHTTP.statusCode == 200 || responseHTTP.statusCode == 201 {
//                    if (error != nil) {
//                        completion(false , nil)
//                    } else {
//                        let json = JSON(data!)
//                        var data = [String: [HomeModel]]()
//                        
//                        data["popular"] = [HomeModel]()
//                        data["newest"] = [HomeModel]()
//                        
//                        for item in json["popular"].arrayValue {
//                            let i = HomeModel(json: item)
//                            data["popular"]?.append(i)
//                        }
//                        
//                        for item in json["newest"].arrayValue {
//                            let i = HomeModel(json: item)
//                            data["newest"]?.append(i)
//                        }
//                        completion(true, data)
//                    }
//                } else {
//                    completion(false , nil)
//                }
//            }
//        })
//        
//        dataTask.resume()
//    }
    
    
}



