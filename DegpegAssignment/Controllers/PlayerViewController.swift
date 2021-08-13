//
//  PlayerViewController.swift
//  DegpegAssignment
//
//  Created by Suraj Singh on 13/08/21.
//

import UIKit
import Foundation
import AVFoundation
import FirebaseAnalytics

class PlayerViewController: UIViewController {
    
    @IBOutlet weak var playerView: UIView!
    @IBOutlet weak var playerBackView: UIView!
    @IBOutlet weak var playerControlView: UIView!
    @IBOutlet weak var playpauseButton: UIButton!
    @IBOutlet weak var totalCountLabel: UILabel!
    
    var player: AVPlayer?
    var playerLayer: AVPlayerLayer?
    var urlM3u8: URL?
    var numberOfViews:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
                
        if let c = self.urlM3u8{
            let item = AVPlayerItem(url: urlM3u8!)
            player = AVPlayer(playerItem: item)
            playerLayer = AVPlayerLayer(player: player)
            playerLayer?.videoGravity = .resizeAspectFill
            playerLayer?.frame = CGRect(x: 0, y: 0, width: self.playerView.frame.width, height: self.playerView.frame.height)
            playerView.layer.addSublayer(playerLayer!)
            
            player?.play()
            
            self.playerView.bringSubviewToFront(self.playerBackView)
            self.playerView.bringSubviewToFront(self.playerControlView)
            
            self.playpauseButton.setImage(UIImage(named: "ic_pauseIcon"), for: .normal)
        }
        
        let defaults = UserDefaults.standard.string(forKey: "number_of_views")
        if let c = defaults{
            self.numberOfViews = Int(c)! + 1
            let defaults = UserDefaults.standard
            defaults.setValue(self.numberOfViews, forKey: "number_of_views")
            defaults.synchronize()
            
        }else{
            self.numberOfViews = self.numberOfViews + 1
            let defaults = UserDefaults.standard
            defaults.setValue(self.numberOfViews, forKey: "number_of_views")
            defaults.synchronize()
        }
        
        self.totalCountLabel.text = String(self.numberOfViews)
        
        Analytics.logEvent("number_of_views", parameters: [
          "count": self.numberOfViews as NSObject,
        ])
        
        
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        if (UIDevice.current.orientation.isLandscape) {
            playerLayer?.frame = CGRect(x: -48, y: 0, width: size.width, height: size.height)
        }else{
            playerLayer?.frame = CGRect(x: 0, y: 0, width: size.width, height: 250)
        }
    }
    
    var isPlayPause = false
    @IBAction func playPauseButtonFunc(_ sender: Any) {
        if self.isPlayPause == false{
            self.isPlayPause = true
            self.playpauseButton.setImage(UIImage(named: "ic_play"), for: .normal)
            self.player?.pause()
        }else{
            self.isPlayPause = false
            self.playpauseButton.setImage(UIImage(named: "ic_pauseIcon"), for: .normal)
            self.player?.play()
        }
    }
    
    @IBAction func dismissButtonFunc(_ sender: Any) {
        //self.player?.pause()
        self.dismiss(animated: false, completion: nil)
    }
    
    override var shouldAutorotate: Bool {
        return true
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
}
