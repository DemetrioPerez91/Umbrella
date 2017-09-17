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
    override func viewDidLoad() {
        super.viewDidLoad()

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
                DataManager.instance.setLocation()
            }
            else
            {
                warning.text = "invalid zip code"
            }
        }
    }
    
    
}
