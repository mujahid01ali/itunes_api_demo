//
//  DetailVC.swift
//  Song List Demo
//
//  Created by Mujahid on 09/09/20.
//  Copyright © 2020 Mujahid. All rights reserved.
//

import UIKit
import CoreMedia

class DetailVC: BaseVC {

    @IBOutlet weak var lbCollectionPrice: UILabel!
    @IBOutlet weak var lbReleaseDate: UILabel!
    @IBOutlet weak var lnKind: UILabel!
    @IBOutlet weak var lbGenre: UILabel!
    @IBOutlet weak var lbEndTime: UILabel!
    @IBOutlet weak var lbStartTime: UILabel!
    @IBOutlet weak var btnPlayPause: UIButton!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var viewPlayPause: UIView!
    @IBOutlet weak var lbArtistName: UILabel!
    @IBOutlet weak var lbTrackName: UILabel!
    @IBOutlet weak var imgArtwork: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    let musicPlayer = MusicPlayer()
    var musicUrl:String?
    var result:Result?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        checkMediaType()
        musicPlayer.delegate = self
        musicPlayer.delegatePlayPause = self
        musicPlayer.delegateProgress = self
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        if musicPlayer.timer != nil {
            musicPlayer.timer?.invalidate()
        }
        DispatchQueue.main.asyncAfter(deadline: .now()+0.1) {
            self.musicPlayer.player?.pause()
            self.musicPlayer.player = nil
            
        }

    }
    func checkMediaType() {
        if let kind = result?.kind{
            if kind == "song"{
                if let url = result?.previewUrl{
                    slider.value = 0
                    DispatchQueue.global().async {
                            self.musicPlayer.prepareSong(url)

                    }
                }
            }else{
                slider.isHidden = true
                lbEndTime.isHidden = true
                lbStartTime.isHidden = true
                viewPlayPause.isHidden = true
                
            }
        }
    }
    @IBAction func sliderValueChanged(_ sender: Any) {
        print(slider.value)
        musicPlayer.player?.seek(to: .init(value: CMTimeValue(Int(slider.value * 100000)), timescale: 100000))
    }
    @IBAction func onClickPlayPause(_ sender: Any) {
        musicPlayer.playMusic()
    }
    func setUI() {
        viewPlayPause.layer.cornerRadius = viewPlayPause.frame.width / 2.0
        imgArtwork.imageFromRoundServerURL(urlString: result?.artworkUrl100)
        if let trackName = result?.trackName{
            lbTrackName.text = trackName
        }
        if let artistName = result?.artistName{
            lbArtistName.text = artistName
        }
        if let genre = result?.primaryGenreName{
            lbGenre.text = "Genre: "+genre
        }
        if let kind = result?.kind{
            lnKind.text = "Kind: "+kind
        }
        if let releaseDate = result?.releaseDate{
            lbReleaseDate.text = "Release date: "+releaseDate
        }
        if let price = result?.trackPrice{
            lbCollectionPrice.text = "Price: \(price) USD"
        }
    }
    

}

extension DetailVC:MusicPlayerDelegate,MusicPlayerProgressDelegate,MusicPlayerPlayPauseDelegate{
    func isPlaying(status: Bool, isEnd: Bool) {
        if isEnd == false{
        btnPlayPause.setImage(UIImage(named: status == false ? "play":"pause"), for: .normal)
        }else{
            btnPlayPause.setImage(UIImage(named: "play"), for: .normal)
            if let url = result?.previewUrl{
                slider.value = 0
                DispatchQueue.global().async {
                        self.musicPlayer.prepareSong(url)

                }
            }
            
        }
    }
    
    func updateTimer(timeString: String, totalTimeString: String) {
        lbStartTime.text = timeString
        lbEndTime.text = totalTimeString
    }
    
    func updateProgress(currentTime: Int, totalTime: Int) {
        slider.maximumValue = Float(totalTime)
        UIView.animate(withDuration: 1.4, animations: {
            self.slider?.value = Float(currentTime)

        self.view.layoutIfNeeded()

        })
    }
    
    
}

