//
//  HttpRequest.swift
//  ze iOS
//
//  Created by Clara MatchUpBox on 26/10/2018.
//  Copyright © 2018 Apportable. All rights reserved.
//

import Foundation

class HttpRequest {
    
    static var sCryptoDataRaw:Data!
    static var sCryptoDataParsed:[String:Any]!
    
    func apiRequest(_ pApiUrl:String){
        let url = URL(string: pApiUrl)
        var datas:String!
        if let usableUrl = url {
            let request = URLRequest(url: usableUrl)
            let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
                if let data = data {
                    if let stringData = String(data: data, encoding: String.Encoding.utf8) {
                        datas = stringData
                        HttpRequest.sCryptoDataRaw = datas.data(using: .utf8)
                        HttpRequest.sCryptoDataParsed = self.parseJson(HttpRequest.sCryptoDataRaw)
                        //                        print(HttpRequest.sCryptoDataParsed)
                    }
                }
            })
            task.resume()
        }
    }
    
    func parseJson(_ pData:Data) -> [String: Any]{
        var lParsedJson:[String: Any]!
        do {
            lParsedJson =  try JSONSerialization.jsonObject(with: pData) as? [String: Any]
        } catch {
            print(error)
        }
        return lParsedJson!
    }
    
    
}
