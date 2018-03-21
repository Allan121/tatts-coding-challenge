//
//  CompanyTableViewCell.swift
//  TattsChallenge
//
//  Created by Allan Poole on 19/7/17.
//  Copyright © 2017 Allan Poole. All rights reserved.
//

import UIKit
import SDWebImage

let kCompanyTableViewCellIdentifier: String = "CompanyTableViewCellIdentifier"

class CompanyTableViewCell: UITableViewCell {

    @IBOutlet weak var companyImageView: UIImageView!
    @IBOutlet weak var companyNameLabel: UILabel!
    @IBOutlet weak var cellSeparator: UIView!
    
    var viewModel: CompanyViewModel? {
        didSet {
            self.configureFromViewModel()
        }
    }
    
    class func registerForReuse(_ tableView: UITableView) {
        tableView.register(UINib(nibName: String(describing: self), bundle: nil), forCellReuseIdentifier: kCompanyTableViewCellIdentifier)
    }
    
    private func configureFromViewModel() {
        guard let viewModel = viewModel else { return }
        
        self.companyNameLabel.text = viewModel.companyDescription()
        self.companyImageView.sd_setImage(with: viewModel.companyLogo())
        self.cellSeparator.isHidden = viewModel.lastCompany
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.companyNameLabel.text = nil
        self.companyImageView.image = nil
        self.cellSeparator.isHidden = false
    }
}
