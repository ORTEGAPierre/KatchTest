//
//  ViewController.swift
//  KatchTest
//
//  Created by ORTEGA Pierre on 18/12/2017.
//  Copyright © 2017 ORTEGA Pierre. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  @IBOutlet weak var subview: UIView!
  private var TabViewPlayer : [ViewPlayerKatch?] = []
  private var countView : Int = 0
  private var TabFavSong:[String]=[]
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    // Initialize the animator
    self.LoadSong()
    print(TabViewPlayer)
    self.AddPlayerView()
    
    view.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(LikeDislike)))
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  fileprivate func LoadSong (){
    let folderURL = URL(fileURLWithPath:Bundle.main.resourcePath!)
    
    do
    {
      let songPath = try FileManager.default.contentsOfDirectory(at: folderURL, includingPropertiesForKeys: nil, options: .skipsHiddenFiles)
      
      //loop through the found urls
      for song in songPath
      {
        var mySong = song.absoluteString
        
        if mySong.contains(".mp3")
        {
          let findString = mySong.components(separatedBy: "/")
          mySong = findString[findString.count-1]
          mySong = mySong.replacingOccurrences(of: "%20", with: " ")
          mySong = mySong.replacingOccurrences(of: ".mp3", with: "")
          print(mySong)
          TabViewPlayer.append(InitPlayerView(Song: mySong))
        }
        
      }
    }
    catch
    {
      print ("ERROR")
    }
  }
  fileprivate func InitPlayerView (Song:String)-> ViewPlayerKatch {
    let viewPlayer = ViewPlayerKatch()
    viewPlayer.title = Song
    viewPlayer.center = CGPoint(x: self.view.center.x, y: self.view.center.y)
    return viewPlayer
  }
  fileprivate func AddPlayerView(){
    if countView<TabViewPlayer.count {
      self.view.addSubview(self.TabViewPlayer[self.countView]!)
      UIView.animate(withDuration: 0.7, animations: {
        self.TabViewPlayer[self.countView]?.alpha=1
      })
      countView+=1
    }
  }
  fileprivate func removePlayerView(){
    if countView>=0 {
      self.TabViewPlayer[self.countView-1]?.timer.invalidate()
      self.TabViewPlayer[self.countView-1]=nil
      print(TabViewPlayer)
    }
  }
  @objc func LikeDislike(gestuer:UIPanGestureRecognizer) {
    for subview in view.subviews  {
      self.view.bringSubview(toFront: subview)
      let translation = gestuer.translation(in: self.view)
      subview.center = CGPoint(x: subview.center.x , y: subview.center.y + translation.y)
      gestuer.setTranslation(CGPoint.zero, in: self.view)
      if subview.center.y > view.center.y {
        subview.backgroundColor=UIColor(red: 213/255, green: (213 + (subview.center.y - view.center.y))/255, blue: 213/255, alpha: 1)
        
      }else if subview.center.y < view.center.y {
        subview.backgroundColor=UIColor(red: (213 + (view.center.y - subview.center.y))/255, green: 213/255, blue: 213/255, alpha: 1)
      } else {
        subview.backgroundColor = UIColor(red: 213/255, green: 213/255, blue: 213/255, alpha: 1)
      }
      if gestuer.state == UIGestureRecognizerState.ended {
        
        if subview.center.y < 110 {
          UIView.animate(withDuration: 0.7, animations: {
            subview.center = CGPoint(x: subview.center.x , y: subview.center.y - 300 )
            subview.tintColor = .red
            subview.removeFromSuperview()
          },completion: {(finished:Bool) in
            // the code you put here will be compiled once the animation finishes
            self.removePlayerView()
            self.AddPlayerView()
            
          })
          
          return
        } else if subview.center.y > (view.frame.height - 110){
          TabFavSong.append((self.TabViewPlayer[self.countView-1]?.title)!)
          UIView.animate(withDuration: 0.7, animations: {
            subview.center = CGPoint(x: subview.center.x , y: subview.center.y + 300 )
            subview.tintColor = .green
            subview.removeFromSuperview()
          },completion: {(finished:Bool) in
            // the code you put here will be compiled once the animation finishes
            self.removePlayerView()
            self.AddPlayerView()

          })
          
          return
        }else {
          subview.backgroundColor = UIColor(red: 213/255, green: 213/255, blue: 213/255, alpha: 1)
          UIView.animate(withDuration: 0.3, animations: {
            subview.center = self.view.center
          })
        }
      }
    }
  }
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier=="fav" {
      let tabViewFav = segue.destination as! TableViewFavoris
      tabViewFav.SongFavoris = self.TabFavSong
    }
  }
}

