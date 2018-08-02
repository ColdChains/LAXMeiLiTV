//
//  LiveDetailViewController.swift
//  MeiLiTV
//
//  Created by 冰凉的枷锁 on 2017/4/18.
//  Copyright © 2017年 冰凉的枷锁. All rights reserved.
//

import UIKit
import AVFoundation

class LiveRoomViewController: UIViewController {
    
    // MARK: - Property
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var playerView: UIView!
    @IBOutlet weak var noLiveView: UIView!
    // 顶部约束
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    // 横屏菜单
    @IBOutlet weak var menuViewH: UIView!
    // 弹幕
    @IBOutlet weak var barrageView: BarrageView!
    // 竖屏菜单
    @IBOutlet weak var menuViewV: UIView!
    // 加载视图
    @IBOutlet weak var loadingView: LiveLoadingView!
    @IBOutlet weak var loadingImageView: UIImageView!
    @IBOutlet weak var loadingLabel: UILabel!
    
    
    @IBOutlet weak var liveChatTableView: LiveChatTableView!
    
    @IBOutlet weak var roomNameLabel: UILabel!
    @IBOutlet weak var roomID: UILabel!
    @IBOutlet weak var roomOnline: UILabel!
    @IBOutlet weak var roomNameLabel2: UILabel!
    @IBOutlet weak var roomID2: UILabel!
    @IBOutlet weak var roomOnline2: UILabel!
    
    
    var isVertical = true
    var cellId = "ChatTableViewCell"
    // 直播房间
    var roomModel: RoomModel?
    // 数据源模型
    var liveRoomResultModel = LiveRoomResultModel.init()
    // 视频播放
    let player = AVPlayer.init()
    var playerLayer: AVPlayerLayer?
    var playerItem: AVPlayerItem?
    // 存放聊天信息数组
    var dataArr = [LiveChatModel]()
    // 菜单显示定时器
    var timer: Timer?
    // 视频播放定时器
    var playerTimer: LAXTimerManager?
    // 视频流畅度
    var videoKeepUpCounter = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // 点击playerView 显示菜单
        playerView.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(self.showMenuView)))
        noLiveView.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(self.showMenuView)))
        menuViewV.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(self.hideMenuView)))
        menuViewH.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(self.hideMenuView)))
        
        liveChatTableView.barrage = barrageView
//        liveChatTableView.danmu = menuViewH
        liveChatTableView.roomModel = roomModel
        liveChatTableView.initView()
        
        // 监听切换横竖屏
        playerView.addObserver(self, forKeyPath: "bounds", options: .new, context: nil)
        
//        [[NSNotificationCenter defaultCenter] addObserver:self
//            
//            selector:@selector(enterBcakground:)
//            
//            name:UIApplicationWillResignActiveNotification
//            
//            object:nil]; //进入后台
//        
//        [[NSNotificationCenter defaultCenter] addObserver:self
//            
//            selector:@selector(enterPlayGround:)
//            
//            name:UIApplicationDidBecomeActiveNotification
//            
//            object:nil]; // 返回前台
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "bounds" {
            
            playerLayer?.frame = playerView.bounds
            
            if UIScreen.main.bounds.width > UIScreen.main.bounds.height {
                isVertical = false
                topConstraint.constant = 0
                // 显示弹幕
                barrageView.startDanmu()
            } else {
                isVertical = true
                topConstraint.constant = 20
                // 隐藏弹幕
                barrageView.stopDanmu()
            }
            
            showMenuView()
        } else if keyPath == "status" {
            // 检测视频播放状态 网络等问题造成视频加载失败的情况
            if player.status == .failed || player.status == .unknown {
                startPlayer()
            } else {
                self.loadingView.isHidden = true
            }
        } else if keyPath == "playbackLikelyToKeepUp" {
            if let item = self.player.currentItem {
                if item.isPlaybackLikelyToKeepUp {
                    self.videoKeepUpCounter = 0
                    self.loadingView.isHidden = true
                } else {
                    self.videoKeepUpCounter += 1
                    if self.videoKeepUpCounter > 2 && self.videoKeepUpCounter < 6 {
//                        self.startPlayer()
//                        self.requestLiveData()
                        // 加载动画
                        loadingImageView.animationImages = [UIImage.init(named: "image_loading_player01")!, UIImage.init(named: "image_loading_player02")!, UIImage.init(named: "image_loading_player03")!]
                        loadingImageView.animationDuration = 1;
                        loadingImageView.startAnimating()
                        self.loadingView.isHidden = false
                    }
                    if self.videoKeepUpCounter > 5 {
                        self.videoKeepUpCounter = 0
                        self.startPlayer()
//                        self.requestLiveData()
                    }
                }
            }
        } else if keyPath == "loadedTimeRanges" {
//            print("缓冲===\(CMTimeGetSeconds((playerItem?.duration)!))")
//            NSTimeInterval timeInterval = [self availableDuration];// 计算缓冲进度
//            CMTime duration = self.videoPlayItem.duration;
//            CGFloat totalDuration = CMTimeGetSeconds(duration);
//            [self.videoProgressView setProgress:timeInterval / totalDuration animated:YES];
        } else if keyPath == "playbackBufferEmpty" {
//            if playerItem!.isPlaybackBufferEmpty {
//                startPlayer()
//            }
        }
    }
    
    deinit {
        playerView.removeObserver(self, forKeyPath: "bounds")
        playerItem?.removeObserver(self, forKeyPath: "status")
        playerItem?.removeObserver(self, forKeyPath: "loadedTimeRanges")
        playerItem?.removeObserver(self, forKeyPath: "playbackBufferEmpty")
        playerItem?.removeObserver(self, forKeyPath: "playbackLikelyToKeepUp")
        endPlayer()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.setStatusBarStyle(.default, animated: true)
        UIApplication.shared.isIdleTimerDisabled = true
        requestLiveData()
        liveChatTableView.startLiveChat()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        UIApplication.shared.setStatusBarStyle(.lightContent, animated: true)
        UIApplication.shared.isIdleTimerDisabled = false
        endPlayer()
        liveChatTableView.endLiveChat()
        barrageView.stopDanmu()
    }
    
    // 请求视频数据
    func requestLiveData() {
        if roomModel == nil {
            return
        }
        // 加载动画
        loadingImageView.animationImages = [UIImage.init(named: "image_loading_player01")!, UIImage.init(named: "image_loading_player02")!, UIImage.init(named: "image_loading_player03")!]
        loadingImageView.animationDuration = 1;
        loadingImageView.startAnimating()
        self.loadingView.isHidden = false
        
        MainViewModel.getLiveRoomData(roomId: "\(roomModel!.room_id)", successBlock: { (model) in
            
            self.noLiveView.isHidden = true
            
            self.liveRoomResultModel = model
            self.startPlayer()
            
            if let name = model.data?.room_name {
                self.roomNameLabel.text = name
                self.roomNameLabel2.text = name
            }
            if let id = model.data?.room_id {
                self.roomID.text = "房间:" + id
                self.roomID2.text = "房间:" + id
            }
            if let online = model.data?.online {
                self.roomOnline.text = "人气:" + "\(online)"
                self.roomOnline2.text = "人气:" + "\(online)"
            }
            
        }) { (error) in
            self.loadingView.isHidden = true
            self.noLiveView.isHidden = false
            self.showAlertLabelView(message: "主播离开了，请稍后再来吧")
        }
    }
    
    // 开始播放直播内容
    func startPlayer() {
        // 加载动画
        self.loadingImageView.animationImages = [UIImage.init(named: "image_loading_player01")!, UIImage.init(named: "image_loading_player02")!, UIImage.init(named: "image_loading_player03")!]
        self.loadingImageView.animationDuration = 1;
        self.loadingImageView.startAnimating()
        self.loadingView.isHidden = false
        
        if let data = liveRoomResultModel.data {
            if let str = data.hls_url {
                if URL.init(string: str) == nil {
                    noLiveView.isHidden = false
                    loadingView.isHidden = true
                    return
                }
                
                playerItem?.removeObserver(self, forKeyPath: "status")
                playerItem?.removeObserver(self, forKeyPath: "loadedTimeRanges")
                playerItem?.removeObserver(self, forKeyPath: "playbackBufferEmpty")
                playerItem?.removeObserver(self, forKeyPath: "playbackLikelyToKeepUp")
                
                playerItem = AVPlayerItem.init(url: URL.init(string: str)!)
                player.replaceCurrentItem(with: playerItem)
                playerLayer = AVPlayerLayer.init(player: player)
                playerLayer?.frame = playerView.bounds
                playerView.layer.addSublayer(playerLayer!)
                player.play()
                
                
                // 监听视频播放状态  //预播放状态，有三种情况AVPlayerItemStatusUnknown,AVPlayerItemStatusReadyToPlay,AVPlayerItemStatusFailed
                playerItem?.addObserver(self, forKeyPath: "status", options: .new, context: nil)
                //缓冲进度，可有可无，可以增加用户体验
                playerItem?.addObserver(self, forKeyPath: "loadedTimeRanges", options: .new, context: nil)
                //seekToTime后，缓冲数据为空，而且有效时间内数据无法补充，播放失败
                playerItem?.addObserver(self, forKeyPath: "playbackBufferEmpty", options: .new, context: nil)
                //seekToTime后,可以正常播放，相当于readyToPlay，一般拖动滑竿菊花转，到了这个这个状态菊花隐藏
                playerItem?.addObserver(self, forKeyPath: "playbackLikelyToKeepUp", options: .new, context: nil)
                
//                playerTimer = LAXTimerManager.init(interval: 1, doSomething: { 
//                    if self.playerItem!.isPlaybackBufferEmpty {
//                        self.startPlayer()
//                    }
//                })
            }
        }
    }
    // 结束直播
    func endPlayer() {
        player.pause()
        playerLayer?.removeFromSuperlayer()
        
//        if playerTimer != nil {
//            playerTimer?.invalidateTimer()
//            playerTimer = nil
//        }
//        if playerLayer != nil {
//        }
    }
    // 点击显示菜单
    func showMenuView() {
        timer?.invalidate()
        timer = nil
        menuViewV.isHidden = true
        menuViewH.isHidden = true
        if isVertical {
            menuViewV.isHidden = false
        } else {
            menuViewH.isHidden = false
        }
        // timer 不为空 定时器没有结束 重新创建定时器
        timer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(self.hideMenuView), userInfo: nil, repeats: false)
    }
    // 隐藏菜单
    func hideMenuView() {
        timer?.invalidate()
        timer = nil
        if isVertical {
            menuViewV.isHidden = true
        } else {
            menuViewH.isHidden = true
        }
    }
    
    // MARK: - IBAction
    // 竖屏时返回到上一页
    @IBAction func backActionV(_ sender: UIButton) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    // 竖屏菜单按钮 刷新事件
    @IBAction func refreshAction(_ sender: UIButton) {
        requestLiveData()
//        startPlayer()
    }
    // 收藏事件
    @IBAction func collectionAction(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }
    // 暂停事件
    @IBAction func pauseAction(_ sender: UIButton) {
        if sender.isSelected {
            player.pause()
        } else {
            startPlayer()
        }
        sender.isSelected = !sender.isSelected
    }
    // 全屏按钮事件
    @IBAction func fillScreenAction(_ sender: UIButton) {
        UIDevice.current.setValue(UIDeviceOrientation.landscapeRight.rawValue, forKey: "orientation")
    }
    // 关注按钮事件
    @IBAction func attentionAction(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }
    // 横屏菜单按钮 返回到竖屏
    @IBAction func backActionH(_ sender: UIButton) {
        UIDevice.current.setValue(UIDeviceOrientation.portrait.rawValue, forKey: "orientation")
    }
    // 弹幕按钮
    @IBAction func danmuAction(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected {
            barrageView.stopDanmu()
        } else {
            barrageView.startDanmu()
        }
    }
    
}
