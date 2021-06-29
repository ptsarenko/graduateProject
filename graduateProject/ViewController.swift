//
//  ViewController.swift
//  graduateProject
//
//  Created by Петр Царенко on 06.12.2020.
//

import UIKit
import Foundation


struct basics : Codable{
    var main : list
    var visibility: Float
}

struct list: Codable{
    var temp : Float
}

struct Region{
    var region: String
    var countries: [String]
    
    init(region:String, countries:[String]) {
        self.countries = countries
        self.region = region
    }
}


class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource  {

    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var regionLabel: UILabel!
    @IBOutlet weak var JSONLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    
    var regions = [Region]()
    var weather = Float()
 
    
    override func viewDidLoad() {
        
        pickerView.delegate = self
        pickerView.dataSource = self
        
        regions.append(Region(region: "Central Europe", countries:["Germany", "Poland", "Austria", "Switzerland", "Czech Republic", "Hungary", "Slovakia"]))
        regions.append(Region(region: "Eastern Europe", countries:["Belarus", "Ukraine", "Moldova", "Romania", "Russia", "Bulgaria", "Serbia"]))
        regions.append(Region(region: "Northern Europe", countries:["Latvia", "Lithuania", "Estonia", "Finland", "Sweden", "Norway", "Denmark"]))
        regions.append(Region(region: "Western Europe", countries:["Netherlands", "Luxemburg", "Belgium", "France", "Spain", "Portugal", "United Kingdom"]))
        regions.append(Region(region: "Southern Europe", countries:["Italy", "Greece", "Bosnia and Herzegovina", "Montenegro", "Albania", "Croatia", "Slovenia"]))
        
        super.viewDidLoad()
        pickerView.selectRow(0, inComponent: 0, animated: false)
        
    
    }
 
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {return regions.count} else {let selectedRegion = pickerView.selectedRow(inComponent: 0)
            return regions[selectedRegion].countries.count
        }
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return regions[row].region
        }
        else {let selectedRegion = pickerView.selectedRow(inComponent: 0)
            return regions[selectedRegion].countries[row]
        }
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pickerView.reloadComponent(1)
        
        let selectedRegion = pickerView.selectedRow(inComponent: 0)
        let selectedCountry = pickerView.selectedRow(inComponent: 1)
        let region = regions[selectedRegion].region
        let country = regions[selectedRegion].countries[selectedCountry]
        func cityChose() -> String{
        if country == "Germany"{
            return "Berlin"
        }
        if country == "Poland"{
            return "Warsaw"
        }
        if country == "Austria"{
            return "Viena"
        }
        if country == "Switzerland"{
            return  "Bern"
        }
        if country == "Czech Republic"{
            return  "Prague"
        }
        if country == "Hungary"{
            return "Budapest"
        }
        if country == "Slovakia"{
            return  "Bratislava"
        }
        if country == "Belarus"{
            return "Minsk"
        }
        if country == "Ukraine"{
            return  "Kyiv"
        }
        if country == "Moldova"{
            return  "Kishinev"
        }
        if country == "Romania"{
            return  "Bucharest"
        }
        if country == "Russia"{
            return  "Moscow"
        }
        if country == "Bulgaria"{
            return  "Sofia"
        }
        if country == "Serbia"{
            return  "Belgrad"
        }
        if country == "Latvia"{
            return  "Riga"
        }
        if country == "Lithuania"{
            return  "Vilnius"
        }
        if country == "Estonia"{
            return  "Tallinn"
        }
        if country == "Finland"{
            return  "Helsinki"
        }
        if country == "Sweden"{
            return  "Stockholm"
        }
        if country == "Norway"{
            return  "Oslo"
        }
        if country == "Denmark"{
            return  "Copenhagen"
        }
        if country == "Netherlands"{
            return  "Amsterdam"
        }
        if country == "Luxemburg"{
            return  "Luxemburg"
        }
        if country == "Belgium"{
            return  "Brussels"
        }
        if country == "France"{
            return  "Paris"
        }
        if country == "Spain"{
            return  "Madrid"
        }
        if country == "Portugal"{
            return "Lissabon"
        }
        if country == "United Kingdom"{
            return  "London"
        }
        if country == "Italy"{
            return  "Rome"
        }
        if country == "Greece"{
            return  "Athens"
        }
        if country == "Bosnia and Herzegovina"{
            return  "Sarajevo"
        }
        if country == "Montenegro"{
            return  "Podgorica"
        }
        if country == "Albania"{
            return  "Tirana"
        }
        if country == "Croatia"{
            return  "Zagreb"
        }
        if country == "Slovenia"{
            return  "Ljubljana"
        }
        else{
            return  "City not Found"
        }
            
        }
        let urlSring = "http://api.openweathermap.org/data/2.5/weather?q=\(cityChose())&appid=30fce239709dd438bb232d52b0cacec2"
      
        guard let url = URL(string: urlSring) else {return}
        
        
        URLSession.shared.dataTask(with: url){(data, response, error) in
            
            guard let data = data else {return}
            guard error == nil else {return}
            
            do{
                let weatherDataFinal = try JSONDecoder().decode(basics.self, from: data)
                DispatchQueue.main.async{ self.regionLabel.text = "Region : \(region)\nCountry : \(country)\n Capital : \(cityChose())\n Temperature in capital : \(Int(weatherDataFinal.main.temp)-273)"}
            }catch let error{
                print(error)
            }
        }.resume()
        
        
    }
}
    
