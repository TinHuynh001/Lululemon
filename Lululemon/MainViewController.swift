//
//  ViewController.swift
//  Lululemon
//
//  Created by TinHuynh on 8/30/19.
//  Copyright © 2019 TinHuynh. All rights reserved.
//

import UIKit
import CoreData

class MainViewController: UIViewController,
                        UITableViewDelegate,
                        UITableViewDataSource
{

    @IBOutlet weak var segControlButton: UISegmentedControl!
    
    @IBOutlet weak var garmentTable: UITableView!
    
    
    let appDel = UIApplication.shared.delegate as! AppDelegate
    
    //data model exposed to controller, bad design. Refactor into ServiceManager later to maintain MVC pattern
    var garmentArray : [Garment] = []
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
    }
    
    
    //reload of table's data done at viewWillAppear to force reload at both app start and after returning from a garment insertion view.
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        
        garmentArray = appDel.fetchAllGarments()
        garmentTable.reloadData()
        
    }
    
    //decided to do the sorting here since
    //both way to sort utilize Swift types, which are sortable by default
    //dont have to fetch the same data over and over again from CoreData
    @IBAction func segControlIndexChanged(_ sender: Any)
    {
        switch segControlButton.selectedSegmentIndex
        {
        case 0:
            garmentArray.sort
            { (gar1, gar2) -> Bool in
                // force unwrap will not crash, since we enforced on insertion that these values cannot be nil
                return gar1.name! < gar2.name!
            }
            garmentTable.reloadData()
            break
        case 1:
            garmentArray.sort
            { (gar1, gar2) -> Bool in
                return gar1.timestamp! < gar2.timestamp!
            }
            garmentTable.reloadData()
            break
        default:
            break
        }
    }
    


}



//Extension for table view
extension MainViewController
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return garmentArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: TABLE_CELL_GARMENT)
        
        let garment = garmentArray[indexPath.row]
        
        cell?.textLabel?.text = garment.name ?? "Invalid"
        
        return cell!
    }
    
}

