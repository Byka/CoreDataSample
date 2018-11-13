//
//  ViewController.swift
//  CoreDataSample
//
//  Created by sbyka on 05/11/18.
//  Copyright © 2018 sbyka. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, ManagedObjectContextDependentType{

    @IBOutlet weak var tableView: UITableView!
    
    var managedObjectContext: NSManagedObjectContext!
    
    var eBookData: [EBook] = []
    
    
    @IBAction func NewEntryAction(_ sender: UIBarButtonItem) {
        
        let entryVC = storyboard?.instantiateViewController(withIdentifier: "EntryViewController") as! EntryViewController
        entryVC.isEdit = false
 self.navigationController?.pushViewController(entryVC, animated: true)
        
        
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //let mainContext = createMainContext()
        
        
        /*
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate  else {return}
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let myEntity = NSEntityDescription.entity(forEntityName: "EBook", in: managedContext)
        let eBook = NSManagedObject(entity: myEntity!, insertInto: managedContext)
        
        eBook.setValue("sample", forKey: "name")
        eBook.setValue("9581407050", forKey: "phonenumber")
        
        do {try managedContext.save()} catch let error as NSError{
            print("Could not save. \(error), \(error.userInfo)")
        }
        */

        
//        let myentity = NSEntityDescription.insertNewObject(forEntityName: "CoreDataSample", into: mainContext) as! CoreDataSample
//        myentity.name = "Srinivasa"
//        myentity.phonenumber = "9581407050"
//
//        do {try mainContext.save()} catch _{}
        
        
    }

    override func viewWillAppear(_ animated: Bool) {
        
        //get the data from coredata
        getData()
        
        //reload the table data
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate  else {return}
        let managedContext = appDelegate.persistentContainer.viewContext
        
        if editingStyle == .delete {
            let task = eBookData[indexPath.row]
            managedContext.delete(task)
            
            appDelegate.saveContext()
            
            do {
                getData()
            } catch {
                print("Fetching failed")
            }
            tableView.reloadData()

        }
    }
    

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eBookData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailsTableViewCell", for: indexPath) as! DetailsTableViewCell
        
        
        
        let rowData = eBookData[indexPath.row]
        
        cell.titleCellLabel.text = rowData.name
        cell.subTitleCellLabel.text = rowData.phonenumber
        
        return cell
        
    }
    
    
    func getData() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate  else {return}
        let managedContext = appDelegate.persistentContainer.viewContext
        
        do{
        eBookData = try managedContext.fetch(EBook.fetchRequest())
        }
        catch {
            print("Nodata available")
        }

    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print("selected item is\(indexPath.row)")
        
        let entryVC = storyboard?.instantiateViewController(withIdentifier: "EntryViewController") as! EntryViewController
        
 
            entryVC.isEdit = true
       entryVC.index = indexPath.row
        
        let rowData = eBookData[indexPath.row]
        
        entryVC.selectedInfo = [rowData]
        
        self.navigationController?.pushViewController(entryVC, animated: true)
        
        
    }
    
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 78
    }
    
    
    
}

