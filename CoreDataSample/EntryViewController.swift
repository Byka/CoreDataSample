//
//  EntryViewController.swift
//  CoreDataSample
//
//  Created by sbyka on 06/11/18.
//  Copyright © 2018 sbyka. All rights reserved.
//

import UIKit

class EntryViewController: UIViewController {

//    var selectedInfo = []
    
//    var selectedInfo:[EBook] = []
    var isEdit: Bool = false
    var index : NSInteger = -1
    
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var phoneNumber: UITextField!
    
    @IBOutlet weak var saveButton: UIButton!
    
    @IBAction func saveButtonAction(_ sender: Any) {
        
        
        //Students.inserStudentInfo()

        
        let tName = self.nameTextField.text
        let tPhoneNumber = self.phoneNumber.text
        
        if (tName?.count)! > 2 && tPhoneNumber?.count == 10 {
            
            var inputRecord: [String: Any] = [:]
            
            
            inputRecord = ["name":tName, "phoneNumber": Int(tPhoneNumber!)]
            
            Students.inserStudentInfo(inputData: inputRecord)
            self.navigationController?.popViewController(animated: true)

            
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
        
        

        let tName: String = self.nameTextField.text!
        let tPhoneNumber = self.phoneNumber.text
        
        var inputRecord: [String: Any] = [:]
       
        inputRecord = ["name":tName, "phoneNumber": Int(tPhoneNumber!)]
        
        
        Students.fetchSelectedRecord(updatedData: inputRecord, index: index)
        
        self.navigationController?.popViewController(animated: true)
        
        
        

        
    }
    
    
    /*
    
    func searchForGivenData(searchKey: String) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate  else {return}
        let managedContext = appDelegate.persistentContainer.viewContext
        
        
        
        
            var fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "EBook")
            fetchRequest.predicate = NSPredicate(format: "name == %@", searchKey)
            
            var results: [NSManagedObject] = []
            
            do {
                results = try managedContext.fetch(fetchRequest)
            }
            catch {
                print("error executing fetch request: \(error)")
            }
            
             print(results)
        
        
        
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
    */
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.


        
        

        if index > -1 {
            self.nameTextField.text = (CoredataStack.shared.studentList[index].name as! String)
             let phoneNumber: String = String(describing : CoredataStack.shared.studentList[index].phonenumber)
            self.phoneNumber.text = phoneNumber
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

}
