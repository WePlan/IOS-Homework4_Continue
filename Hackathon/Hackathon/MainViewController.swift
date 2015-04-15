//
//  MainViewController.swift
//  Hackathon
//
//  Created by Kan Chen on 4/14/15.
//  Copyright (c) 2015 NYU-poly. All rights reserved.
//

import UIKit

//import JsonSerializer

//import class JsonSerializer.JsonParser
//import enum JsonSerializer.Json

class MainViewController: UIViewController , UITableViewDataSource, UITableViewDelegate{

    @IBOutlet weak var myTableView: UITableView!
    
    
    var json: JSON = []
    var selected: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        myTableView.dataSource = self
        myTableView.delegate = self
        
        request(.GET, "http://engineering.nyu.edu/poly_pages/api/news", parameters: ["limit": 50])
            .responseJSON { (request, response, data, error) in
                
                self.json = JSON(data!)
               
//                for (key: String, subJson: JSON) in self.json {
//                    
//                    let title = subJson["title"].string!
//                    let img = subJson["image"].string ?? "no image"
//                    
//                    
//                }
                self.myTableView.reloadData()
        }
        
    }

    
    private struct StoryBoardConstants {
        static let protoCellIdentifier = "protoCellOne"
        static let detailSegue = "showDetail"
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.json.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(StoryBoardConstants.protoCellIdentifier , forIndexPath: indexPath) as! UITableViewCell
        cell.accessoryType = UITableViewCellAccessoryType.DetailButton
        cell.textLabel?.text = self.json[indexPath.row]["title"].string
//        cell.detailTextLabel?.text = self
        
        cell.selectionStyle = UITableViewCellSelectionStyle.Default
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        tableView.deselectRowAtIndexPath(indexPath, animated: false)
        self.selected = indexPath.row
        println("selected:\(selected)")
        performSegueWithIdentifier(StoryBoardConstants.detailSegue, sender: self)
    }
    
    // MARK: - Foot & Header
    
//    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 30
//    }
//    
//    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        return self.newLabelwithTitle("News")
//    }
//    
//    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
//        return self.newLabelwithTitle("End")
//    }
    
    // MARK: - My Function 
    
    func newLabelwithTitle(title: String) -> UILabel {
        let label = UILabel()
        label.text = title
        label.backgroundColor = UIColor.clearColor()
        label.sizeToFit()
        return label
    }
    
    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == StoryBoardConstants.detailSegue {
            var vc = segue.destinationViewController as! DetailViewController
            vc.json = self.json[selected]
        }
    }
    

}
