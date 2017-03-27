//
//  TblSearchResultCell.swift
//  TDAutocompletePlace
//
//  Created by thedahiyaboy on 21/03/17.
//  Copyright © 2017 thedahiyaboy. All rights reserved.
//

import UIKit

class TblSearchResultCell: UITableViewCell {

    var lblResult = UILabel()
   
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: "searchResultCell")
        
         NotificationCenter.default.addObserver(self, selector: #selector(self.rotated), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
        
       // lblResult.backgroundColor = UIColor.black
        
        lblResult.frame = CGRect(x          :   5  ,
                                 y          :   self.frame.origin.y,
                                 width      :   self.frame.size.width ,
                                 height     :   self.frame.size.height)
        
        lblResult.textColor = UIColor.gray
        lblResult.textAlignment = .left
        
        lblResult.font = UIFont(name: "HelveticaNeue", size:13.0)
        self.addSubview(lblResult)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func rotated() {
        
        lblResult.frame = CGRect(x          :   5 ,
                                 y          :   0 ,
                                 width      :   self.frame.size.width ,
                                 height     :   self.frame.size.height)
 
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
     
    }

}
