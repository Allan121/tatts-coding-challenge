//
//  Company.swift
//  TattsChallenge
//
//  Created by Allan Poole on 19/7/17.
//  Copyright © 2017 Allan Poole. All rights reserved.
//

import UIKit

let kCompanyIdKey = "CompanyId"
let kCompanyNameKey = "CompanyDisplayName"
let kCompanyDescriptionKey = "CompanyDescription"
let kCompanyLogoUrlKey = "CompanyLogoUrl"

struct Company: Equatable {

    let id: String?
    let companyName: String?
    let companyDescription: String?
    let companyLogoUrl: URL?
    
    init(companyDict: Dictionary<String, String>) {
        self.id = companyDict[kCompanyIdKey]
        self.companyName = companyDict[kCompanyNameKey]
        self.companyDescription = companyDict[kCompanyDescriptionKey]
        
        if let logoUrlString = companyDict[kCompanyLogoUrlKey] {
            self.companyLogoUrl = URL(string: logoUrlString)
        } else {
            self.companyLogoUrl = nil
        }
    }
}

func ==(lhs: Company, rhs: Company) -> Bool {
    return lhs.id == rhs.id
        && lhs.companyName == rhs.companyName
        && lhs.companyDescription == rhs.companyDescription
        && lhs.companyLogoUrl == rhs.companyLogoUrl
}
