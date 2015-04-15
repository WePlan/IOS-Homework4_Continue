//
//  jobDetailViewController.swift
//  Hackathon
//
//  Created by Kan Chen on 4/14/15.
//  Copyright (c) 2015 NYU-poly. All rights reserved.
//

import UIKit

class jobDetailViewController: UIViewController {
    var jobDetail: CellData?
//    {
//        didSet{
//            updateData()
//        }
//    }

    // MARK: JobDetailConstants
    private struct JobDetailConstants {
        static let RollTag = "RoleTag"
        static let LocationTag = "LocationTag"
        static let SkillTag = "SkillTag"
    }
    @IBOutlet weak var companyLogo: AsyncImageView!
    @IBOutlet weak var companyNameLabel: UILabel!
    @IBOutlet weak var jobTitleLabel: UILabel!
    @IBOutlet weak var jobRoleTagLabel: UILabel!
    @IBOutlet weak var jobTypeLabel: UILabel!
    @IBOutlet weak var locationTagLabel: UILabel!
    @IBOutlet weak var salaryLabel: UILabel!
    @IBOutlet weak var skillTagText: UILabel!
    @IBOutlet weak var jobAndCompanyText: UITextView!
    
    
    //if have time could impletement this to mark as interested
    @IBOutlet weak var markAsInterestedButton: UIButton!
    @IBAction func markAsInterested(sender: UIButton) {
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
//        updateData()

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        updateData()
    }
    func updateData() {
        companyLogo?.url = NSURL(string:jobDetail!.companyLogoURL ?? "")

        companyNameLabel?.text = jobDetail!.companyName
        jobTitleLabel?.text = jobDetail!.jobTitle ?? ""
        jobTypeLabel?.text = jobDetail!.jobType ?? ""
        
        for tag in jobDetail!.tags {
        
            if tag.tagType == JobDetailConstants.RollTag {
                let dot = jobRoleTagLabel?.text == "" ? "": "."
                jobRoleTagLabel?.text?.extend(dot + tag.tagName ?? "")
            }
            if tag.tagType == JobDetailConstants.LocationTag {
                locationTagLabel?.text?.extend(tag.tagName ?? "")
            }
            if tag.tagType == JobDetailConstants.SkillTag {
                let dot = skillTagText?.text == "" ? "": "."
                skillTagText?.text?.extend(dot + tag.tagName ?? "")
            }

            
        }
        salaryLabel?.text = jobDetail!.salaryMin + " ~ " + jobDetail!.salaryMax
        let description = jobDetail!.jobDesc + jobDetail!.companyFDesc
        jobAndCompanyText?.text = description
        
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
