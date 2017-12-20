//
//  ViewPlayerKatch.swift
//  KatchTest
//
//  Created by ORTEGA Pierre on 18/12/2017.
//  Copyright © 2017 ORTEGA Pierre. All rights reserved.
//

import UIKit
import AVFoundation

class ViewPlayerKatch: UIView {
  public var title : String = ""
  private var buttonPlayer = UIButton()
  private var slider = UISlider()
  private var audioPlayer = AVAudioPlayer()
  private var count = 0
  public var timer = Timer()

  @IBAction func PlayButton(_ sender: UIButton) {
    timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(TimerUpdate), userInfo: nil, repeats: true)
    self.PlayMusic()
    buttonPlayer.isEnabled=false
  }
  @objc fileprivate func TimerUpdate() {
    if count>14 {
      self.audioPlayer.stop()
      count = 0
      buttonPlayer.isEnabled=true
      slider.value=0
      timer.invalidate()
    }else {
      count+=1
      slider.value=Float(count)
    }
  }
  
  fileprivate func PlayMusic(){
    
    do {
        let audioPath = Bundle.main.path(forResource: title, ofType: ".mp3")
        try audioPlayer = AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: audioPath!) as URL)
        self.audioPlayer.play()
      } catch {
      print ("Error player")
    }
      
  }
  override init(frame: CGRect) {
    super.init(frame:frame)
    // Drawing code
    self.frame.size=CGSize(width: 234, height: 350)
    self.backgroundColor = UIColor(red: 213/255, green: 213/255, blue: 213/255, alpha: 1)
    self.alpha=0
    self.layer.cornerRadius=8
    self.layer.masksToBounds = true
    
    
    buttonPlayer = UIButton(frame: CGRect(x: 0, y: 0, width: 210, height: 31))
    buttonPlayer.center=CGPoint(x: self.center.x, y: self.center.y + 150)
    buttonPlayer.setTitle("Play", for: UIControlState.normal)
    buttonPlayer.setTitleColor(UIColor.white, for: UIControlState.normal)
    buttonPlayer.backgroundColor = UIColor(red: 177/255, green: 177/255, blue: 177/255, alpha: 1)
    buttonPlayer.layer.cornerRadius=8
    buttonPlayer.layer.borderWidth=1
    buttonPlayer.layer.borderColor=UIColor(red: 135/255, green: 135/255, blue: 135/255, alpha: 1).cgColor
    buttonPlayer.addTarget(self, action: #selector(PlayButton(_:)), for: UIControlEvents.touchUpInside)
    self.addSubview(buttonPlayer)
    
    slider = UISlider(frame: CGRect(x: 0, y: 0, width: 210, height: 29))
    slider.center=CGPoint(x: self.center.x, y: self.center.y + 80)
    slider.isEnabled = false
    slider.maximumValue=15
    slider.minimumValue=0
    slider.tintColor = .black
    self.addSubview(slider)
    
    var imageView : UIImageView
    imageView  = UIImageView(frame:CGRect(x:0, y:0, width:130, height:181));
    imageView.center=CGPoint(x: self.center.x, y: 110)
    imageView.image = UIImage(named:"Test.png")
    self.addSubview(imageView)
    
    let blurEffect = UIBlurEffect(style: .dark)
    let blurredEffectView = UIVisualEffectView(effect: blurEffect)
    blurredEffectView.frame = imageView.bounds
    blurredEffectView.center=imageView.center
    self.addSubview(blurredEffectView)
  }
  
  required init?(coder aDecoder: NSCoder) {
   super.init(coder: aDecoder)
  }
  
  


  // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
     
    }
 

}
