//
//  CompanyViewModel.swift
//  TattsChallenge
//
//  Created by Allan Poole on 19/7/17.
//  Copyright © 2017 Allan Poole. All rights reserved.
//

import UIKit

struct CompanyViewModel {
    
    private var company: Company
    
    var lastCompany: Bool = false
    
    init(company: Company) {
        self.company = company
    }
    
    func companyName() -> String? {
        return company.companyName
    }
    
    func companyDescription() -> String? {
        return company.companyDescription
    }
    
    func companyLogo() -> URL? {
        return company.companyLogoUrl
    }
}
