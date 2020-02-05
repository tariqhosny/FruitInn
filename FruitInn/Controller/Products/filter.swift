//
//  filter.swift
//  FruitInn
//
//  Created by Tariq on 12/23/19.
//  Copyright © 2019 Tariq. All rights reserved.
//

import UIKit

class filter: UIViewController, UITextFieldDelegate{

    @IBOutlet weak var countryTf: UITextField!
    @IBOutlet weak var typeTf: UITextField!
    @IBOutlet weak var selectTypeTf: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var seasonsCollectionView: UICollectionView!
    
    let Countries = ["Egypt", "China", "England", "Vietnam"]
    let images = ["egypt", "china", "england", "vietnam"]
    var sections = [productsData]()
    var categories = [productsData]()
    var seasons = [productsData]()
    
    var sectionId = Int()
    var seasonId = Int()
    var categorisIDs = [Int]()
    var egypt = 0
    var england = 0
    var china = 0
    var vietnam = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addTitleImage()
        addTFImage(textField: typeTf)
        addTFImage(textField: countryTf)
        createTypePiker()
        createCountryPiker()
        seasonsHandelRefresh()
        tableView.delegate = self
        tableView.dataSource = self
        seasonsCollectionView.delegate = self
        seasonsCollectionView.dataSource = self
        tableView.allowsMultipleSelection = true
        tableView.allowsMultipleSelectionDuringEditing = true
        // Do any additional setup after loading the view.
    }
    
    func addTFImage(textField: UITextField){
        textField.rightViewMode = UITextField.ViewMode.unlessEditing
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        imageView.contentMode = .scaleAspectFit
        let image = UIImage(named: "down")
        imageView.image = image
        textField.rightView = imageView
    }
    
    func createCountryPiker(){
        let country = UIPickerView()
        country.delegate = self
        country.dataSource = self
        country.tag = 0
        countryTf.inputView = country
        country.reloadAllComponents()
    }
    
    func createTypePiker(){
        let type = UIPickerView()
        type.delegate = self
        type.dataSource = self
        type.tag = 1
        typeTf.inputView = type
        sectionsHandelRefresh()
        type.reloadAllComponents()
    }
    
    func sectionsHandelRefresh(){
        productsApi.sectionsApi { (section) in
            if let section = section{
                self.sections = section.data!
            }
            print(section!)
        }
    }
    
    func categoriesHandelRefresh(){
        productsApi.categoriesApi(id: sectionId) { (category) in
            if let category = category{
                self.categories = category.data!
                self.tableView.reloadData()
            }
        }
    }
    
    func seasonsHandelRefresh(){
        MenuApis.seasonApi { (season) in
            if let season = season.data{
                self.seasons = season
                self.seasonsCollectionView.reloadData()
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? products{
            destination.seasonId = seasonId
            destination.categorisIDs = categorisIDs
            destination.egypt = egypt
            destination.england = england
            destination.china = china
            destination.vietnam = vietnam
            destination.fromFilter = 1
        }
    }

}
extension filter: UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 0{
            return Countries.count
        }else {
            return sections.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        if pickerView.tag == 0{
            let myView = UIView(frame: CGRect(x: 0, y: 0, width: pickerView.bounds.width, height: 60))
            let image = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
            let myLabel = UILabel(frame: CGRect(x: 0, y: 0, width: pickerView.bounds.width , height: 60 ))
            myLabel.text = Countries[row]
            myLabel.textAlignment = .center
            image.image = UIImage(named: images[row])
            image.clipsToBounds = true
            image.layer.masksToBounds = true
            myView.addSubview(myLabel)
            myView.addSubview(image)
            return myView
            
        }else {
            let myView = UIView(frame: CGRect(x: 0, y: 0, width: pickerView.bounds.width, height: 60))
            let myLabel = UILabel(frame: CGRect(x: 0, y: 0, width: pickerView.bounds.width , height: 60 ))
            myLabel.text = sections[row].title
            myLabel.textAlignment = .center
            myView.addSubview(myLabel)
            return myView
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 60
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 0{
            self.countryTf.text = Countries[row]
            if row == 0{
                self.egypt = 1
                self.china = 0
                self.england = 0
                self.vietnam = 0
            }else if row == 1{
                self.egypt = 0
                self.china = 1
                self.england = 0
                self.vietnam = 0
            }else if row == 2{
                self.egypt = 0
                self.china = 0
                self.england = 1
                self.vietnam = 0
            }else{
                self.egypt = 0
                self.china = 0
                self.england = 0
                self.vietnam = 1
            }
            helper.saveCountryId(country: images[row])
        }else {
            self.typeTf.text = sections[row].title
            self.sectionId = sections[row].id ?? 0
            self.categorisIDs.removeAll()
            self.categoriesHandelRefresh()
        }
    }
    
}
//TableView
extension filter: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryFilterCell", for: indexPath) as! categoryFilterCell
        cell.configure(category: categories[indexPath.row])
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if !categorisIDs.contains(categories[indexPath.row].id ?? 0){
            categorisIDs.append(categories[indexPath.row].id ?? 0)
        }
        print(categorisIDs)
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        var currentIndex = 0
        for id in categorisIDs{
            if id == categories[indexPath.row].id {
                categorisIDs.remove(at: currentIndex)
                break
            }
            currentIndex += 1
        }
        print(categorisIDs)
    }
    
}

extension filter: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return seasons.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "seasonCell", for: indexPath) as! seasonCell
        cell.configure(season: seasons[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenWidth = collectionView.frame.width
        let width = (screenWidth-10)/4
        return CGSize.init(width: width, height: 75)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        seasonId = seasons[indexPath.item].id ?? 0
    }
    
}
