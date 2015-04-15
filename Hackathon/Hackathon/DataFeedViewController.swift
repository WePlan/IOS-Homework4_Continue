//
//  DataFeedViewController.swift
//  Hackathon
//
//  Created by xi su on 4/14/15.
//  Copyright (c) 2015 NYU-poly. All rights reserved.
//

import UIKit
import UIKit
//import Alamofire
class DataFeedViewController: UIViewController {
    
    struct tag {
        var tagType : String
        var tagName : String
    }
    
    struct CellData {
        
        var jobTitle : String
        var jobType : String
        var createdAt : String
        var updatedAt : String
        var salaryMin : String
        var salaryMax : String
        var jobDesc : String
        var angellistURL : String
        
        var companyName : String
        var companyFDesc : String
        var companyHDesc : String
        var companyLogoURL : String
        var companyURL : String
        
        var tags : [tag]
    }
    
    var myData : [CellData] = []
    
    var json:JSON = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for i in 0...9{
            var requestItem = request(.GET, "https://api.angel.co/1/jobs?access_token=ea35df8ec5d8542d06b196d4a50bba2ac34616d448bfd3c0&page=\(i)")
            
            requestItem.responseJSON{
                (request,response,data,error) in
                self.json[i] = JSON(data!)
                println(self.json)
                
                for (key: String, subJson: JSON) in self.json[i]["jobs"] {
                    
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
                    
                    self.myData.append(CellData(jobTitle: jobTitle, jobType: jobType, createdAt: createAt, updatedAt: updateAt, salaryMin: salaryMin, salaryMax: salaryMax, jobDesc: jobDesc, angellistURL: angellistURL, companyName: companyName, companyFDesc: companyFDesc, companyHDesc: companyHDesc, companyLogoURL: img, companyURL: companyURL, tags: tags))
                    
                    
                }
            }
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
