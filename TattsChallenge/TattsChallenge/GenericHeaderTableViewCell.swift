//
//  GenericHeaderTableViewCell.swift
//  TattsChallenge
//
//  Created by Allan Poole on 19/7/17.
//  Copyright © 2017 Allan Poole. All rights reserved.
//

import UIKit

let kGenericHeaderTableViewCellIdentifier: String = "kGenericHeaderTableViewCellIdentifier"

class GenericHeaderTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    
    class func registerForReuse(_ tableView: UITableView) {
        tableView.register(UINib(nibName: String(describing: self), bundle: nil), forCellReuseIdentifier: kGenericHeaderTableViewCellIdentifier)
    }
}
