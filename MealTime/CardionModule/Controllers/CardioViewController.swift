//
//  CardioViewController.swift
//  MealTime
//
//  Created by Роман Елфимов on 27.05.2020.
//  Copyright © 2020 Роман Елфимов. All rights reserved.
//

import UIKit
import RealmSwift

class CardioViewController: UIViewController {

    // MARK: - Property
    var cardioArray: Results<CardioModel>!

    // MARK: - Outlet
    @IBOutlet weak var tableView: UITableView!
   
    //MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cardioArray = cardioRealm.objects(CardioModel.self)
        cardioArray = cardioArray.sorted(byKeyPath: "date", ascending: false)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            guard let newCardioVC = segue.destination as? AddNewCardioViewController else { return }
            
            let cardio = cardioArray[indexPath.row]
            newCardioVC.currentCardio = cardio
            
            newCardioVC.navigationItem.rightBarButtonItem?.title = "Изменить"
        }
    }
    
    
    // MARK: - Action
    @IBAction func unwind( _ segue: UIStoryboardSegue) {
        
        guard let newCardioVC = segue.source as? AddNewCardioViewController else {
            print("Failed to newCardioVC")
            return
        }
        
        let date = newCardioVC.getDate()
        let upperPressure = newCardioVC.getUpperPressure()
        let lowerPressure = newCardioVC.getLowerPressure()
        let heartRate = newCardioVC.getHeartRate()
        
        let newCardio = CardioModel(date: date, upperPressure: upperPressure, lowerPressure: lowerPressure, heartRate: heartRate)
        
        if newCardioVC.currentCardio != nil {
            try! cardioRealm.write {
                newCardioVC.currentCardio.date = newCardio.date
                newCardioVC.currentCardio.upperPressure = newCardio.upperPressure
                newCardioVC.currentCardio.lowerPressure = newCardio.lowerPressure
                newCardioVC.currentCardio.heartRate = newCardio.heartRate
                cardioArray = cardioArray.sorted(byKeyPath: "date", ascending: false)
            }
        } else {
            CardioStorageManager.saveObject(newCardio)
            cardioArray = cardioArray.sorted(byKeyPath: "date", ascending: false)
        }
        cardioArray = cardioArray.sorted(byKeyPath: "date", ascending: false)
        tableView.reloadData()
    }
}




// MARK: - Extension UITableViewDelegate, UITableViewDataSource
extension CardioViewController: UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cardioArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CardioCell
        
        let cardio = cardioArray[indexPath.row]
        
        cell.initCell(with: cardio)
    
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
            let cardio = cardioArray[indexPath.row]
            CardioStorageManager.deleteObject(cardio)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
