//
//  UIImageView.swift
//  Song List Demo
//
//  Created by Mujahid on 09/09/20.
//  Copyright © 2020 Mujahid. All rights reserved.
//

import UIKit

import Alamofire
import AlamofireImage
extension UIImageView {
    func imageFromRoundServerURL(urlString: String?,placeHolder:String? = "") {
        
        self.image = UIImage(named: placeHolder ?? "")
        
        if(urlString != nil)
        {
            Alamofire.request(urlString ?? "").responseImage { response in
                
                if let image = response.result.value {
                    
                    self.image = image
                    //self.roundedImage()
                }
            }
            
        }
    }}
