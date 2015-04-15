//
//  AngleListTableViewController.swift
//  Hackathon
//
//  Created by Kan Chen on 4/14/15.
//  Copyright (c) 2015 NYU-poly. All rights reserved.
//

import UIKit

class AngleListTableViewController: UITableViewController , UISearchBarDelegate, UITableViewDelegate {
//    struct tag {
//        var tagType : String
//        var tagName : String
//    }
    
//    struct CellData {
//        
//        var jobTitle : String
//        var jobType : String
//        var createdAt : String
//        var updatedAt : String
//        var salaryMin : String
//        var salaryMax : String
//        var jobDesc : String
//        var angellistURL : String
//        
//        var companyName : String
//        var companyFDesc : String
//        var companyHDesc : String
//        var companyLogoURL : String
//        var companyURL : String
//        
//        var tags : [tag]
//    }
    
    
    var myData: [CellData] = []
    var selected: Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.estimatedRowHeight = tableView.rowHeight
        tableView.rowHeight = UITableViewAutomaticDimension
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        for i in 1...1{
            var requestItem = request(.GET, "https://api.angel.co/1/jobs?access_token=ea35df8ec5d8542d06b196d4a50bba2ac34616d448bfd3c0&page=\(i)")
            
            requestItem.responseJSON{
                (request,response,data,error) in
                var json = JSON(data!)
//                println(self.json)
                
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
                    
                    newData = CellData(jobTitle: jobTitle, jobType: jobType, createdAt: createAt, updatedAt: updateAt, salaryMin: salaryMin, salaryMax: salaryMax, jobDesc: jobDesc, angellistURL: angellistURL, companyName: companyName, companyFDesc: companyFDesc, companyHDesc: companyHDesc, companyLogoURL: img, companyURL: companyURL, tags: tags)
//                    //Job info
//                    let jobTitle = subJson["title"].string ?? ""
//                    let jobDesc = subJson["description"].string ?? ""
//                    var tags = [String]()
//                    for (keyTag: String, tag: JSON) in subJson["tags"]{
//                        tags.append(tag["display_name"].string ?? "")
//                    }
//                    let createAt = subJson["created_at"].string ?? ""
//                    let jobType = subJson["job_type"].string ?? ""
//                    //                println("tag:\(tags)")
////                    newData.jobTitle = jobTitle
//                    //company info
//                    if subJson["startup"] != nil{
//                        let companyName = subJson["startup"]["name"].string ?? ""
//                        let img = subJson["startup"]["logo_url"].string ?? "no image"
//                        let smallImg = subJson["startup"]["thumb_url"].string ?? ""
//                        let companyShortDesc = subJson["startup"]["high_concept"].string ?? ""
//                        
//                        let companyURL = subJson["startup"]["company_url"].string ?? ""
//                        let companyFullDesc = subJson["startup"]["product_desc"].string ?? ""
//                        // println("Description:\(jobDesc)")
//                        //println("url_logo:\(img)")
//                        //println("company_short_concept:\(companyShortDesc)")
//                        newData = CellData(jobTitle: jobTitle, company: companyName, logoURL: img)
////                        newData.company = companyName
////                        newData.logoURL = img
//                    }
                    if newData != nil {
                        self.myData.append(newData!)
                    }
                }
                
                self.tableView.reloadData()
            }//end closure
        }
        

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
        return self.myData.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("protojob", forIndexPath: indexPath) as! AngleTableViewCell

        // Configure the cell...
        cell.Jobtitle.text = myData[indexPath.row].jobTitle
        cell.Companytitle.text = myData[indexPath.row].companyName
        cell.logourl = NSURL(string: myData[indexPath.row].companyLogoURL)
        return cell
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        println("eee")
        self.selected = indexPath.row
//        performSegueWithIdentifier(StoryBoardConstants.detailSegue, sender: self)
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

    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        //
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == StoryBoardConstants.detailSegue {
            if let jobDetailController = segue.destinationViewController as? jobDetailViewController {
                jobDetailController.jobDetail = myData[selected]
                
            }
        }
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    

}
