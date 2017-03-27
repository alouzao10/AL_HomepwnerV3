//
//  DateChangeController.swift
//  Homepwner
//
//  WORKING COPY For ch. 15 - ch. 17
//
//  Created by Alex Louzao on 3/26/17.
//  Copyright © 2017 ALcsc2310. All rights reserved
//

import UIKit

class DateChangeController: UIViewController {
    var datePicker: UIDatePicker!
    var item: Item!
    
    //      override func loadView() {
    //        super.loadView()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Date Created"
        
        datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.date = item.dateCreated
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(datePicker)
        
        datePicker.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        datePicker.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        item.dateCreated = datePicker.date
    }
}
