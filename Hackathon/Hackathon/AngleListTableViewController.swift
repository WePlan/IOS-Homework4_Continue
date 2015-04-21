//
//  AngleListTableViewController.swift
//  Hackathon
//
//  Created by Kan Chen on 4/14/15.
//  Copyright (c) 2015 NYU-poly. All rights reserved.
//

import UIKit

class AngleListTableViewController: UITableViewController , UISearchBarDelegate, UITableViewDelegate, CLLocationManagerDelegate{
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var segment: UISegmentedControl!
    @IBOutlet weak var locationSwitch: UIBarButtonItem!
    @IBOutlet weak var byCurrentLocation: UISwitch!
    
    var myData: [CellData] = []
    var myFilterData: [CellData] = []
    var selected: Int = 0
    var searchState: Bool = false
    
    /*Get location*/
    var location:String=""
    let locationManager = CLLocationManager()
    
    var refreshing: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.estimatedRowHeight = tableView.rowHeight
        tableView.rowHeight = UITableViewAutomaticDimension
        searchBar.delegate = self
        
        /* get location */
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy=kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        updateData()
       
        configureSegment()
        
        self.refreshControl = UIRefreshControl()
        self.refreshControl?.addTarget(self, action: "handleRefresh", forControlEvents: UIControlEvents.ValueChanged)
    }
    
    @IBAction func switchMoved(sender: UISwitch) {
        if self.byCurrentLocation.on {
            self.locationManager.startUpdatingLocation()
            let alertController = UIAlertController(title: "Notification", message: "You are currently at \(self.location), only the records satisfied the location limitation will be displayed.", preferredStyle: .ActionSheet)
            let okAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
            alertController.addAction(okAction)
            presentViewController(alertController, animated: true, completion: nil)
        }
        updateData()
    }
    
    func handleRefresh() {
        if self.refreshing {
            println("handle: \(self.refreshing)")
            return
        }
        self.myData = []
        self.refreshing = true
        self.refreshControl?.enabled = false
        var requestItem = request(.GET, "https://api.angel.co/1/jobs?access_token=ea35df8ec5d8542d06b196d4a50bba2ac34616d448bfd3c0&page=\(1)")
        
        requestItem.responseJSON{(request,response,data,error) in
            var json = JSON(data!)
            
            for (key: String, subJson: JSON) in json["jobs"] {
                var newData: CellData?
                //Job info
                let jobTitle = subJson["title"].string ?? ""
                let jobType = subJson["job_type"].string ?? ""
                let jobDesc = subJson["description"].string ?? ""
                let createAt = subJson["created_at"].string ?? ""
                let updateAt = subJson["updated_at"].string ?? ""
                let salaryMin = subJson["salary_min"].string ?? ""
                let salaryMax = subJson["salary_max"].string ?? ""
                let angellistURL = subJson["angellist_url"].string ?? ""
                //company info
                let companyName = subJson["startup"]["name"].string ?? ""
                let companyFDesc = subJson["startup"]["product_desc"].string ?? ""
                let companyHDesc = subJson["startup"]["high_concept"].string ?? ""
                let img = subJson["startup"]["logo_url"].string ?? "no image"
                let companyURL = subJson["startup"]["company_url"].string ?? ""
                //tags info
                var tags = [tag]()
                for (keyTag: String, eachtag: JSON) in subJson["tags"]{
                    let tagType = eachtag["tag_type"].string ?? ""
                    let tagName = eachtag["display_name"].string ?? ""
                    tags.append(tag(tagType: tagType, tagName: tagName))
                }
                if !self.byCurrentLocation.on {
                newData = CellData(jobTitle: jobTitle, jobType: jobType, createdAt: createAt, updatedAt: updateAt, salaryMin: salaryMin, salaryMax: salaryMax, jobDesc: jobDesc, angellistURL: angellistURL, companyName: companyName, companyFDesc: companyFDesc, companyHDesc: companyHDesc, companyLogoURL: img, companyURL: companyURL, tags: tags)
                }
                else{
                    for tag in tags{
                        //Compare with current location
                        if tag.tagType == "LocationTag"{
                            var taglocation = tag.tagName;
                            if taglocation.hasPrefix(self.location) {
                                newData = CellData(jobTitle: jobTitle, jobType: jobType, createdAt: createAt, updatedAt: updateAt, salaryMin: salaryMin, salaryMax: salaryMax, jobDesc: jobDesc, angellistURL: angellistURL, companyName: companyName, companyFDesc: companyFDesc, companyHDesc: companyHDesc, companyLogoURL: img, companyURL: companyURL, tags: tags)
                                break;
                            }
                        }
                    }
                }
                
                if newData != nil {
                    self.myData.append(newData!)
                }
            }//for
            self.refreshControl?.endRefreshing()
            self.tableView.reloadData()
            self.refreshing = false
            self.refreshControl?.enabled = true
        }//end closure

    }
    
    private func updateData() {
        self.myData = []
        var requestItem = request(.GET, "https://api.angel.co/1/jobs?access_token=ea35df8ec5d8542d06b196d4a50bba2ac34616d448bfd3c0&page=\(1)")
        refreshing = true
        requestItem.responseJSON{(request,response,data,error) in
            var json = JSON(data!)
            
            for (key: String, subJson: JSON) in json["jobs"] {
                var newData: CellData?
                //Job info
                let jobTitle = subJson["title"].string ?? ""
                let jobType = subJson["job_type"].string ?? ""
                let jobDesc = subJson["description"].string ?? ""
                let createAt = subJson["created_at"].string ?? ""
                let updateAt = subJson["updated_at"].string ?? ""
                let salaryMin = subJson["salary_min"].string ?? ""
                let salaryMax = subJson["salary_max"].string ?? ""
                let angellistURL = subJson["angellist_url"].string ?? ""
                //company info
                let companyName = subJson["startup"]["name"].string ?? ""
                let companyFDesc = subJson["startup"]["product_desc"].string ?? ""
                let companyHDesc = subJson["startup"]["high_concept"].string ?? ""
                let img = subJson["startup"]["logo_url"].string ?? "no image"
                let companyURL = subJson["startup"]["company_url"].string ?? ""
                //tags info
                
                var tags = [tag]()
                for (keyTag: String, eachtag: JSON) in subJson["tags"]{
                    let tagType = eachtag["tag_type"].string ?? ""
                    let tagName = eachtag["display_name"].string ?? ""
                    tags.append(tag(tagType: tagType, tagName: tagName))
                }
                
                if !self.byCurrentLocation.on {
                    newData = CellData(jobTitle: jobTitle, jobType: jobType, createdAt: createAt, updatedAt: updateAt, salaryMin: salaryMin, salaryMax: salaryMax, jobDesc: jobDesc, angellistURL: angellistURL, companyName: companyName, companyFDesc: companyFDesc, companyHDesc: companyHDesc, companyLogoURL: img, companyURL: companyURL, tags: tags)
                }
                else{
                    for tag in tags{
                        //Compare with current location
                        if tag.tagType == "LocationTag"{
                            var taglocation = tag.tagName;
                            if taglocation.hasPrefix(self.location) {
                                newData = CellData(jobTitle: jobTitle, jobType: jobType, createdAt: createAt, updatedAt: updateAt, salaryMin: salaryMin, salaryMax: salaryMax, jobDesc: jobDesc, angellistURL: angellistURL, companyName: companyName, companyFDesc: companyFDesc, companyHDesc: companyHDesc, companyLogoURL: img, companyURL: companyURL, tags: tags)
                                break;
                            }
                        }
                    }
                }
                if newData != nil {
                    self.myData.append(newData!)
                }
            }
            self.tableView.reloadData()
            self.refreshing = false
            println("viewdidload: \(self.refreshing)")
        }//end closure
    }
    
    private func configureSegment () {
        self.segment.setTitle("Company", forSegmentAtIndex: 0)
        self.segment.setTitle("Job", forSegmentAtIndex: 1)
//        self.segment.setTitle("Salary", forSegmentAtIndex: 2)
        self.segment.setTitle("type", forSegmentAtIndex: 2)
    }
    // MARK: - StoryBoardConstants
    private struct StoryBoardConstants {
        static let detailSegue = "jobDetail"
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        var numberOfRows = 0 ;
        if searchState {
            numberOfRows = self.myFilterData.count
        }else {
            numberOfRows = self.myData.count
        }
        return numberOfRows
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("protojob", forIndexPath: indexPath) as! AngleTableViewCell

        // Configure the cell...
        if searchState {
            cell.Jobtitle.text = myFilterData[indexPath.row].jobTitle
            cell.Companytitle.text = myFilterData[indexPath.row].companyName
            cell.logourl = NSURL(string: myFilterData[indexPath.row].companyLogoURL)
        }else {
            cell.Jobtitle.text = myData[indexPath.row].jobTitle
            cell.Companytitle.text = myData[indexPath.row].companyName
            cell.logourl = NSURL(string: myData[indexPath.row].companyLogoURL)
        }
        return cell
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //println("eee")
        self.selected = indexPath.row
        self.performSegueWithIdentifier(StoryBoardConstants.detailSegue, sender: self)
    }
    
    override func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        self.searchBar.resignFirstResponder()
    }
    //MARK: - Location Kit
    
    /* Get Location*/
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        CLGeocoder().reverseGeocodeLocation(manager.location, completionHandler: { (placemarks, error)
            -> Void in
            if error != nil {
                println("Error:"+error.localizedDescription)
                return
            }
            
            if placemarks.count>0{
                let pm=placemarks[0] as! CLPlacemark
                self.displayLoactionInfo(pm)
            }
            else{
                println("error with data")
            }
            
        })
    }
    
    
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        println("error: "+error.localizedDescription)
    }
    
    func displayLoactionInfo(placemark:CLPlacemark){
        self.locationManager.stopUpdatingLocation()
        location=placemark.locality
        println(location)
        println(placemark.administrativeArea)
        
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */
    
    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    // MARK: - Search Bar
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
    
        self.searchBar.showsCancelButton = true
        if count(searchText) == 0 {
            self.searchState = false
            self.searchBar.showsCancelButton = false
            self.tableView.reloadData()
            return
        }
        
        self.searchState = true
        
        var originArray = NSArray()
//        println("we have \(myData.count) rows")
        self.myFilterData = []
        for var i = 0; i < myData.count ; i++ {
            switch self.segment.selectedSegmentIndex {
            case 0: // company name
                let predicate: NSPredicate = NSPredicate(format: "self contains [cd] %@",searchText)
                if predicate.evaluateWithObject(myData[i].companyName) {
                    self.myFilterData.append(self.myData[i])
                }
            case 1: // job title
                let predicate: NSPredicate = NSPredicate(format: "self contains [cd] %@",searchText)
                if predicate.evaluateWithObject(myData[i].jobTitle) {
                    self.myFilterData.append(self.myData[i])
                }
//            case 2: //
//                if searchText.toInt() != nil {
//                    let predicate: NSPredicate = NSPredicate(format: "self >= %d",searchText.toInt()!)
//                    if let min = myData[i].salaryMin.toInt() {
//                        if predicate.evaluateWithObject(min) {
//                            self.myFilterData.append(self.myData[i])
//                        }
//                    }
//                }
            case 2:
                let predicate: NSPredicate = NSPredicate(format: "self contains [cd] %@",searchText)
                if predicate.evaluateWithObject(myData[i].jobType) {
                    self.myFilterData.append(self.myData[i])
                }
            default:
                break
            }
        }
        self.tableView.reloadData()
        
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        self.searchBar.text = ""
        self.searchBar(self.searchBar, textDidChange: "")
        self.searchBar.showsCancelButton = false
        self.searchBar.resignFirstResponder()
    }
    
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        self.searchBar.showsCancelButton = false
        self.searchBar.resignFirstResponder()
    }
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == StoryBoardConstants.detailSegue {
            if let jobDetailController = segue.destinationViewController as? jobDetailViewController {
                if searchState {
                    jobDetailController.jobDetail = myFilterData[selected]
                }else {
                    jobDetailController.jobDetail = myData[selected]
                }
                
            }
        }
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    

}
