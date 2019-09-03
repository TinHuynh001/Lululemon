//
//  AppDelegate.swift
//  Lululemon
//
//  Created by TinHuynh on 8/30/19.
//  Copyright © 2019 TinHuynh. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool
    {
        // Override point for customization after application launch.
        
        //reset initial array by deleting all previous entry
        let fr = NSFetchRequest<Garment>(entityName: DATA_ENTITY_NAME_GARMENT)
        do
        {
            //
            let retArray = try persistentContainer.viewContext.fetch(fr)

            for item in retArray
            {
                persistentContainer.viewContext.delete(item)

                saveContext()
            }
        }
        catch
        {
            print(error.localizedDescription)
        }
//
        insertGarment(name: "Dress", date: Date())
        insertGarment(name: "Pant", date: Date())
        insertGarment(name: "Shirt", date: Date())
        insertGarment(name: "TShirt", date: Date())
        
        
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }

    // MARK: - Core Data stack
    // Both basic and custom functions of CoreData usages are written below
    // Marked for Refactor into ServiceManager later if needed

    lazy var persistentContainer: NSPersistentContainer = {

        let container = NSPersistentContainer(name: "Lululemon")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {

                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    
    
    
    // MARK: - Core Data Saving support

    func saveContext ()
    {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    
    func insertGarment(name: String, date: Date)
    {
        //check for existing item to avoid duplicate
        //need an Error or Boolean return type to signal an insertion error (duplicate)
        if !checkExistGarment(name: name)
        {
            let newGarment = Garment(context: persistentContainer.viewContext)
        
            newGarment.name = name
            newGarment.timestamp = date
        
            saveContext()
        }
    }
    
    
    func fetchAllGarments() -> [Garment]
    {
        let request = NSFetchRequest<Garment>(entityName: DATA_ENTITY_NAME_GARMENT)
        
        //sorting can be done at CoreData layer using the code below
        //however in this case can also be done at controller layer since the sorting targets are all Swift data types (String and Date), through sort(by:) with a custom comparator
        
        //let sort = NSSortDescriptor(key: sortedBy, ascending: true)
        //request.sortDescriptors = [sort]
        
        var retArray : [Garment] = []
        
        do
        {
            retArray = try persistentContainer.viewContext.fetch(request)
        }
        catch
        {
            print(error.localizedDescription)
        }
        
        return retArray
    }
    
    func checkExistGarment(name: String) -> Bool
    {
        let request = NSFetchRequest<Garment>(entityName: DATA_ENTITY_NAME_GARMENT)
        request.predicate = NSPredicate(format: "name = %@", name)
        
        do
        {
            let retArray = try persistentContainer.viewContext.fetch(request)
            
            if retArray.count == 0
            {
                return false
            }
            else
            {
                return true
            }
        }
        catch
        {
            print(error.localizedDescription)
            return false
        }
    }

}

