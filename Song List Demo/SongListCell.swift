//
//  SongListCell.swift
//  Song List Demo
//
//  Created by Mujahid on 09/09/20.
//  Copyright © 2020 Mujahid. All rights reserved.
//

import UIKit
protocol SongListCellDelegate {
    func onClick(id:Int)
}

class SongListCell: UITableViewCell {

    @IBOutlet weak var lbPrice: UILabel!
    @IBOutlet weak var lbDuration: UILabel!
    @IBOutlet weak var lbArtistname: UILabel!
    @IBOutlet weak var imgArtwork: UIImageView!
    @IBOutlet weak var lbTrackName: UILabel!
    @IBOutlet weak var parentView: UIView!
    var delegate:SongListCellDelegate?
    var index:Int?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        parentView.roundCorners([.allCorners], radius: 8.0)
        imgArtwork.roundCorners([.allCorners], radius: 8.0)
        let tapOnCard = UITapGestureRecognizer(target: self, action: #selector(onClickCard))
        parentView.isUserInteractionEnabled = true
        parentView.addGestureRecognizer(tapOnCard)
    }
    @objc func onClickCard(){
        if let id = index{
            delegate?.onClick(id: id)
        }
        
    }
    func setData(res:Result?,index:Int) {
        self.index = index
        imgArtwork.imageFromRoundServerURL(urlString: res?.artworkUrl100)
        if let trackName = res?.trackName{
            lbTrackName.text = trackName
        }
        if let artistName = res?.artistName{
            lbArtistname.text = artistName
        }
        if let trackTime = res?.trackTimeMillis{
            lbDuration.text = String(format: "%.2f", Double(trackTime)/(60*1000))+" Min"
        }
        if let price = res?.trackPrice{
            lbPrice.text = "Price \(price)"
        }
    }
    
}
