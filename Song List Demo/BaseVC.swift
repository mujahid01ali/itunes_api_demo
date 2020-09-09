//
//  BaseVC.swift
//  Song List Demo
//
//  Created by Mujahid on 09/09/20.
//  Copyright © 2020 Mujahid. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import ObjectMapper

class BaseVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    func apiCall<T: Mappable>(url:String, param:[String:Any],className:T.Type)  {
          AFWrapper.requestGETURL(url: url, params: param, success: { (response:T) in
              self.onSuccessResponse(response: response)
          }, failure: { (error:Error) in
              self.onFailResponse(response: error)
          })
      }
    func onSuccessResponse(response:Any) {
         
     }
     

    func onFailResponse(response:Error) {
            
        }
    
    func showToast(message: String){
        guard let window = UIApplication.shared.keyWindow else {return}
        let messageLbl = UILabel()
        messageLbl.text = message
        messageLbl.textAlignment = .center
        messageLbl.font = UIFont.systemFont(ofSize: 12)
        messageLbl.textColor = .white
        messageLbl.backgroundColor = UIColor(white: 0, alpha: 0.5)

        let textSize:CGSize = messageLbl.intrinsicContentSize
        let labelWidth = min(textSize.width, window.frame.width - 40)

        messageLbl.frame = CGRect(x: 20, y: window.frame.height - 90, width: labelWidth + 30, height: textSize.height + 20)
        messageLbl.center.x = window.center.x
        messageLbl.layer.cornerRadius = messageLbl.frame.height/2
        messageLbl.layer.masksToBounds = true
        window.addSubview(messageLbl)

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {

        UIView.animate(withDuration: 1, animations: {
            messageLbl.alpha = 0
        }) { (_) in
            messageLbl.removeFromSuperview()
        }
        }
    }
    
    


}
