//
//  LululemonTests.swift
//  LululemonTests
//
//  Created by TinHuynh on 8/30/19.
//  Copyright © 2019 TinHuynh. All rights reserved.
//

import XCTest
import CoreData
@testable import Lululemon

class LululemonTests: XCTestCase
{

    let appDel = UIApplication.shared.delegate as! AppDelegate
    
    override func setUp()
    {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        appDel.insertGarment(name: "Dress", date: Date())
        appDel.insertGarment(name: "Pant", date: Date())
        appDel.insertGarment(name: "Shirt", date: Date())
        appDel.insertGarment(name: "TShirt", date: Date())
    }

    override func tearDown()
    {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        let fr = NSFetchRequest<Garment>(entityName: DATA_ENTITY_NAME_GARMENT)
        do
        {
            //
            let retArray = try appDel.persistentContainer.viewContext.fetch(fr)
            
            for item in retArray
            {
                appDel.persistentContainer.viewContext.delete(item)
                
                appDel.saveContext()
            }
        }
        catch
        {
            print(error.localizedDescription)
        }
    }

    //on top of coreData's baseline we only add 3 more functions, should only need to test those.
    
    
    func testExist()
    {

        XCTAssertTrue(appDel.checkExistGarment(name: "TShirt"))
        XCTAssertFalse(appDel.checkExistGarment(name: "Socks"))
    }
    
    func testInsert()
    {
        appDel.insertGarment(name: "Gloves", date: Date())
        XCTAssertTrue(appDel.checkExistGarment(name: "Gloves"))
    }
    
    func testFetch()
    {
        //check if: can fetch, fetch the correct amount, and parsed the correct class
        let array = appDel.fetchAllGarments()
        XCTAssertNotNil(array)
        XCTAssertTrue(array.count == 4)
        XCTAssert(array[1].isKind(of: Garment.self))
    }
}
