//
//  ViewTypeModel.swift
//  Song List Demo
//
//  Created by Mujahid on 09/09/20.
//  Copyright © 2020 Mujahid. All rights reserved.
//

import UIKit

struct ViewTypeModel {
    var type:String?
    var model:Any?
    
    init(type:String,model:Any) {
        self.type = type
        self.model = model
    }
    
}
