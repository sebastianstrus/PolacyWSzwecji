//
//  RestorePasswordController.swift
//  Polacy w Szwecji
//
//  Created by Sebastian Strus on 2019-06-09.
//  Copyright © 2019 Sebastian Strus. All rights reserved.
//

import UIKit
import AVKit

class RestorePasswordController: UIViewController {

    var player: AVPlayer!
    var playerController: AVPlayerViewController!
    
    private var yCenterAnchor: NSLayoutConstraint!
    private var yUpAnchor: NSLayoutConstraint!
    
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
    
    fileprivate var restorePasswordView: RestorePasswordView!
    
    let backgroundIV: UIImageView = {
        let iv = UIImageView(image: UIImage(named: "sweden"))
        iv.contentMode = UIView.ContentMode.scaleAspectFill
        return iv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        handleKeyboard()
        
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
        restorePasswordView = RestorePasswordView()
        view.addSubview(restorePasswordView)
        restorePasswordView.pinToEdges(view: view)
        restorePasswordView.cancelAction = handleCancel
    }
    
    func handleCancel() {
        dismiss(animated: true)
    }
    
    // MARK: - Private functions
    private func handleKeyboard() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    @objc fileprivate func keyboardWillShow(_ notification: Notification) {
        restorePasswordView.handleKeyboardUp()
    }
    
    @objc fileprivate func keyboardWillHide(notification: NSNotification) {
        restorePasswordView.handleKeyboardDown()
    }

}
