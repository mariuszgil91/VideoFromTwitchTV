//
//  VideoViewController.swift
//  VideoFromTwitchTV
//
//  Created by Mariusz Gil on 29/03/2019.
//  Copyright © 2019 Mariusz Gil. All rights reserved.
//

import UIKit

class StreamListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "streamCell", for: indexPath)
        
        return cell
    }

}
