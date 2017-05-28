//
//  AddressSearchAddressSearchViewController.swift
//  walkstreets-ios
//
//  Created by Roman Ustiantcev on 04/05/2017.
//  Copyright © 2017 Urbica. All rights reserved.
//

import UIKit
import MapKit

class AddressSearchViewController: UIViewController, AddressSearchViewInput {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textField: CustomizableTextField!

    var output: AddressSearchViewOutput!

    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        AddressSearchModuleConfigurator().configureModuleForViewInput(viewInput: self)
        output.viewIsReady()
        setupInitialState()
    }


    // MARK: AddressSearchViewInput
    func setupInitialState() {
        textField.becomeFirstResponder()
    }
    
    func reloadData() {
        tableView.reloadData()
    }
    
    func parseAddress(selectedItem:MKPlacemark) -> String {
        let firstSpace = (selectedItem.subThoroughfare != nil && selectedItem.thoroughfare != nil) ? " " : ""
        // put a comma between street and city/state
        let comma = (selectedItem.subThoroughfare != nil || selectedItem.thoroughfare != nil) && (selectedItem.subAdministrativeArea != nil || selectedItem.administrativeArea != nil) ? ", " : ""
        // put a space between "Washington" and "DC"
        let secondSpace = (selectedItem.subAdministrativeArea != nil && selectedItem.administrativeArea != nil) ? " " : ""
        let addressLine = String(
            format:"%@%@%@%@%@%@",
            // street number
            selectedItem.subThoroughfare ?? "",
            firstSpace,
            // street name
            selectedItem.thoroughfare ?? "",
            comma,
            // city
            selectedItem.locality ?? "",
            secondSpace
        )
        return addressLine
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if segue.identifier == "toAddressPoint" {
            let vc = segue.destination as! AddressPointViewController
            vc.selectedItem = sender as? MKMapItem
        }
    }

}

extension AddressSearchViewController {
    //MARK: actions
    
    @IBAction func actionBack(sender: AnyObject) {
        output.actionBack()
    }
    
    @IBAction func searchFieldDidChange(_ sender: CustomizableTextField) {
        guard let count = textField.text?.characters.count, count > 0 else { output.clearData();return}
        output.searchTextChanged(text: sender.text!)
    }
    
    @IBAction func actionPointOnMap(sender: AnyObject) {
        output.pointOnMap()
    }
}
