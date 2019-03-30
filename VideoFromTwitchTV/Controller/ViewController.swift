//
//  ViewController.swift
//  VideoFromTwitchTV
//
//  Created by Mariusz Gil on 29/03/2019.
//  Copyright © 2019 Mariusz Gil. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    
    // Data model: These strings will be the data for the table view cells
    var gameListArray = [String](){
        didSet{
            gamesListTableView.reloadData()
            //print(gameListArray.count)
        }
    }
//    let gameViewersArray: [String] = ["1111111 widzów", "112221 widzów", "11333111 widzów", "11166611 widzów", "1113311 widzów"]
    
    let topGamesModel = TopGamesModel()

    // cell reuse id (cells that scroll out of view can be reused)
    let cellReuseIdentifier = "cell"
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var gamesListTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getTopGames()
        
        gamesListTableView.register(UINib(nibName: "GameTableViewCell", bundle: nil), forCellReuseIdentifier: "gameCell")
        
        gamesListTableView.delegate = self
        gamesListTableView.dataSource = self
        
        
        //print(gameListArray)
        
    }
    
    func getTopGames(){
        let clientID = "gw295s3e3vw3l0ti4wtnj1wuw52e4n"
        
        let urlString = "https://api.twitch.tv/helix/games/top"
        
        let headers: HTTPHeaders = [
            "Client-ID": clientID
        ]
        
        AF.request(urlString, headers: headers).responseJSON { response in
            
            
            if response.result.isSuccess{
                //debugPrint(response)
                let topGamesJSON = JSON(response.result.value!)
                self.readTopGamesJSON(json: topGamesJSON)
            }
            else{
                print("connection issues")
            }
            
        }
        
    }
    
    func readTopGamesJSON(json: JSON){
        //print(json)
        
        for gameID in 0...15{
            let topGamesJSONArray = json["data"][gameID]["name"].stringValue
           
            gameListArray.append(topGamesJSONArray)
            
        }
        
        //print(gameListArray)
        
        
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(gameListArray.count)
        return gameListArray.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // create a new cell if needed or reuse an old one
        
        //let cell = tableView.dequeueReusableCell(withIdentifier: "gameCell", for: indexPath)
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "gameCell", for: indexPath) as! GameTableViewCell
        
        // set the text from the data model
        //cell.textLabel?.text = self.gameListArray[indexPath.row]
        cell.gameName.text = gameListArray[indexPath.row]
        //cell.gameViewers.text = topGamesModel.gameViewersArray[indexPath.row]
        cell.gameImage.image = UIImage (named: "bloodborne")
        
        tableView.rowHeight = 100.0
        
        return cell
    }
    
    // method to run when table view cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped cell number \(indexPath.row).")
        tableView.reloadData()
        //performSegue(withIdentifier: "goToVideoView", sender: self)
    }
    


}

