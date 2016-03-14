//
//  SearchResultsControllerTableViewController.swift
//  Sections
//
//  Created by Nestor Sotres on 3/13/16.
//  Copyright © 2016 Nestor Sotres. All rights reserved.
//

import UIKit

class SearchResultsControllerTableViewController: UITableViewController, UISearchResultsUpdating {

    let sectionsTableIdentifier = "SectionsTableIdentifier"
    var names: [String: [String]] = [String: [String]]()
    var keys: [String] = []
    var filteredNames: [String] = []
    
    private let longNameSize = 6
    private let shortNamesButtonIndex = 1
    private let longNamesButtonIndex = 2
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.registerClass(UITableViewCell.self , forCellReuseIdentifier: sectionsTableIdentifier)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return filteredNames.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(sectionsTableIdentifier)! as UITableViewCell
        cell.textLabel?.text = filteredNames[indexPath.row]
        return cell
    }

    
    // MARK: UISearchResultsUpdating Conformance
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        let searchString = searchController.searchBar.text
        let buttonIndex = searchController.searchBar.selectedScopeButtonIndex
        filteredNames.removeAll(keepCapacity: true)
        
        if ((searchString?.isEmpty) == false){
            let filter: String -> Bool = { name in
                //Filter out long or short names depending on which scope button is selected
                let nameLength =  self.names.count // depricated: countElements(name)
                if (buttonIndex == self.shortNamesButtonIndex && nameLength >= self.longNameSize) || (buttonIndex == self.longNamesButtonIndex && nameLength < self.longNameSize) {
                    return false
                }
                
                let range = name.rangeOfString(searchString!, options: NSStringCompareOptions.CaseInsensitiveSearch)
                return range != nil
        }
            for key in keys {
                let namesForKey = names[key]!
                let matches = namesForKey.filter(filter)
                filteredNames += matches
                
            }
        }
        tableView.reloadData()
        
    }
    
    
    
    
    
}














