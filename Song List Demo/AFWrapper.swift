//
//  AFWrapper.swift
//  Song List Demo
//
//  Created by Mujahid on 09/09/20.
//  Copyright © 2020 Mujahid. All rights reserved.
//


import Alamofire
import AlamofireImage
import AlamofireObjectMapper
import ObjectMapper
class AFWrapper: NSObject {
   
    
    class func requestGETURL<T: Mappable>(url : String, params : [String : Any]?, success:@escaping (_ response: T) -> Void, failure:@escaping (Error) -> Void){
        Alamofire.request(url, method : .get,parameters: params).responseObject { (response: DataResponse<T>) in
            let responseResult = response.result.value

            switch response.result {
            case .success:
                success(responseResult!)
                break;
            case .failure(let error):
                failure(error  )
            
                break;
            }
        }
       

    }
}
