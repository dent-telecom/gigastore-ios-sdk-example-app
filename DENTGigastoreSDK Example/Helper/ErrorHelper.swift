//
//  ErrorHelper.swift
//  DENTGigastoreSDK example
//
//  Created by Christian Trümper on 16.02.21.
//

import Foundation

let AppErrorDomain = "DENTGigastoreSDKExampleErrorDomain"

class ErrorHelper
{
    class func createError(_ message: String? = nil, code: Int) -> Error
    {
        let error = NSError(domain: AppErrorDomain, code: code,
                            userInfo: [NSLocalizedDescriptionKey : message as Any])
        
        return error as Error
    }
}
