//
//  ViewController.swift
//  Sections
//
//  Created by Nestor Sotres on 3/12/16.
//  Copyright © 2016 Nestor Sotres. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {

    let sectionsTableIdentifier = "SectionsTableIdentifier"
    var names: [String : [String]]!
    var keys: [String]!
    var searchController: UISearchController!
    
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tableView.registerClass(UITableViewCell.self , forCellReuseIdentifier: sectionsTableIdentifier)
        
        let path = NSBundle.mainBundle().pathForResource("sortednames", ofType: "plist")
        let namesDict = NSDictionary(contentsOfFile: path!)
        names = namesDict as! [String: [String]]
        //assign all keys as an array of Strings
        keys = namesDict?.allKeys as! [String]
        //sort the array of keys and store in same variable
        keys = keys.sort()
        
        //Add search controller code
        
        //set names and keys properties
        let resultsController = SearchResultsControllerTableViewController()
        resultsController.names = names
        resultsController.keys = keys
        //create a search controller and pass a ref to the results controller created, this presents this view with the results
        searchController = UISearchController(searchResultsController: resultsController)
        let searchBar = searchController.searchBar
        searchBar.scopeButtonTitles = ["All", "Short", "Long"]
        searchBar.placeholder = "Enter a search term"
        //connect search controller to UI. get the search bar and install it as the header view of the table in the main view controller
        searchBar.sizeToFit()   //gives size to toolbar so in case phone is flipped
        tableView.tableHeaderView = searchBar
        //Each time the user types something into the search bar, UISearchController uses the object stored in its searchResultsUPdater property to update the search results.
        searchController.searchResultsUpdater = resultsController
        
        //fixing some UI stuff
        tableView.sectionIndexBackgroundColor = UIColor.blackColor()
        tableView.sectionIndexTrackingBackgroundColor = UIColor.darkGrayColor()
        tableView.sectionIndexColor = UIColor.whiteColor()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    // MARK: Table View Data Source Methods
    
    //number of sections
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return keys.count
    }
    
    //calculate number of rows in each section
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let key = keys[section]
        let nameSection = names[key]!
        return nameSection.count
    }
    
    //specify optional header in each section
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return keys[section]
    }
    
    //extract both the section key and names array using the section and row properties from the index path, and use those to determine value
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(sectionsTableIdentifier, forIndexPath: indexPath) as UITableViewCell
        let key = keys[indexPath.section]
        let nameSection = names[key]!
        cell.textLabel?.text = nameSection[indexPath.row]
        return cell
    }
    
    
    func sectionIndexTitlesForTableView(tableView: UITableView) -> [String]? {
        return keys
    }
    
    
    
    
    
    

}

