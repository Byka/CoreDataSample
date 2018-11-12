//
//  EntryViewController.swift
//  CoreDataSample
//
//  Created by sbyka on 06/11/18.
//  Copyright © 2018 sbyka. All rights reserved.
//

import UIKit
import CoreData

class EntryViewController: UIViewController {

//    var selectedInfo = []
    
//    var selectedInfo:[EBook] = []
    var selectedInfo: [EBook] = []
    
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var phoneNumber: UITextField!
    
    @IBOutlet weak var saveButton: UIButton!
    
    @IBAction func saveButtonAction(_ sender: Any) {
        
        
        
        
        let tName = self.nameTextField.text
        let tPhoneNumber = self.phoneNumber.text
        
        if (tName?.count)! > 2 && tPhoneNumber?.count == 10 {
            
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate  else {return}
            let managedContext = appDelegate.persistentContainer.viewContext
            
            let myEntity = NSEntityDescription.entity(forEntityName: "EBook", in: managedContext)
            let eBook = NSManagedObject(entity: myEntity!, insertInto: managedContext)
            eBook.setValue(tName, forKey: "name")
            eBook.setValue(tPhoneNumber, forKey: "phonenumber")
            
            do {try managedContext.save()
                self.navigationController?.popViewController(animated: true)
            } catch let error as NSError{
                print("Could not save. \(error), \(error.userInfo)")
            }
        }else {
            let alert = UIAlertController.init(title: "Alert", message: "Please enter valid user name and password", preferredStyle: .alert)
            
            let action1 = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction) in
                print("default")
            }

            
            alert.addAction(action1)
            self.present(alert, animated: true, completion: nil)

            
        }
        
        
        
        
        
        
    }
    
    
    /*
    
     let alertController = UIAlertController(title: "Alert", message: "This is an alert.", preferredStyle: .alert)
     
     let action1 = UIAlertAction(title: "Default", style: .default) { (action:UIAlertAction) in
     print("You've pressed default");
     }
     
     let action2 = UIAlertAction(title: "Cancel", style: .cancel) { (action:UIAlertAction) in
     print("You've pressed cancel");
     }
     
     let action3 = UIAlertAction(title: "Destructive", style: .destructive) { (action:UIAlertAction) in
     print("You've pressed the destructive");
     }
     
     alertController.addAction(action1)
     alertController.addAction(action2)
     alertController.addAction(action3)
     self.present(alertController, animated: true, completion: nil)

    */
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

//        if selectedInfo.count > 0 {
//            self.nameTextField.text = selectedInfo.name
//            self.phoneNumber.text = selectedInfo.phonenumber
//        }
        
        
        print(selectedInfo)
        
//        cell.titleCellLabel.text = rowData.name
//        cell.subTitleCellLabel.text = rowData.phonenumber
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
