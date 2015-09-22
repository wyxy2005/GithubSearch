//
//  ApplicationContext.swift
//  GithubSearch
//
//  Created by Hiroki Nagasawa on 9/22/15.
//  Copyright © 2015 Hiroki Nagasawa. All rights reserved.
//

import Foundation

class ApplicationContext {
    let github: GithubAPI = GithubAPI()
}

protocol ApplicationContextSettable: class {
    var appContext: ApplicationContext! { get set }
}