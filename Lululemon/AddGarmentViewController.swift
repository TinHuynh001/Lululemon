//
//  AddGarmentViewController.swift
//  Lululemon
//
//  Created by TinHuynh on 8/30/19.
//  Copyright © 2019 TinHuynh. All rights reserved.
//

import UIKit
import CoreData

class AddGarmentViewController: UIViewController {

    @IBOutlet weak var buttonSaveGarment: UIBarButtonItem!
    @IBOutlet weak var textFieldGarment: UITextField!
    
    let appDel = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "Add"
        
    }
    
    @IBAction func clickSave(_ sender: Any)
    {
        if let text = textFieldGarment.text
        {
            if text.count == 0
            {
                simpleAlert(reason: "Please enter garment name!")
            }
            else
            {
                let newGarment = Garment(context: appDel.persistentContainer.viewContext)
                let creationTime = Date()
                
                newGarment.name = text
                newGarment.timestamp = creationTime
                
                appDel.saveContext()
                
                successAlert(reason: "New garment saved.")
            }
        }
    }
    
    //some alerts are simple i.e. jsut need to notice user of error but no need to perform anything else
    //can be refactored like this to save time
    func simpleAlert(reason: String)
    {
        let alert = UIAlertController(title: "Error",
                                      message: reason,
                                      preferredStyle: .alert)
        let action = UIAlertAction(title: "OK",
                                   style: .default,
                                   handler: nil)
        
        alert.addAction(action)
        
        self.present(alert,
                     animated: true,
                     completion: nil)
    }
    
    func successAlert(reason: String)
    {
        let alert = UIAlertController(title: "Success",
                                      message: reason,
                                      preferredStyle: .alert)
        
        let action = UIAlertAction(title: "OK",
                                   style: .default)
        { (action) in //closure
            self.dismiss(animated: true, completion: nil)
        }
        
        alert.addAction(action)
        
        self.present(alert,
                     animated: true,
                     completion: nil)
    }
    


}
