//
//  ViewController.swift
//  MealTime
//
//  Created by Роман Елфимов on 15.05.2020.
//  Copyright © 2020 Роман Елфимов. All rights reserved.
//

import UIKit
import RealmSwift

class MainViewController: UIViewController {
    
    // MARK: - Properties
    // Каждый массив отвечает за отдельную вкладку в segmentedControll
    var breakfastArray: Results<BreakfastModel>!
    var dinnerArray: Results<DinnerModel>!
    var supperArray: Results<SupperModel>!
    var lunchArray: Results<LunchModel>!

    
    // MARK: - Outlets
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var tableIView: UITableView!
    
    
    // MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
    
        breakfastArray = breakfastRealm.objects(BreakfastModel.self)
        dinnerArray = dinnerRealm.objects(DinnerModel.self)
        supperArray = supperRealm.objects(SupperModel.self)
        lunchArray = lunchRealm.objects(LunchModel.self)
    }
    
    // Navigation
    //Готовимся перейти на NewDishVC и передаем в него информацию в зависимости от segmentedControl
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            guard let indexPath = tableIView.indexPathForSelectedRow else { return }
            guard let newDishVC = segue.destination as? NewDishViewController else { return }
            
            switch segmentedControl.selectedSegmentIndex {
            case 0:
                let breakfastDish = breakfastArray[indexPath.row]
                newDishVC.breakfastCurrentObject = breakfastDish
            case 1:
                let dinnerDish = dinnerArray[indexPath.row]
                newDishVC.dinnerCurrentObject = dinnerDish
            case 2:
                let supperDish = supperArray[indexPath.row]
                newDishVC.supperCurrentObject = supperDish
            case 3:
                let lunchDish = lunchArray[indexPath.row]
                newDishVC.lunchCurrentObject = lunchDish
            default:
                print("default prepare")
            }
        }
    }
    
    
    // MARK: -  Actions
    // Передача данных между контроллерами реализрвана с помощью unwind segue. Связь с unwind на кнопке сохранить
    @IBAction func unwind( _ seg: UIStoryboardSegue) {
        
        // Добираемся до NewDishTableViewController
        guard let newDishVC = seg.source as? NewDishViewController else {
            print("Failed to newDishVC")
            return
        }
        
        //Получаем из NewDishViewController свойства для заполнения моделей
        let dateDish = newDishVC.getDateDish()
        let dish = newDishVC.getDish()
        let weight = newDishVC.getWeight()
        let calories = newDishVC.getCalories()
        
        // В зависимости от segmentedControl пишем данные в выбранный массив
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            let newBreakfastDish = BreakfastModel(dateDish: dateDish, dish: dish, weight: weight, calories: calories)
            
            if newDishVC.breakfastCurrentObject != nil {
                try! breakfastRealm.write {
                    newDishVC.breakfastCurrentObject.dateDish = newBreakfastDish.dateDish
                    newDishVC.breakfastCurrentObject.dish = newBreakfastDish.dish
                    newDishVC.breakfastCurrentObject.weight = newBreakfastDish.weight
                    newDishVC.breakfastCurrentObject.calories = newBreakfastDish.calories
                }
            } else {
                BreakfastStorageManager.saveObject(newBreakfastDish)
            }
            
        case 1:
            let newDinnerDish = DinnerModel(dateDish: dateDish, dish: dish, weight: weight, calories: calories)
            
            if newDishVC.dinnerCurrentObject != nil {
                try! dinnerRealm.write {
                    newDishVC.dinnerCurrentObject.dateDish = newDinnerDish.dateDish
                    newDishVC.dinnerCurrentObject.dish = newDinnerDish.dish
                    newDishVC.dinnerCurrentObject.weight = newDinnerDish.weight
                    newDishVC.dinnerCurrentObject.calories = newDinnerDish.calories
                }
            } else {
                DinnerStorageManager.saveObject(newDinnerDish)
            }
            
        case 2:
            let newSupperDish = SupperModel(dateDish: dateDish, dish: dish, weight: weight, calories: calories)
            
            if newDishVC.supperCurrentObject != nil {
                try! supperRealm.write {
                    newDishVC.supperCurrentObject.dateDish = newSupperDish.dateDish
                    newDishVC.supperCurrentObject.dish = newSupperDish.dish
                    newDishVC.supperCurrentObject.weight = newSupperDish.weight
                    newDishVC.supperCurrentObject.calories = newSupperDish.calories
                }
            } else {
                SupperStorageManager.saveObject(newSupperDish)
            }
            
        case 3:
            let newLunchDish = LunchModel(dateDish: dateDish, dish: dish, weight: weight, calories: calories)
            
            if newDishVC.lunchCurrentObject != nil {
                try! lunchRealm.write {
                    newDishVC.lunchCurrentObject.dateDish = newLunchDish.dateDish
                    newDishVC.lunchCurrentObject.dish = newLunchDish.dish
                    newDishVC.lunchCurrentObject.weight = newLunchDish.weight
                    newDishVC.lunchCurrentObject.calories = newLunchDish.calories
                }
            } else {
                LunchStorageManager.saveObject(newLunchDish)
            }
            
        default:
            print("default unwind")
        }
    
        tableIView.reloadData()
    }
    
    
    @IBAction func segmentedControllAction(_ sender: UISegmentedControl) {
        tableIView.reloadData()
    }
    
}


// MARK: - Extension UITableViewDelegate, UITableViewDataSource

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            return breakfastArray.count
        case 1:
            return dinnerArray.count
        case 2:
            return supperArray.count
        case 3:
            return lunchArray.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! DishesTableViewCell
        
        var dish: AnyObject
        
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            dish = breakfastArray[indexPath.row]
            cell.initCell(with: dish)
        case 1:
            dish = dinnerArray[indexPath.row]
            cell.initCell(with: dish)
        case 2:
            dish = supperArray[indexPath.row]
            cell.initCell(with: dish)
        case 3:
            dish = lunchArray[indexPath.row]
            cell.initCell(with: dish)
        default:
            print("default cellForRowAt")
        }
        
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
            
            switch segmentedControl.selectedSegmentIndex {
            case 0:
                let dish = breakfastArray[indexPath.row]
                BreakfastStorageManager.deleteObject(dish)
                tableView.deleteRows(at: [indexPath], with: .fade)
            case 1:
                let dish = dinnerArray[indexPath.row]
                DinnerStorageManager.deleteObject(dish)
                tableView.deleteRows(at: [indexPath], with: .fade)
            case 2:
                let dish = supperArray[indexPath.row]
                SupperStorageManager.deleteObject(dish)
                tableView.deleteRows(at: [indexPath], with: .fade)
            case 3:
                let dish = lunchArray[indexPath.row]
                LunchStorageManager.deleteObject(dish)
                tableView.deleteRows(at: [indexPath], with: .fade)
            default:
                print("default table view delegate")
            }
        }
    }
}

