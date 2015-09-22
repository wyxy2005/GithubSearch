//
//  RepositoryCell.swift
//  GithubSearch
//
//  Created by Hiroki Nagasawa on 9/22/15.
//  Copyright © 2015 Hiroki Nagasawa. All rights reserved.
//

import UIKit

class RepositoryCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    
    class func heightForCell() -> CGFloat {
        return 60
    }
}
