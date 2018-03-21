//
//  CompanyViewModelTests.swift
//  TattsChallenge
//
//  Created by Allan Poole on 19/7/17.
//  Copyright © 2017 Allan Poole. All rights reserved.
//

import XCTest

@testable import TattsChallenge

class CompanyViewModelTests: XCTestCase {
    
    var viewModel: CompanyViewModel!
    
    override func setUp() {
        
        super.setUp()
        
        viewModel = CompanyViewModel(company: self.mockCompany())
    }
    
    override func tearDown() {
        
        viewModel = nil
        
        super.tearDown()
    }
    
    func test_init_viewModelInformationIsCorrect() {
        
        let mockCompany = self.mockCompany()
        
        XCTAssertEqual(viewModel.companyName(), mockCompany.companyName)
        XCTAssertEqual(viewModel.companyDescription(), mockCompany.companyDescription)
        XCTAssertEqual(viewModel.companyLogo(), mockCompany.companyLogoUrl)
    }
    
    func mockCompany() -> Company {
        
        return Company(companyDict: [kCompanyIdKey : "id1", kCompanyNameKey : "name1", kCompanyDescriptionKey : "description1", kCompanyLogoUrlKey : "url1"])
    }
}
