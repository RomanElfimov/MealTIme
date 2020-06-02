//
//  DatePickerView.swift
//  MealTime
//
//  Created by Роман Елфимов on 17.05.2020.
//  Copyright © 2020 Роман Елфимов. All rights reserved.
//

import UIKit

class DatePickerView: UIView {

    // MARK: - Property
    
    var delegate: DatePickerViewDelegate?
    
    // MARK: - Outlet
    
    @IBOutlet weak var datePicker: UIDatePicker!

    
    // MARK: - Actions
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        delegate?.pushCancel(datePickerView: self)
        
        //убираем окно с анимацией - анологично selectAction
        self.frame.origin.y = (self.delegate as! UIViewController).view.frame.size.height - self.frame.size.height
        
        UIView.animate(withDuration: 0.5, animations: {
            self.frame.origin.y = (self.delegate as! UIViewController).view.frame.size.height
        }) { (bool) in
            self.removeFromSuperview()
        }
    }
    
    @IBAction func chooseButtonTapped(_ sender: Any) {
        delegate?.selectDate(datePickerView: self, date: datePicker.date)
        //убираем окно с анимацией
        //начальная точка окна, начинает уезжать
        self.frame.origin.y = (self.delegate as! UIViewController).view.frame.size.height - self.frame.size.height
        
        //нижняя точка окна, останавливается уезжать
        UIView.animate(withDuration: 0.5, animations: {
            self.frame.origin.y = (self.delegate as! UIViewController).view.frame.size.height
        }) { (bool) in
            self.removeFromSuperview()
        }
    }
    
    
    //MARK: - Mehtods
    
    func showPickerInController(vc: UIViewController) {
        vc.view.addSubview(self)
        
        self.frame.size.width = vc.view.frame.size.width
        //точка, где появляется datePickerView
        self.frame.origin.x = 0
        self.frame.origin.y = vc.view.frame.size.height
        
        //конечная точка, до которой анимируется
        UIView.animate(withDuration: 0.5, animations: {
            self.frame.origin.y = vc.view.frame.size.height - self.frame.size.height - 50
        }) { (bool) in
            
        }
    }
    
    class func initPicker(delegate: DatePickerViewDelegate) -> DatePickerView {
        let datePicker = Bundle.main.loadNibNamed("DatePicker", owner: self, options: nil)![0] as! DatePickerView
        datePicker.delegate = delegate
        return datePicker
    }
}
