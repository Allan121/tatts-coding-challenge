//
//  CompanyListViewControllerTests.swift
//  TattsChallenge
//
//  Created by Allan Poole on 19/7/17.
//  Copyright © 2017 Allan Poole. All rights reserved.
//

import XCTest

@testable import TattsChallenge

class MockCompanyListViewModel: CompanyListViewModel {
    
    var fetchCompaniesCalled = false
    
    override func fetchCompanies() {
        fetchCompaniesCalled = true
    }
    
    override func numberOfSections() -> Int {
        return 1
    }
    
    override func numberOfRows(forSection: Int) -> Int {
        return 1
    }
    
    override func companyViewModelFor(index: Int) -> CompanyViewModel {
        
        return CompanyViewModel(company: self.mockCompany())
    }
    
    func mockCompany() -> Company {
        
        return Company(companyDict: [kCompanyIdKey : "id1", kCompanyNameKey : "name1", kCompanyDescriptionKey : "description1", kCompanyLogoUrlKey : "url1"])
    }
}

class CompanyListViewControllerTests: XCTestCase {
    
    var mockViewModel: MockCompanyListViewModel!
    
    var companyListViewController: CompanyListViewController!
    
    override func setUp() {
        
        super.setUp()
        
        mockViewModel = MockCompanyListViewModel()
        
        companyListViewController = CompanyListViewController(viewModel: mockViewModel)
    }
    
    override func tearDown() {
        
        mockViewModel = nil
        
        companyListViewController = nil
        
        super.tearDown()
    }
    
    func test_init_viewModelSetCorrectly() {
        
        //GIVEN
        mockViewModel = MockCompanyListViewModel()
        
        //WHEN
        companyListViewController = CompanyListViewController(viewModel: mockViewModel)
        
        //THEN
        XCTAssertEqual(companyListViewController.viewModel, mockViewModel)
    }
    
    func test_numberOfSectionsInTable_correctNumberReturned() {
        
        XCTAssertTrue(companyListViewController.numberOfSections(in: companyListViewController.tableView) == 1)
    }
    
    func test_numberOfRowsForSection_correctNumberReturned() {
        
        XCTAssertTrue(companyListViewController.tableView(companyListViewController.tableView, numberOfRowsInSection: 0) == 1)
    }
    
    func test_heightForRowAtIndexPath_correctHeightReturned() {
        
        XCTAssertTrue(companyListViewController.tableView(companyListViewController.tableView, heightForRowAt: IndexPath(row: 0, section: 0)) == 60.0)
    }
    
    func test_cellForRowAtIndexPath_cellHasCorrectViewModel() {
        
        //WHEN
        let cell: CompanyTableViewCell = companyListViewController.tableView(companyListViewController.tableView, cellForRowAt: IndexPath(row: 0, section: 0)) as! CompanyTableViewCell
        
        //THEN
        let mockCompany = mockViewModel.mockCompany()
        
        XCTAssertTrue(cell.isKind(of: CompanyTableViewCell.self))
        XCTAssertEqual(cell.viewModel?.companyName(), mockCompany.companyName)
        XCTAssertEqual(cell.viewModel?.companyDescription(), mockCompany.companyDescription)
        XCTAssertEqual(cell.viewModel?.companyLogo(), mockCompany.companyLogoUrl)
    }
    
    func test_viewForHeaderInSection_headerHasCorrectTitle() {
        
        //WHEN
        let header: GenericHeaderTableViewCell = companyListViewController.tableView(companyListViewController.tableView, viewForHeaderInSection: 0) as! GenericHeaderTableViewCell
        
        //THEN
        XCTAssertTrue(header.isKind(of: GenericHeaderTableViewCell.self))
        XCTAssertEqual(header.titleLabel.text, "Please select your lottery provider")
    }
    
    func test_heightForHeaderInSection_correctHeightReturned() {
        
        XCTAssertTrue(companyListViewController.tableView(companyListViewController.tableView, heightForHeaderInSection: 0) == 44)
    }
    
    func test_refreshCompanyList_fetchCompaniesCalled_loadingIndicatorShown() {
        
        //WHEN
        companyListViewController.refreshCompanyList()
        
        //THEN
        XCTAssertTrue(mockViewModel.fetchCompaniesCalled)
        XCTAssertTrue((companyListViewController.navigationItem.rightBarButtonItem?.customView?.isKind(of: UIActivityIndicatorView.self))!)
    }
}
