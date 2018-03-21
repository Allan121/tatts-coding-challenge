//
//  CompanyListViewController.swift
//  TattsChallenge
//
//  Created by Allan Poole on 19/7/17.
//  Copyright © 2017 Allan Poole. All rights reserved.
//

import UIKit

class CompanyListViewController: UITableViewController {

    let viewModel: CompanyListViewModel
    
    init(style: UITableViewStyle, viewModel: CompanyListViewModel) {
        self.viewModel = viewModel
        
        super.init(style: style)
    }
    
    convenience init(viewModel: CompanyListViewModel) {
        self.init(style: .plain, viewModel: viewModel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.viewModel = CompanyListViewModel()
        
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "The Lott"
        
        CompanyTableViewCell.registerForReuse(tableView)
        GenericHeaderTableViewCell.registerForReuse(tableView)
        
        viewModel.companies.observeNext(with: { [weak self] (companies) in
            
            self?.tableView.reloadData()
            self?.updateRefreshButtonState(loading: false)
            
        }).dispose(in: bag)
        
        viewModel.companies.observeFailed { [weak self] (error) in
            let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
            self?.present(alert, animated: true, completion: nil)
        }.dispose(in: bag)
        
        self.refreshCompanyList()
    }

    // MARK:- TableViewDelegate
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return viewModel.numberOfSections()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return viewModel.numberOfRows(forSection: section)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 60.0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: kCompanyTableViewCellIdentifier, for: indexPath) as? CompanyTableViewCell else {
            print ("Unable to dequeue cell.")
            return UITableViewCell()
        }
        
        cell.viewModel = viewModel.companyViewModelFor(index: indexPath.row)
        
        return cell
    }
    
    // MARK:- Header
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableCell(withIdentifier: kGenericHeaderTableViewCellIdentifier) as? GenericHeaderTableViewCell else {
            print ("Unexpected header type.")
            return nil
        }
        
        header.titleLabel.text = "Please select your lottery provider"
        
        return header
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44.0
    }
    
    // MARK:- Utility
    
    func refreshCompanyList() {
        self.updateRefreshButtonState(loading: true)
        viewModel.fetchCompanies()
    }
    
    private func updateRefreshButtonState(loading: Bool) {
        if loading {
            
            let activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .gray)
            activityIndicatorView.startAnimating()
            let loadingButton = UIBarButtonItem(customView: activityIndicatorView)
            self.navigationItem.rightBarButtonItem = loadingButton
            
        } else {
            
            let refreshButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.refresh, target: self, action: #selector(refreshCompanyList))
            self.navigationItem.rightBarButtonItem = refreshButton
        }
    }
}

