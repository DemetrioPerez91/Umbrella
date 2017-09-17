
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DataManager.instance.refreshConditionsDelegate = self
        DataManager.instance.refreshtTableDelegate = self
        forecastTableView.delegate = self
        forecastTableView.dataSource = self
        DataManager.instance.refreshConditionsDelegate?.refreshConditions()
        DataManager.instance.refreshtTableDelegate?.refresh()
        
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
        print( DataManager.instance.days.count)
        return DataManager.instance.days.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = forecastTableView.dequeueReusableCell(withIdentifier: "dayCell")
        cell?.textLabel?.text = "lol"
        return cell!
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
            }
        }
       
    }
}
