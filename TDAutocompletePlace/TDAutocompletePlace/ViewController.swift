//
//  ViewController.swift
//  TDAutocompletePlace
//
//  Created by thedahiyaboy on 21/03/17.
//  Copyright © 2017 thedahiyaboy. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    
    //MARK:
    //MARK: IBOutlet
    
    
    
    @IBOutlet var searchTextfield: TDAutocompletionTextfield!
   
    @IBOutlet var thirdTF: TDAutocompletionTextfield!
    @IBOutlet var mySecondTF: TDAutocompletionTextfield!
    //MARK:
    //MARK: Properties
    
    let apiKey = "AIzaSyBIFOjnmF6zdtduZO9YLS5ZLXbt9n7xYic"
    
    //MARK:
    //MARK: VDL

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
     searchTextfield.initWith(self, apiKey: apiKey, forCountryCode: nil) { (result) in
            print(result)
      }
     
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.view.endEditing(true)
    }
}










