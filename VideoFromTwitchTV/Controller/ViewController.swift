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
    
    var gameIconsListArray = [String](){
        didSet{
            gamesListTableView.reloadData()
            //print(gameListArray.count)
        }
    }
    var globalIndexPathRow = 0
    
    var gameIDListArray = [String]()
    
    let streamViewController = StreamListViewController()
    
    let topGamesModel = TopGamesModel()

    // cell reuse id (cells that scroll out of view can be reused)
    let cellReuseIdentifier = "cell"
    
    
    
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
            let topGamesJSON = json["data"][gameID]["name"].stringValue
            let topGamesIconJSON = json["data"][gameID]["box_art_url"].stringValue
            let topGamesIDJSON = json["data"][gameID]["id"].stringValue
            gameListArray.append(topGamesJSON)
            gameIconsListArray.append(topGamesIconJSON.replacingOccurrences(of: "{width}x{height}", with: "150x150"))
            gameIDListArray.append(topGamesIDJSON)
        }
        
        
        //print(gameIconsListArray)
        
        
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //print(gameListArray.count)
        return gameListArray.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // create a new cell if needed or reuse an old one
        
        //let cell = tableView.dequeueReusableCell(withIdentifier: "gameCell", for: indexPath)
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "gameCell", for: indexPath) as! GameTableViewCell
        

        cell.gameName.text = gameListArray[indexPath.row]

        //cell.gameImage.image = UIImage (named: "bloodborne")
        
        tableView.rowHeight = 100.0

        cell.imageView?.downloaded(from: gameIconsListArray[indexPath.row])
        
        return cell
    }
    
    // method to run when table view cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped cell number \(indexPath.row).")
        globalIndexPathRow = indexPath.row
        //tableView.reloadData()
        performSegue(withIdentifier: "goToStreamList", sender: self)
//        streamViewController.urlString = "https://api.twitch.tv/helix/streams?game_id=\(gameIDListArray[indexPath.row])"
//
        print("globalIndexrow: \(globalIndexPathRow)")
       
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "goToStreamList"){

            if let streamVC = segue.destination as? StreamListViewController{
                streamVC.urlString = "https://api.twitch.tv/helix/streams?game_id=\(gameIDListArray[globalIndexPathRow])"

            }

        }
    }


}

//from stack
extension UIImageView {
    func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {  // for swift 4.2 syntax just use ===> mode: UIView.ContentMode
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                self.image = image
            }
            }.resume()
    }
    func downloaded(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {  // for swift 4.2 syntax just use ===> mode: UIView.ContentMode
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}
