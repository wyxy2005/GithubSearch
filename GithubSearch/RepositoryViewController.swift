//
//  RepositoryViewController.swift
//  GithubSearch
//
//  Created by Hiroki Nagasawa on 9/22/15.
//  Copyright © 2015 Hiroki Nagasawa. All rights reserved.
//

import Foundation
import SafariServices

class RepositoryViewController: UIViewController, ApplicationContextSettable {
    
    var appContext: ApplicationContext!
    var repository: Repository!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var URLButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = repository.name
        nameLabel.text = repository.fullName
        URLButton.setTitle(repository.HTMLURL.absoluteString, forState: .Normal)
    }
    
    @IBAction func openURL(sender: AnyObject) {
        let safari = SFSafariViewController(URL: repository.HTMLURL)
        safari.delegate = self
        presentViewController(safari, animated: true, completion: nil)
    }
    
}

extension RepositoryViewController: SFSafariViewControllerDelegate {
    func safariViewControllerDidFinish(controller: SFSafariViewController) {
        controller.dismissViewControllerAnimated(true, completion: nil)
    }
}