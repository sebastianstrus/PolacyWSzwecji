//
//  BaseAuthViewController.swift
//  Polacy w Szwecji
//
//  Created by Sebastian Strus on 2019-06-11.
//  Copyright © 2019 Sebastian Strus. All rights reserved.
//

import UIKit
import AVKit

class BaseAuthViewController: UIViewController {

    private var player: AVPlayer!
    private var playerController: AVPlayerViewController!
    
    private let backgroundIV: UIImageView = {
        let iv = UIImageView(image: UIImage(named: "sweden"))
        iv.contentMode = UIView.ContentMode.scaleAspectFill
        return iv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        handleVideoInBackground()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @objc private func appEnteredBackgound() {
        //playerController.player = nil
        if let tracks = player.currentItem?.tracks {
            for track in tracks {
                if track.assetTrack!.hasMediaCharacteristic(AVMediaCharacteristic.visual) {
                    track.isEnabled = false
                }
            }
        }
    }
    
    @objc private func appEnteredForeground() {
        //playerController.player = player
        if let tracks = player.currentItem?.tracks {
            for track in tracks {
                if track.assetTrack!.hasMediaCharacteristic(AVMediaCharacteristic.visual) {
                    track.isEnabled = true
                }
            }
        }
    }
    
    private func setupView() {
        view.addSubview(backgroundIV)
        backgroundIV.pinToEdges(view: view)
        playVideo(title: "polish_flag")
        handleVideoInBackground()
    }
    
    private func playVideo(title: String) {
        let path = Bundle.main.path(forResource: title, ofType:"mov")
        player = AVPlayer(url: URL(fileURLWithPath: path!))
        playerController = AVPlayerViewController()
        playerController.player = player
        playerController.showsPlaybackControls = false
        self.addChild(playerController)
        playerController.view.frame = UIScreen.main.bounds
        playerController.view.alpha = 0.8
        playerController.videoGravity = AVLayerVideoGravity(rawValue: AVLayerVideoGravity.resizeAspectFill.rawValue)
        self.view.addSubview(playerController.view)
        player.play()
        // repead video
        NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: player.currentItem, queue: .main) { _ in
            self.player.seek(to: CMTime.zero)
            self.player.play()
        }
    }
    
    private func handleVideoInBackground() {
        NotificationCenter.default.addObserver(self, selector: #selector(appEnteredBackgound), name: UIApplication.didEnterBackgroundNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(appEnteredForeground), name: UIApplication.willEnterForegroundNotification, object: nil)
    }
    
    // fix
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        playerController.player?.pause()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        playerController.player?.play()
    }
}
