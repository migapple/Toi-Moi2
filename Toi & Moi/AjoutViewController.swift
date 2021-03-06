//
//  AjoutViewController.swift
//  Toi & Moi
//
//  Created by Michel Garlandat on 18/01/2017.
//  Copyright © 2017 Michel Garlandat. All rights reserved.
//

import UIKit
import CoreData
import Firebase
import FirebaseDatabase

//var activite = ["Restau", "Ciné","Courses","","","","","","",""]

class AjoutViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var prixTextField: UITextField!    
    @IBOutlet weak var quoiTextField: UITextField!
    @IBOutlet weak var monDatePicker: UIDatePicker!
    @IBOutlet weak var activitePicker: UIPickerView!
    @IBOutlet weak var quiSegmentedControl: UISegmentedControl!
    
    var choix = "Restau"
    let datePicker = UIDatePicker()
    let dateFormatter = DateFormatter()
    var qui = moi
    let numberFormatter = NumberFormatter()
    //var prixDouble:Double


    @IBAction func modiferDatePicker(_ sender: Any) {
        dateTextField.text = dateFormatter.string(for: monDatePicker.date)
    }
    
    @IBAction func quiSegmentedControlAction(_ sender: Any) {
        switch quiSegmentedControl.selectedSegmentIndex 
        {
        case 0:
            qui = moi;
        case 1:
            qui = toi;
        default:
            break; 
        }
    }
    
    @IBAction func ajouterAction(_ sender: Any) {
        if prixTextField.text == "" {
            prixTextField.text = "0"
        }
        
        let newPrix = prixTextField.text?.replacingOccurrences(of: ",", with: ".")
        let  post :[String: AnyObject] = ["nom": qui as AnyObject,"date":dateTextField.text! as AnyObject,"quoi":quoiTextField.text! as AnyObject,"prix": Double(newPrix!) as AnyObject]
        
        let databaseRef = FIRDatabase.database().reference()
        
        // post data
        databaseRef.child("activite").childByAutoId().setValue(post)
        
        self.dismiss(animated: true, completion: nil)
    }
    

    @IBAction func annulerAction(_ sender: Any) {
         self.dismiss(animated: true, completion: nil)
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        quiSegmentedControl.setTitle(moi, forSegmentAt: 0)
        quiSegmentedControl.setTitle(toi, forSegmentAt: 1)
        
        afficheDate()
        quoiTextField.text = choix
    }
    
    // MARK - Gestion Activites Picker View
    
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return activiteSetting[row]
        
    }
    
    // returns the number of 'columns' to display.
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // returns the # of rows in each component..
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
          return activiteSetting.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        choix = activiteSetting[row]
        quoiTextField.text = choix
    }
    
        
    func afficheDate() {
        // affiche la date du jour et le met dans le champ dateTextField
        dateFormatter.locale = NSLocale(localeIdentifier: "fr_FR") as Locale!
        dateFormatter.dateFormat = "EEE dd/MM/yy HH:mm"
        dateTextField.text = dateFormatter.string(from: monDatePicker.date)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
