//
//  AddressSearchViewController+UITableView.swift
//  walkstreets-ios
//
//  Created by Roman Ustiantcev on 08/05/2017.
//  Copyright © 2017 Roman Ustiantcev. All rights reserved.
//

import UIKit
import MapKit

extension AddressSearchViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "addressSearchCell", for: indexPath) as! AddressSearchCell
        
        if let selectedItem = (output.matchingItems?[indexPath.row] as? MKMapItem)?.placemark {
            cell.setItemLabel(text: parseAddress(selectedItem: selectedItem))
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let count = output.matchingItems?.count {
            return count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }

}


extension AddressSearchViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        output.pointAddress(index: indexPath.row)
    }
}
