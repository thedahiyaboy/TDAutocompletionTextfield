//
//  TDAutocompletionTextfield.swift
//  TDAutocompletePlace
//
//  Created by thedahiyaboy on 21/03/17.
//  Copyright © 2017 thedahiyaboy. All rights reserved.
//

import UIKit

class TDAutocompletionTextfield: UITextField, UITextFieldDelegate , UITableViewDelegate, UITableViewDataSource{
    
    //MARK:
    //MARK: Properties
    let baseURL = "https://maps.googleapis.com/maps/api/place/autocomplete/json?"
    var apiKey : String!
    
    let cellID = "searchResultCell"
    
    var tblSearchResult = UITableView()
    var viewSearchResult = UIView()
    var lblNoResult = UILabel()
    var tfFrame : CGRect!
    var activeVC : UIViewController?
    var countryCode : String?
    
    var arrSearchResult: [Dictionary<String,Any>] = []
    
    var selectedPlaceLocal: ((Dictionary<String,Any>) -> (Void))?
    
    //MARK:
    //MARK: Init
    
    func initWith(_ vc : UIViewController , apiKey : String, forCountryCode code: String? , selectedPlace : @escaping (Dictionary<String,Any>) -> Void)  {
        self.activeVC = vc
        self.apiKey = apiKey
        self.countryCode = code
        
        self.clearButtonMode = UITextFieldViewMode.whileEditing 
        
        self.tblSearchResult.delegate = self
        self.tblSearchResult.dataSource = self
        
        self.tblSearchResult.register(TblSearchResultCell.classForCoder(), forCellReuseIdentifier: cellID)
       
        self.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        NotificationCenter.default.addObserver(self, selector: #selector(self.rotated), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
        
        selectedPlaceLocal = selectedPlace
        
        self.tfFrame = CGRect(x: 0, y: 0, width: 0, height: 0)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.delegate = self
    }
    
    //MARK:
    //MARK: Orientation
    
    func rotated() {
        self.tfFrame = self.superview?.convert(self.frame, to: self.activeVC?.view)
        self.viewSearchResult.frame = CGRect(x: self.tfFrame.origin.x ,
                                             y: self.tfFrame.origin.y + self.frame.size.height + 5,
                                             width: self.frame.size.width,
                                             height:  200)
        
        self.tblSearchResult.frame = CGRect(x: 0, y: 0,
                                            width : self.viewSearchResult.frame.width,
                                            height: self.viewSearchResult.frame.height)
        
        self.lblNoResult.frame = CGRect(x: 0, y: 0, width: self.viewSearchResult.frame.width, height: 40)
    }
    
    //MARK:
    //MARK: textField Delegate
    
    func textFieldDidChange(_ textField: UITextField) {
        
        if textField.text == "" {
            self.viewSearchResult.isHidden = true
        }
        else{
           self.callAPI(textField.text!)
            self.viewSearchResult.isHidden = false
        }
    }
    
    public func textFieldDidBeginEditing(_ textField: UITextField) {
       
        self.tfFrame = self.superview?.convert(self.frame, to: self.activeVC?.view)
        
        self.viewSearchResult.isHidden = false
        
        self.viewSearchResult.frame = CGRect(x: self.tfFrame.origin.x ,
                                             y: self.tfFrame.origin.y + self.frame.size.height + 5,
                                             width: self.frame.size.width,
                                             height:  200)
        
        self.viewSearchResult.layer.shadowColor = UIColor.black.cgColor
        self.viewSearchResult.layer.shadowOpacity = 0.5
        self.viewSearchResult.layer.shadowOffset = CGSize(width: 0.0, height: 5.0)
        self.viewSearchResult.layer.shadowRadius = 5.0
 
        self.viewSearchResult.backgroundColor = UIColor.white
    
        self.tblSearchResult.frame = CGRect(x: 0, y: 0,
                                            width : self.viewSearchResult.frame.width,
                                            height: self.viewSearchResult.frame.height)
        
        self.lblNoResult.frame = CGRect(x: 0, y: 0, width: self.viewSearchResult.frame.width, height: 40)
        self.lblNoResult.text = "No Result Found"
        self.lblNoResult.textAlignment = .center
        self.lblNoResult.textColor = UIColor.gray
        self.lblNoResult.font = UIFont(name: "HelveticaNeue", size:13.0)
        self.lblNoResult.backgroundColor = UIColor.white
        
        self.lblNoResult.clipsToBounds = true
        
        self.viewSearchResult.isHidden = true
         self.activeVC?.view.addSubview(viewSearchResult)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.viewSearchResult.isHidden = true
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        return true
    }
    
    //MARK:
    //MARK: API Call
    
    func callAPI(_ strSearch : String) {
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        let postURL = String("input=\(strSearch)&types=geocode&language=en&key=\(self.apiKey!)")
        
        var strURL = self.baseURL + postURL!
        
        if self.countryCode != nil {
            strURL = strURL + "&components=country:\(self.countryCode)"
        }
        
        strURL = strURL.replacingOccurrences(of: " ", with: "")
        
        let url = URL(string: strURL)!
        
        let task = session.dataTask(with: url, completionHandler: {
            (data, response, error) in
            
            if error != nil {
                print(error!.localizedDescription)
                
            } else {
                do {
                    if let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [String: Any]
                    {
                        self.arrSearchResult = json["predictions"] as! [Dictionary<String, Any>]
                        
                        self.viewSearchResult.isHidden = false
                        
                        if self.arrSearchResult.count > 0{
                            // result found
                            DispatchQueue.main.async(execute: {
                                self.viewSearchResult.isHidden = false
                                
                                self.lblNoResult.isHidden = true
                                self.lblNoResult.removeFromSuperview()
                                
                                self.viewSearchResult.addSubview(self.tblSearchResult)
                                
                                self.tblSearchResult.isHidden = false
                                
                                self.tblSearchResult.reloadData()
                            })
                        }
                        else{
                            // no result found
                            DispatchQueue.main.async(execute: {
                                self.viewSearchResult.isHidden = false
                                
                                self.tblSearchResult.isHidden = false
                                self.tblSearchResult.removeFromSuperview()
                                
                                self.viewSearchResult.addSubview(self.lblNoResult)
                                self.lblNoResult.isHidden = false
                                
                                })
                        }
                    }
                } catch {
                    print("error in JSONSerialization")
                }
            }
        })
        task.resume()
    }
    
    //MARK:
    //MARK: UITableView Delegate
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    //MARK:
    //MARK: UITableView Datasource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrSearchResult.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let searchResultCell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! TblSearchResultCell
        searchResultCell.lblResult.text = arrSearchResult[indexPath.row]["description"] as! String?
        
        return searchResultCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.text = arrSearchResult[indexPath.row]["description"] as! String?
        viewSearchResult.isHidden = true
        self.endEditing(true)
        self.selectedPlaceLocal!(arrSearchResult[indexPath.row])
    }
    
}




