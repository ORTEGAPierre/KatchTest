//
//  TableViewFavoris.swift
//  KatchTest
//
//  Created by ORTEGA Pierre on 20/12/2017.
//  Copyright © 2017 ORTEGA Pierre. All rights reserved.
//

import UIKit
import AVFoundation
class TableViewFavoris: UIViewController , UITableViewDelegate, UITableViewDataSource{
 
  
  @IBOutlet weak var TableFav: UITableView!
  public var SongFavoris:[String]=[]
  private var audioPlayer = AVAudioPlayer()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
  {
    return SongFavoris.count
  }
  
  @IBAction func PauseAction(_ sender: Any) {
    if SongFavoris.count>0{
      audioPlayer.stop()
    }
  }
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
  {
    let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "cell")
    cell.textLabel?.text = SongFavoris[indexPath.row]
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
  {
    do
    {
      let audioPath = Bundle.main.path(forResource: SongFavoris[indexPath.row], ofType: ".mp3")
      try audioPlayer = AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: audioPath!) as URL)
      audioPlayer.play()

    }
    catch
    {
      print ("Error player")
    }
  }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
