//
//  ViewController.swift
//  MealTime
//
//  Created by Роман Елфимов on 08.06.2020.
//  Copyright © 2020 Роман Елфимов. All rights reserved.
//

import UIKit

class WeightViewController: UIViewController {

    var dateArray = [""]
    var weightArray = [""]
    
    
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.reloadData()
    }
    
    
    @IBAction func unwind( _ segue: UIStoryboardSegue) {
        
        guard let newWeightVC = segue.source as? AddNewWeightTableViewController else {
            print("Failed to newWeightVC")
            return
        }
        
        let date = newWeightVC.getDateDish()
        let weight = newWeightVC.getWeight()
        dateArray.append(date)
        weightArray.append(weight)
        
        tableView.reloadData()
    }


}



extension WeightViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weightArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = dateArray[indexPath.row]
        cell.detailTextLabel?.text = weightArray[indexPath.row]
        return cell
    }
    
    
}
