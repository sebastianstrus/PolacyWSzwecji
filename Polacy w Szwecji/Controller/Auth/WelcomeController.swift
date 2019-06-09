//
//  ViewController.swift
//  Polacy w Szwecji
//
//  Created by Sebastian Strus on 2019-06-01.
//  Copyright © 2019 Sebastian Strus. All rights reserved.
//

import UIKit
import AVKit

class WelcomeController: UIViewController {

    var player: AVPlayer!
    var playerController: AVPlayerViewController!
    
    
    func playVideo(title: String) {
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
    
    fileprivate var welcomeView: WelcomeView!
    
    let backgroundIV: UIImageView = {
        let iv = UIImageView(image: UIImage(named: "sweden"))
        iv.contentMode = UIView.ContentMode.scaleAspectFill
        return iv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(self, selector: #selector(appEnteredBackgound), name: UIApplication.didEnterBackgroundNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(appEnteredForeground), name: UIApplication.willEnterForegroundNotification, object: nil)
        view.addSubview(backgroundIV)
        backgroundIV.pinToEdges(view: view)
        playVideo(title: "polish_flag")
        setupView()
    }

    @objc func appEnteredBackgound() {
        //playerController.player = nil
        if let tracks = player.currentItem?.tracks {
            for track in tracks {
                if track.assetTrack!.hasMediaCharacteristic(AVMediaCharacteristic.visual) {
                    track.isEnabled = false
                }
            }
        }
    }
    
    @objc func appEnteredForeground() {
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
        welcomeView = WelcomeView()
        view.addSubview(welcomeView)
        welcomeView.pinToEdges(view: view)
        welcomeView.fbAction = handleFB
        welcomeView.googleAction = handleGoogle
        welcomeView.creteAccountAction = handleCreateAccount
    }
    
    private func handleFB() {
    }
    
    private func handleGoogle() {
    }
    
    private func handleCreateAccount() {
    }
}


extension UIButton {
    
    public convenience init(title: String, color: UIColor?, filled: Bool) {
        self.init()
        let attributedString = NSMutableAttributedString(attributedString: NSAttributedString(string: title, attributes: [NSAttributedString.Key.font: AppFonts.BTN_FONT!, .foregroundColor: UIColor.white]))
        self.setAttributedTitle(attributedString, for: .normal)
        self.layer.cornerRadius = Device.IS_IPHONE ? 30 : 60
        self.layer.borderWidth = 2
        self.layer.borderColor = color?.cgColor
        self.backgroundColor = filled ? color : .clear
        self.setAnchor(width: 0, height: Device.IS_IPHONE ? 60 : 120)
    }
    
}
