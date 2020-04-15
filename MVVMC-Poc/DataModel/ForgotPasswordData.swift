//
//  ForgotPasswordData.swift
//  MVVMC-Poc
//
//  Created by SUNNY on 15/04/20.
//  Copyright © 2020 SUNNY. All rights reserved.
//

import Foundation

struct ForgotPasswordData {
    var isSuccess: Bool = false
    init(success: Bool) {
        isSuccess = success
    }
}
