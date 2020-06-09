//
//  ViewController.swift
//  MealTime
//
//  Created by Роман Елфимов on 08.06.2020.
//  Copyright © 2020 Роман Елфимов. All rights reserved.
//

import UIKit
import RealmSwift

class WeightViewController: UIViewController {

    //MARK: - Property
    var weightArray: Results<WeightModel>!
    
    //MARK: - Outlet
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - Override methods
    override func viewDidLoad() {
        super.viewDidLoad()

        weightArray = weightRealm.objects(WeightModel.self)
        weightArray = weightArray.sorted(byKeyPath: "date", ascending: false)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            guard let newWeightVC = segue.destination as? AddNewWeightTableViewController else { return }
            
            let weight = weightArray[indexPath.row]
            newWeightVC.currentWeight = weight
            
            newWeightVC.navigationItem.rightBarButtonItem?.title = "Изменить"
        }
    }
    
    
    //MARK: - Actions
    @IBAction func unwind( _ segue: UIStoryboardSegue) {
        
        guard let newWeightVC = segue.source as? AddNewWeightTableViewController else {
            print("Failed to newWeightVC")
            return
        }
        
        let date = newWeightVC.getDate()
        let weight = newWeightVC.getWeight()
   
        let newWeight = WeightModel(date: date, weight: weight)
        
        if newWeightVC.currentWeight != nil {
            try! weightRealm.write {
                newWeightVC.currentWeight.date = newWeight.date
                newWeightVC.currentWeight.myWeight = newWeight.myWeight
                weightArray = weightArray.sorted(byKeyPath: "date", ascending: false)
            }
        } else {
            WeightStorageManager.saveObject(newWeight)
            weightArray = weightArray.sorted(byKeyPath: "date", ascending: false)
        }
        
        weightArray = weightArray.sorted(byKeyPath: "date", ascending: false)
        tableView.reloadData()
    }
}



//MARK: - Extension
extension WeightViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weightArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! WeightCell
    
        let weight = weightArray[indexPath.row]
        
        cell.initCell(with: weight)       
        
        return cell
    }
    
    //MARK: - TableViewDelegate
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "Удалить"
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let weight = weightArray[indexPath.row]
            WeightStorageManager.deleteObject(weight)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
