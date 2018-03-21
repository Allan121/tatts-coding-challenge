//
//  ServerAPI.swift
//  TattsChallenge
//
//  Created by Allan Poole on 19/7/17.
//  Copyright © 2017 Allan Poole. All rights reserved.
//

import UIKit
import PromiseKit
import OMGHTTPURLRQ

class ServerAPI: NSObject {

    func getCompanyList() -> Promise<[Company]?> {
        
        return URLSession.shared.GET("https://api.tatts.com/svc/sales/vmax/web/data/lotto/companies").asDictionary().then { json -> [Company]? in
            
            if let companyDicts: [Dictionary<String, String>] = json["Companies"] as? [Dictionary<String, String>] {
                
                return companyDicts.map({ (companyDict: Dictionary<String, String>) -> Company in
                    
                    return Company(companyDict: companyDict)
                })
            }
            
            return nil
        }
    }
}
