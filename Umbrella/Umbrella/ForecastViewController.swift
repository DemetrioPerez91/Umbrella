
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
    
    let alertTitle = "Enter Zip Code"
    let alertMessage = "You need an american Zip Code for this app to work"
    let day = "Day"
    let today = "Today"
    let tomorrow = "Tomorrow"
    
    var currentDay:DayViewModel?
    
    let orange = UIColor(colorLiteralRed: 1.0, green: 0.5519607843, blue: 0.0, alpha: 1)
    let blue = UIColor(colorLiteralRed: 0.133333333, green: 0.7003921568, blue: 1.0, alpha: 1)
    let model:[UIColor] =  [UIColor.red, UIColor.red]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupConditionsShadow()
        DataManager.instance.refreshConditionsDelegate = self
        DataManager.instance.refreshtTableDelegate = self
        DataManager.instance.zipCodeRequestResponder = self
        forecastTableView.delegate = self
        forecastTableView.dataSource = self
        forecastTableView.rowHeight = 400
        
        let delegate = UIApplication.shared.delegate as! AppDelegate
        if delegate.shouldRequestZipCode {
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
        
        let localizedAlert = NSLocalizedString(alertTitle, comment: "zipcode")
        let localizedMessage = NSLocalizedString(alertMessage, comment: "zipcode")
        let alert = UIAlertController(title: localizedAlert, message: localizedMessage , preferredStyle: .alert)
        
        alert.addTextField(configurationHandler: configurationTextField)
        
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default) { _ in
            print("User click Ok button")
            guard let zipcodeText = alert.textFields?[0].text else { return }

            if ZipCodeReader.isZipCodeValid(zipcodeString: zipcodeText){
                DataManager.instance.zipCode = zipcodeText
                DataManager.instance.setData()
            }
            else {
                self.showAlert()
            }
        })
        
        present(alert, animated: true){
            print("completion block")
        }
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
        
        let cell = forecastTableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        guard let dayCell = cell as? DayTableViewCell else { fatalError("Cell/Identifier mismatch") }
        
        currentDay = DataManager.instance.days[indexPath.row]
        
        if indexPath.row == 0 {
             dayCell.DayLabel.text  = NSLocalizedString(today, comment: "today")
        }
        else if indexPath.row == 1 {
            dayCell.DayLabel.text  = NSLocalizedString(tomorrow, comment: "tomorrow")
        }
        else {
            dayCell.DayLabel.text = "\(NSLocalizedString(day, comment: "day")) \(indexPath.row + 1)"
        }
        return dayCell
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
            guard let forecast = DataManager.instance.currentConditions else { return }
            
            self.stateLabel.text = DataManager.instance.location
            self.tempLabel.text = forecast.temperatureText
            self.conditionLabel.text = forecast.weatherString
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

extension ForecastViewController:UICollectionViewDelegate{}
extension ForecastViewController:UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return (currentDay?.forecasts.count) ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        
        guard let forecastCell = cell as? ForecastCollectionViewCell else { fatalError("Cell/Identifier mismatch") }
        guard let forecast = currentDay?.forecasts[indexPath.row] else { return forecastCell }
        
        forecastCell.timeLabel.text = forecast.time
        forecastCell.condition.text = forecast.weatherString
        forecastCell.temp.text = forecast.temperatureText
        
        if forecast.isHottest
        {
            forecastCell.timeLabel.textColor = orange
            forecastCell.condition.textColor = orange
            forecastCell.temp.textColor = orange
        }
        else if forecast.isColdest
        {
            forecastCell.timeLabel.textColor = blue
            forecastCell.condition.textColor = blue
            forecastCell.temp.textColor = blue
        }
        else
        {
            forecastCell.timeLabel.textColor = UIColor.black
            forecastCell.condition.textColor = UIColor.black
            forecastCell.temp.textColor = UIColor.black
        }
        
        return forecastCell
    }
}

extension ForecastViewController:ZipCodeRequestResponder
{
    func success() {
        UserDefaults.standard.set(DataManager.instance.zipCode, forKey: "zipcode")
    }
    func failure() {
        showAlert()
    }
}
