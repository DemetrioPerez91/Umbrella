//
//  OptionsViewController.swift
//  Umbrella
//
//  Created by User on 9/17/17.
//  Copyright © 2017 DemetrioPerez. All rights reserved.
//

import UIKit

class OptionsViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var warning: UILabel!
    let invalidCode = "Invalid zip code"
    let failureText = "Failed to get data"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DataManager.instance.zipCodeRequestResponder = self
        // Do any additional setup after loading the view.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        warning.text = ""
        UIView.animate(withDuration: 0.5, animations: {
             self.navigationController?.isNavigationBarHidden = false
        })
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        UIView.animate(withDuration: 0.5, animations: {
            self.navigationController?.isNavigationBarHidden = true
        })
    }
    
    
    @IBAction func saveZipCode(_ sender: Any)
    {
        if let text = textField.text
        {
            if ZipCodeReader.instance.isZipCodeValid(text)
            {
                DataManager.instance.setData()
            }
            else
            {
                warning.text = NSLocalizedString(invalidCode, comment: "Invalid")
            }
        }
    }
    
    
}


extension OptionsViewController:ZipCodeRequestResponder
{
    func success() {
        DispatchQueue.main.async {
            _ = self.navigationController?.popViewController(animated: true)
        }
         UserDefaults.standard.set(DataManager.instance.zipCode, forKey: "zipcode")
        
    }
    func failure()
    {
        DispatchQueue.main.async {
            self.warning.text = NSLocalizedString(self.failureText, comment: "FAIL")
        }
        print("fail")
        
    }
}
