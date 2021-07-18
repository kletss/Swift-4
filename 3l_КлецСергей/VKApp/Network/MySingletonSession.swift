//
//  MySingletonSession.swift
//  VKApp
//
//  Created by KKK on 18.05.2021.
//

import UIKit

class MySingletonSession  {
    
    static let instance = MySingletonSession()
    
    var token: String = ""
    var userID: String = ""
    
    private init() { }
}
