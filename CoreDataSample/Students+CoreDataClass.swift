//
//  Students+CoreDataClass.swift
//  CoreDataSample
//
//  Created by sbyka on 27/11/18.
//  Copyright © 2018 sbyka. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Students)
public class Students: NSManagedObject {

    
    
    
    //Insert Students Information
    class func inserStudentInfo(inputData: [String: Any]) {
        
        let managedContext = CoredataStack.shared.persistentContainer.viewContext
        
        let myEntity = NSEntityDescription.entity(forEntityName: "Students", in: managedContext)
        
        let students = NSManagedObject(entity: myEntity!, insertInto: managedContext)
        
        let sname: String = inputData["name"] as! String
        let phoneNumber: Int = inputData["phoneNumber"] as! Int
        
        students.setValue(sname, forKey: "name")
        students.setValue(phoneNumber, forKey: "phonenumber")
        
        do{
            try managedContext.save()
            return
        }catch {
            print("Could not save the data")
        }
   
    }
    
    
    class func getStudentsList() -> [Students]{
        
        let managedContext = CoredataStack.shared.persistentContainer.viewContext
        
        do {
            let studentRecords: [Students] = try! managedContext.fetch(Students.fetchRequest())
            return studentRecords
            
        }catch{
            print("Unable to get the records")
        }
        
    }
    
    
    class func removeSelectedRecord(index: Int) {
        let managedContext = CoredataStack.shared.persistentContainer.viewContext
        
        let selectedObject = CoredataStack.shared.studentList[index]
        managedContext.delete(selectedObject)
        
        return
        
    }
    
    
    //Fetch Selected record
    class func fetchSelectedRecord(updatedData: [String: Any], index: Int) {
        
        let sname: String = updatedData["name"] as! String
        let phoneNumber: Int = updatedData["phoneNumber"] as! Int
        
        
        let managedContext = CoredataStack.shared.persistentContainer.viewContext
        
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "Students")
        
        fetchRequest.predicate = NSPredicate(format: "phonenumber = %d", phoneNumber)
        

        
        do {
            let test = try managedContext.fetch(fetchRequest)
            
            if test.count == 1
            {
                let objectUpdate = test[0] as! NSManagedObject
                
                objectUpdate.setValue(sname, forKey: "name")
                objectUpdate.setValue(phoneNumber, forKey: "phonenumber")
                
                do {
                    try managedContext.save()
                    return
                    
                    
                }catch{
                    print("unable to save \(error)")
                    
                }
            }else{
                print(test)
            }
            
            
            
            
            
           
        }catch{
            
        }
        
        
    }
    
}


//let managedContext = appDelegate.persistentContainer.viewContext
//let fetchRequest:NSFetchRequest = NSFetchRequest.init(entityName: “User”)
//let predicate = NSPredicate(format: “id == ‘\(user[0].value(forKey: “id”) as! Int)'”)
//    fetchRequest.predicate = predicate
//    do{
//    let test = try managedContext.fetch(fetchRequest)
//    if test.count == 1
//    {
//   esentation(imgUserImg.image!, 1), forKey: “image”)
//    do {
//    try managedContext.save()
//    showAlert(withTitleMessageAndAction: “Sucess!!”, message: “Your record has been updated sucessfully!!”, action: true)
//    } catch let error as NSError {
//    print(“Could not save. \(error), \(error.userInfo)”)
//    }
//    }
//}

//func updateData() {
//    let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "EBook")
//    fetchRequest.predicate = NSPredicate(format: "phonenumber = %@")
//
//    let name: String = nameTextField.text!
//    let phoneNumber: String = self.phoneNumber.text!
//
//
//    do {
//        let test: [EBook] = try managedContext.fetch(EBook.fetchRequest())
//
//
//        let objectUpdate = test[index] as! NSManagedObject
//
//        objectUpdate.setValue(name, forKey: "name")
//        objectUpdate.setValue(phoneNumber, forKey: "phonenumber")
//
//
//        do {
//            try managedContext.save()
//            self.navigationController?.popViewController(animated: true)
//        }catch{
//            print("unable to save \(error)")
//        }
//    }catch{
//        print(error)
//    }
//
//
//}


