//
//  ViewController.swift
//  CoreDataSample
//
//  Created by sbyka on 05/11/18.
//  Copyright © 2018 sbyka. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController{

    @IBOutlet weak var tableView: UITableView!
    
    //var managedObjectContext: NSManagedObjectContext!
    
    //var eBookData: [EBook] = []
    
    
    @IBAction func NewEntryAction(_ sender: UIBarButtonItem) {
        
        let entryVC = storyboard?.instantiateViewController(withIdentifier: "EntryViewController") as! EntryViewController
        entryVC.isEdit = false
 self.navigationController?.pushViewController(entryVC, animated: true)
        
        
    }
    
    @IBAction func searchRecordsAction(_ sender: Any) {
        
        
        let entryVC = storyboard?.instantiateViewController(withIdentifier: "EntryViewController") as! EntryViewController
        entryVC.isEdit = true
        self.navigationController?.pushViewController(entryVC, animated: true)
        
        
        
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //let mainContext = createMainContext()
        
        
        
    }

    override func viewWillAppear(_ animated: Bool) {
        

        
        //reload the table data
        DispatchQueue.main.async {
            CoredataStack.shared.studentList = Students.getStudentsList()
            print(CoredataStack.shared.studentList)
            self.tableView.reloadData()
        }
    }
    
   
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CoredataStack.shared.studentList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailsTableViewCell", for: indexPath) as! DetailsTableViewCell
        
        cell.titleCellLabel.text = CoredataStack.shared.studentList[indexPath.row].name
        let phoneNumber: String = String(describing : CoredataStack.shared.studentList[indexPath.row].phonenumber)
        
        cell.subTitleCellLabel.text = phoneNumber
        
        return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let entryVC = storyboard?.instantiateViewController(withIdentifier: "EntryViewController") as! EntryViewController
        
        
        entryVC.isEdit = true
        entryVC.index = indexPath.row
        
        
        
        
        
        self.navigationController?.pushViewController(entryVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 78
    }
    
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            Students.removeSelectedRecord(index: indexPath.row)
            
            do {
                DispatchQueue.main.async {
                    CoredataStack.shared.studentList = Students.getStudentsList()
                    print(CoredataStack.shared.studentList)
                    self.tableView.reloadData()
                }
            } catch {
                print("Fetching failed")
                
            }
            tableView.reloadData()
        }
        
    }
    
}

