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
    var isEdit: Bool = false
    var index : NSInteger = 0
    
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
    
    @IBOutlet weak var editButton: UIButton!
    
    @IBAction func editButtonAction(_ sender: Any) {
        
        self.updateData()
    }
  
    
    func updateData() {
        
        //As we know that container is set up in the AppDelegate so we need to refer to that container
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        //We need to create a context from this container
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "EBook")
        fetchRequest.predicate = NSPredicate(format: "phonenumber = %@")
        
        let name: String = nameTextField.text!
        let phoneNumber: String = self.phoneNumber.text!
        
        
        do {
            let test: [EBook] = try managedContext.fetch(EBook.fetchRequest())
            
            
            let objectUpdate = test[index] as! NSManagedObject
            
            objectUpdate.setValue(name, forKey: "name")
            objectUpdate.setValue(phoneNumber, forKey: "phonenumber")

            
            do {
                try managedContext.save()
                self.navigationController?.popViewController(animated: true)
            }catch{
                print("unable to save \(error)")
            }
        }catch{
            print(error)
        }
        
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.


        
        
        print(selectedInfo)

        if selectedInfo.count > 0 {
            self.nameTextField.text = (selectedInfo[0].name as! String)
            self.phoneNumber.text = (selectedInfo[0].phonenumber as! String)
        }

        
        if isEdit {
            self.saveButton.isHidden = true
            self.editButton.isHidden = false
        }else{
            self.saveButton.isHidden = false
            self.editButton.isHidden = true
        }
        
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
