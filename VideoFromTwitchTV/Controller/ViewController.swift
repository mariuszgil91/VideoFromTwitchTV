//
//  ViewController.swift
//  VideoFromTwitchTV
//
//  Created by Mariusz Gil on 29/03/2019.
//  Copyright © 2019 Mariusz Gil. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    // Data model: These strings will be the data for the table view cells
    let gameListArray: [String] = ["DOTA", "Fortnite", "League of Legend", "Sekiro", "Bloodborne"]
    let gameViewersArray: [String] = ["1111111 widzów", "112221 widzów", "11333111 widzów", "11166611 widzów", "1113311 widzów"]
    
    // cell reuse id (cells that scroll out of view can be reused)
    let cellReuseIdentifier = "cell"
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var gamesListTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gamesListTableView.register(UINib(nibName: "GameTableViewCell", bundle: nil), forCellReuseIdentifier: "gameCell")
        
        gamesListTableView.delegate = self
        gamesListTableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gameListArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // create a new cell if needed or reuse an old one
        
        //let cell = tableView.dequeueReusableCell(withIdentifier: "gameCell", for: indexPath)
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "gameCell", for: indexPath) as! GameTableViewCell
        
        // set the text from the data model
        //cell.textLabel?.text = self.gameListArray[indexPath.row]
        cell.gameName.text = gameListArray[indexPath.row]
        cell.gameViewers.text = gameViewersArray[indexPath.row]
        
        tableView.rowHeight = 100.0
        
        return cell
    }
    
    // method to run when table view cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped cell number \(indexPath.row).")
        //performSegue(withIdentifier: "goToVideoView", sender: self)
    }

}

