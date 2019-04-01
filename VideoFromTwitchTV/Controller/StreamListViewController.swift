//
//  VideoViewController.swift
//  VideoFromTwitchTV
//
//  Created by Mariusz Gil on 29/03/2019.
//  Copyright © 2019 Mariusz Gil. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class StreamListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        getTopStreams()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "streamCell", for: indexPath)
        
        return cell
    }

    func getTopStreams(){
        let clientID = "gw295s3e3vw3l0ti4wtnj1wuw52e4n"
        
        let urlString = "https://api.twitch.tv/helix/streams?game_id=33214"
        
        let headers: HTTPHeaders = [
            "Client-ID": clientID
        ]
        
        AF.request(urlString, headers: headers).responseJSON { response in
            
            
            if response.result.isSuccess{
                //debugPrint(response)
                let topStreamsJSON = JSON(response.result.value!)
                self.readTopStreamsJSON(json: topStreamsJSON)
            }
            else{
                print("connection issues")
                
            }
            
        }
        
    }
    
    func readTopStreamsJSON(json: JSON){
        //print(json)
        
//        for gameID in 0...15{
//            let topGamesJSON = json["data"][gameID]["name"].stringValue
//            let topGamesIconJSON = json["data"][gameID]["box_art_url"].stringValue
//            
//        }
        
        
        
        
        
    }
    
}
