
//
//  ForecastViewController.swift
//  Umbrella
//
//  Created by User on 9/16/17.
//  Copyright © 2017 DemetrioPerez. All rights reserved.
//

import UIKit

class ForecastViewController: UIViewController {

    @IBOutlet weak var currentConditionView: UIView!
    @IBOutlet weak var stateLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var conditionLabel: UILabel!
    @IBOutlet weak var forecastTableView: UITableView!
    
    var currentDay:DayViewModel?
    
    let orange = UIColor(colorLiteralRed: 1.0, green: 0.5519607843, blue: 0.0, alpha: 1)
    let blue = UIColor(colorLiteralRed: 0.133333333, green: 0.7003921568, blue: 1.0, alpha: 1)
    let model:[UIColor] =  [UIColor.red, UIColor.red]
    override func viewDidLoad() {
        super.viewDidLoad()
        setupConditionsShadow()
        DataManager.instance.refreshConditionsDelegate = self
        DataManager.instance.refreshtTableDelegate = self
        forecastTableView.delegate = self
        forecastTableView.dataSource = self
        forecastTableView.rowHeight = 400
        
        let delegate = UIApplication.shared.delegate as!AppDelegate
        if delegate.shouldRequestZipCode
        {
            showAlert()
        }
        
        
        
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
        DataManager.instance.refreshConditionsDelegate?.refreshConditions()
        DataManager.instance.refreshtTableDelegate?.refresh()

    }
    
    func setupConditionsShadow()
    {
        currentConditionView.layer.shadowColor = UIColor.black.cgColor
        currentConditionView.layer.shadowOpacity = 1
        currentConditionView.layer.shadowOffset = CGSize.zero
        currentConditionView.layer.shadowRadius = 10
        currentConditionView.layer.shadowRadius = 10
    }

    func showAlert()
    {
        func configurationTextField(textField: UITextField!){}
        
        let alert = UIAlertController(title: "Enter Zip Code", message: "You need an american Zip Code for this app to work", preferredStyle: .alert)
        
        alert.addTextField(configurationHandler: configurationTextField)
        
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler:{ (UIAlertAction)in
            print("User click Ok button")
            if let textfield = alert.textFields?[0].text
            {
                ZipCodeReader.instance.isZipCodeValid(textfield, completion:
                {
                    isValid in
                    if isValid
                    {
                        DataManager.instance.setData()
                    }
                    else
                    {
                        self.showAlert()
                    }
                })
                
            }
            
        }))
        self.present(alert, animated: true, completion: {
            print("completion block")
        })
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ForecastViewController:UITableViewDelegate{}
extension ForecastViewController:UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return DataManager.instance.days.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = forecastTableView.dequeueReusableCell(withIdentifier: "Cell") as? DayTableViewCell
        
        currentDay = DataManager.instance.days[indexPath.row]
        
        if indexPath.row == 0
        {
             cell?.DayLabel.text  = "Today"
        }
        else if indexPath.row == 1
        {
            cell?.DayLabel.text  = "Tomorrow"
        }
        else
        {
            cell?.DayLabel.text = "Day \(indexPath.row + 1)"
        }
        return cell!
    }
    
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let tableViewCell = cell as? DayTableViewCell else { return }
        
        tableViewCell.setCollectionViewDataSourceDelegate(dataSourceDelegate: self, forRow: indexPath.row)
    }
    
   
    
}

extension ForecastViewController:RefreshTableProtocol
{
    func refresh() {
        DispatchQueue.main.async {
            self.forecastTableView.reloadData()
        }
        
    }
}

extension ForecastViewController:RefreshCurrentConditions
{
    func refreshConditions()
    {
        DispatchQueue.main.async {
            if let forecast = DataManager.instance.currentConditions
            {
                self.stateLabel.text = DataManager.instance.location
                self.tempLabel.text = forecast.temperatureText
                self.conditionLabel.text = forecast.forecast.weather
                if forecast.temperatureFloat > 60
                {
                    self.currentConditionView.backgroundColor = self.orange
                }else
                {
                   self.currentConditionView.backgroundColor = self.blue
                }
            }
        }
       
    }
    
    
}


extension ForecastViewController:UICollectionViewDelegate{}
extension ForecastViewController:UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return (currentDay?.forecasts.count)!
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? ForecastCollectionViewCell
        
        
        
        if let forecast = currentDay?.forecasts[indexPath.row]{
            cell?.timeLabel.text = forecast.time
            cell?.condition.text = forecast.forecast.weather
            cell?.temp.text = forecast.temperatureText
            
            if forecast.isHottest
            {
                cell?.timeLabel.textColor = orange
                cell?.condition.textColor = orange
                cell?.temp.textColor = orange
            }
            else if forecast.isColdest
            {
                cell?.timeLabel.textColor = blue
                cell?.condition.textColor = blue
                cell?.temp.textColor = blue
            }
            else
            {
                cell?.timeLabel.textColor = UIColor.black
                cell?.condition.textColor = UIColor.black
                cell?.temp.textColor = UIColor.black
            }
        }
        
        return cell!
    }
    
}
