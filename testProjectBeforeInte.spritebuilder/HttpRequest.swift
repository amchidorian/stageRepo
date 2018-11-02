//
//  HttpRequest.swift
//  ze iOS
//
//  Created by Dorian Pikcio on 26/10/2018.
//  Copyright © 2018 Apportable. All rights reserved.
//

import Foundation

class HttpRequest {
    
    static var sCryptoDataRaw:Data!
    static var sCryptoDataParsed:[String:Any]!
    
    func apiRequest(_ pApiUrl:String){
        let lUrl = URL(string: pApiUrl)
        var lDatas:String!
        if let lUsableUrl = lUrl {
            let request = URLRequest(url: lUsableUrl)
            let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
                if let data = data {
                    if let lStringData = String(data: data, encoding: String.Encoding.utf8) {
                        lDatas = lStringData
                        HttpRequest.sCryptoDataRaw = lDatas.data(using: .utf8)
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
