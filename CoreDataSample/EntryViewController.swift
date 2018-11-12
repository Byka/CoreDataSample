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
            eBook.setValue("sample", forKey: "name")
            eBook.setValue("9581407050", forKey: "phonenumber")
            
            do {try managedContext.save()} catch let error as NSError{
                print("Could not save. \(error), \(error.userInfo)")
            }
        }else {
            let alert = UIAlertController.init(title: "", message: "Please enter valid user name and password", preferredStyle: .alert)
           
            self.present(alert, animated: true, completion: nil)

        }
        
        
        
        
        
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
