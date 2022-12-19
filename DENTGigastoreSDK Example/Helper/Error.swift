//
//  Error.swift
//  DENTGigastoreSDK example
//
//  Created by Christian Trümper on 26.05.21.
//

import Foundation

extension Error {
    var errorCode:Int? {
        return (self as NSError).code
    }
}
