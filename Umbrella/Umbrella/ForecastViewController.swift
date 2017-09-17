
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
    
    let orange = UIColor(colorLiteralRed: 1.0, green: 0.5519607843, blue: 0.0, alpha: 1)
    let blue = UIColor(colorLiteralRed: 0.133333333, green: 0.7003921568, blue: 1.0, alpha: 1)
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
        if indexPath.row == 0
        {
            cell?.textLabel?.text = "Today"
        }
        else if indexPath.row == 1
        {
            cell?.textLabel?.text  = "Tomorrow"
        }
        else
        {
            cell?.textLabel?.text = "Day \(indexPath.row + 1)"
        }
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
