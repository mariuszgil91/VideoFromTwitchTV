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

    
    @IBOutlet weak var streamListTableView: UITableView!
    
    var urlString = ""
    var topStreamsUserNameArray = [String](){
        didSet{
            streamListTableView.reloadData()
        }
    }
    var topStreamsViewersCountArray = [String]()
    var topStreamsThumbnailsArray = [String]()
    
    //let streamListCell = StreamListTableViewCell()

    override func viewDidLoad() {
        super.viewDidLoad()
        //print("url: \(urlString)")
        // Do any additional setup after loading the view.streamCell
        
        
 
        streamListTableView.register(UINib(nibName: "StreamListTableViewCell", bundle: nil), forCellReuseIdentifier: "streamCell")
        streamListTableView.delegate = self
        streamListTableView.dataSource = self
        
        getTopStreams()
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return topStreamsUserNameArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "streamCell", for: indexPath) as! StreamListTableViewCell
        
        cell.streamerNameLabel.text = topStreamsUserNameArray[indexPath.row]
        cell.streamViewersLabel.text = topStreamsViewersCountArray[indexPath.row] + " viewers"
        cell.imageView?.downloaded(from: topStreamsThumbnailsArray[indexPath.row])
        
        
        tableView.rowHeight = 200
        return cell
    }

    func getTopStreams(){
        
        let clientID = "gw295s3e3vw3l0ti4wtnj1wuw52e4n"
        
        
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
        
        for streamID in 0...15{
            let topStreamsUserNameJSON = json["data"][streamID]["user_name"].stringValue
            let topStreamsViewersCountJSON = json["data"][streamID]["viewer_count"].stringValue
            let topStreamThumbnailsJSON = json["data"][streamID]["thumbnail_url"].stringValue
            
            topStreamsUserNameArray.append(topStreamsUserNameJSON)
            topStreamsViewersCountArray.append(topStreamsViewersCountJSON)
            topStreamsThumbnailsArray.append(topStreamThumbnailsJSON.replacingOccurrences(of: "{width}x{height}", with: "350x150"))
            
        }
        
        
        
        
        
    }
    
}

