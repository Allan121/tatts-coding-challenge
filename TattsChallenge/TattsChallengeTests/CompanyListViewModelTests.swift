//
//  CompanyListViewModelTests.swift
//  TattsChallenge
//
//  Created by Allan Poole on 19/7/17.
//  Copyright © 2017 Allan Poole. All rights reserved.
//

import XCTest
import PromiseKit
import Bond
import ReactiveKit

@testable import TattsChallenge

class MockServerAPI: ServerAPI {
    
    var getCompanyListCalled = false
    
    override func getCompanyList() -> Promise<[Company]?> {
        getCompanyListCalled = true
        
        return Promise(value: self.mockCompanyList())
    }
    
    func mockCompanyList() -> [Company] {
        
        let company1 = Company(companyDict: [kCompanyIdKey : "id1", kCompanyNameKey : "name1", kCompanyDescriptionKey : "description1", kCompanyLogoUrlKey : "url1"])
        let company2 = Company(companyDict: [kCompanyIdKey : "id2", kCompanyNameKey : "name2", kCompanyDescriptionKey : "description2", kCompanyLogoUrlKey : "url2"])
        
        return [company1, company2]
    }
}

class CompanyListViewModelTests: XCTestCase {
    
    var viewModel: CompanyListViewModel!
    
    var mockServerAPI: MockServerAPI!
    
    override func setUp() {
        super.setUp()
        
        mockServerAPI = MockServerAPI()
        
        viewModel = CompanyListViewModel(serverAPI: mockServerAPI)
    }
    
    override func tearDown() {
        
        mockServerAPI = nil
        
        viewModel = nil
        
        super.tearDown()
    }
    
    
    func test_init_serverAPISetCorrectly() {
        
        //GIVEN
        mockServerAPI = MockServerAPI()
        
        //WHEN
        viewModel = CompanyListViewModel(serverAPI: mockServerAPI)
        
        //THEN
        XCTAssertEqual(viewModel.serverAPI, mockServerAPI)
    }
    
    func test_fetchCompanies_getCompanyListCalled_companiesSetCorrectly() {
        
        //GIVEN
        let companyListExpectation = expectation(description: "getCompanyList")
        
        //WHEN
        viewModel.fetchCompanies()
        
        //THEN
        viewModel.companies.observeNext { (companies) in
            
            if companies as! [Company] == self.mockServerAPI.mockCompanyList() {
                companyListExpectation.fulfill()
            }
            
        }.dispose(in: bag)
        
        waitForExpectations(timeout: 3.0) { (error) in
            
            XCTAssertTrue(self.mockServerAPI.getCompanyListCalled)
            XCTAssertEqual(self.viewModel.companies.value as! [Company], self.mockServerAPI.mockCompanyList())
        }
    }
    
    func test_numberOfSections_correctValueReturned() {
        
        //WHEN
        let numSections = viewModel.numberOfSections()
        
        //THEN
        XCTAssertTrue(numSections == 1)
    }
    
    func test_numberOfRowsForSection_correctNumberOfRowsReturned() {
        
        //GIVEN
        viewModel.companies.value = mockServerAPI.mockCompanyList()
        
        //WHEN
        let numRows = viewModel.numberOfRows(forSection: 0)
        
        //THEN
        XCTAssertTrue(numRows == viewModel.companies.value.count)
    }
    
    func test_companyViewModelForIndex_correctCompanyViewModelReturned() {
        
        //GIVEN
        viewModel.companies.value = mockServerAPI.mockCompanyList()
        
        //WHEN
        let companyViewModel = viewModel.companyViewModelFor(index: 0)
        
        //THEN
        let mockCompany = mockServerAPI.mockCompanyList()[0]
        
        XCTAssertEqual(companyViewModel.companyName(), mockCompany.companyName)
        XCTAssertEqual(companyViewModel.companyDescription(), mockCompany.companyDescription)
        XCTAssertEqual(companyViewModel.companyLogo(), mockCompany.companyLogoUrl)
    }
}
