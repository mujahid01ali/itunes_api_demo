//
//  MusicPlayer.swift
//  Song List Demo
//
//  Created by Mujahid on 09/09/20.
//  Copyright © 2020 Mujahid. All rights reserved.
//

import UIKit
import AVFoundation
import MediaToolbox
import MediaPlayer
protocol MusicPlayerDelegate {
    func updateTimer(timeString:String,totalTimeString:String)
}
protocol MusicPlayerProgressDelegate {
    func updateProgress(currentTime:Int,totalTime:Int)
}
protocol MusicPlayerPlayPauseDelegate {
    func isPlaying(status:Bool,isEnd:Bool)
}



class MusicPlayer: NSObject {

    static let player = MusicPlayer()

    //this is global variable
    var player:AVPlayer?
    var playerItem:AVPlayerItem?
    var isPlaying:Bool = false
    var timer:Timer?
    var timeString:String?
    var totalTimeString:String?
    var delegate:MusicPlayerDelegate?
    var delegatePlayPause:MusicPlayerPlayPauseDelegate?
    var delegateProgress:MusicPlayerProgressDelegate?
    
    
    func prepareSong(_ musicUrl:String?){
        if let mm = musicUrl {
            guard let url = URL(string: mm) else {
                print("error to get the mp3 file")
                return
            }
            do {
                playerItem = AVPlayerItem(url: url)
                player = AVPlayer(playerItem: playerItem)
                NotificationCenter.default.addObserver(self, selector:#selector(self.playerDidFinishPlaying(note:)),name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: player?.currentItem)
                
                
            }
            

        }
    }
    func playMusic() {
        if isPlaying{
            player?.pause()
            isPlaying = false
            delegatePlayPause?.isPlaying(status: isPlaying, isEnd: false)
        }else{
            player?.play()
            isPlaying = true
            delegatePlayPause?.isPlaying(status: isPlaying, isEnd: false)
            
        }
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
        
        
        
    }
    
    @objc func playerDidFinishPlaying(note: NSNotification){
        
        delegatePlayPause?.isPlaying(status: false, isEnd: true)
        
    }
    @objc func updateTime() {
        // current tine
        var currentTime:String = ""
        if let time = player?.currentTime().seconds{
            currentTime = String(format: "%.0f", time)
        }
        
        let currentMinutes = (Int(currentTime) ?? 0)/60
        let currentSeconds = (Int(currentTime) ?? 0) - currentMinutes * 60
        //==============================
        
        // Total Time
        var totalTime:String = ""
        if let time = playerItem?.duration.seconds{
            totalTime = String(format: "%.0f", time)
        }
        let totalMinutes = (Int(totalTime) ?? 0)/60
        let totalSeconds = (Int(totalTime) ?? 0) - totalMinutes * 60
        //====================
        
            
        timeString = String(format: "%02d:%02d", currentMinutes,currentSeconds) as String
        totalTimeString = String(format: "%02d:%02d", totalMinutes,totalSeconds) as String
        delegate?.updateTimer(timeString: timeString ?? "--:--", totalTimeString: totalTimeString ?? "--:--")
        delegateProgress?.updateProgress(currentTime: Int(currentTime) ?? 0, totalTime: Int(totalTime) ?? 0)
        
        
    }
    
    

}


