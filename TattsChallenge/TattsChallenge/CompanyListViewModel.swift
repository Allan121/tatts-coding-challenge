//
//  CompanyListModelView.swift
//  TattsChallenge
//
//  Created by Allan Poole on 19/7/17.
//  Copyright © 2017 Allan Poole. All rights reserved.
//

import UIKit
import Bond
import ReactiveKit

class CompanyListViewModel: NSObject {
    
    let serverAPI: ServerAPI
    
    var companies: Observable<[Company]?> = Observable([])
    
    init(serverAPI: ServerAPI) {
        self.serverAPI = serverAPI
    }
    
    convenience override init() {
        self.init(serverAPI: ServerAPI())
    }
    
    func fetchCompanies() {
        self.serverAPI.getCompanyList().then { [weak self] companies in
            
            self?.companies.value = companies
            
        }.catch { [weak self] (error) in
            
            guard let error = error as? Property.Error else {
                print ("Unrecognised error type")
                return
            }
            self?.companies.failed(error)
        }
    }
    
    func numberOfSections() -> Int {
        return 1
    }
    
    func numberOfRows(forSection: Int) -> Int {
        guard let companies = self.companies.value else { return 0 }
        return companies.count
    }
    
    func companyViewModelFor(index: Int) -> CompanyViewModel? {
        guard let companies = self.companies.value,
            index < companies.count else {
                return nil
        }
        var companyViewModel: CompanyViewModel = CompanyViewModel(company: companies[index])
        
        companyViewModel.lastCompany = index == companies.count - 1
        
        return companyViewModel
    }
}
