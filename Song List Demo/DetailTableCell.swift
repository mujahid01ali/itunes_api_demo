//
//  DetailTableCell.swift
//  Song List Demo
//
//  Created by Mujahid on 09/09/20.
//  Copyright © 2020 Mujahid. All rights reserved.
//

import UIKit

class DetailTableCell: UITableViewCell {

    @IBOutlet weak var lbArtistName: UILabel!
    @IBOutlet weak var lbTrackName: UILabel!
    @IBOutlet weak var imgArtwork: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func setData(res:Result?) {
        imgArtwork.imageFromRoundServerURL(urlString: res?.artworkUrl100)
        if let trackName = res?.trackName{
            lbTrackName.text = trackName
        }
        if let artistName = res?.artistName{
            lbArtistName.text = artistName
        }
    }
    
}
