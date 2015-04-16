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
//    @IBOutlet weak var jobAndCompanyText: UITextView!
    
    @IBOutlet weak var jobAndCompanyText: UILabel!
    
    //if have time could impletement this to mark as interested
    @IBOutlet weak var markAsInterestedButton: UIButton!
    var selected = false
    @IBAction func markAsInterested(sender: UIButton) {
        
        selected = !selected
        
        if selected {
            markAsInterestedButton.setImage(UIImage(named: "Favorite-selected"), forState: UIControlState.Normal)
        }else{
            markAsInterestedButton.setImage(UIImage(named: "Favorite"), forState: UIControlState.Normal)
        }
        
        
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
        locationTagLabel?.text = ""
        jobRoleTagLabel?.text = ""
        skillTagText?.text = ""
        for tag in jobDetail!.tags {
        
            if tag.tagType == JobDetailConstants.RollTag {
                let dot = jobRoleTagLabel?.text == "" ? "": "·"
                jobRoleTagLabel?.text?.extend(dot + tag.tagName ?? "")
            }
            if tag.tagType == JobDetailConstants.LocationTag {
                locationTagLabel?.text?.extend(tag.tagName ?? "")
            }
            if tag.tagType == JobDetailConstants.SkillTag {
                let dot = skillTagText?.text == "" ? "": " · "
                skillTagText?.text?.extend(dot + tag.tagName ?? "")
            }

            
        }
        let divideSign = jobDetail!.salaryMin != "" && jobDetail!.salaryMax != "" ? "~" : ""
        salaryLabel?.text = jobDetail!.salaryMin + divideSign + jobDetail!.salaryMax
        
        let jobDescAttr = [NSFontAttributeName:UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)]
        let companyNameAttr = [NSFontAttributeName:UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)]
        let companySDescAttr = [NSFontAttributeName:UIFont.preferredFontForTextStyle(UIFontTextStyleCaption2)]
        let urlAttr = [NSFontAttributeName:UIFont.preferredFontForTextStyle(UIFontTextStyleCaption2),NSForegroundColorAttributeName:UIColor.blueColor()]
        let companyDescAttr = [NSFontAttributeName:UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)]
        
        var textViewContent = NSMutableAttributedString()
        let jobInfo = NSAttributedString(string: jobDetail!.jobDesc, attributes: jobDescAttr)
        let compTitle = NSAttributedString(string: "\n\n" + jobDetail!.companyName + ":", attributes: companyNameAttr)
        let compShortInfo = NSAttributedString(string: "\t" + jobDetail!.companyHDesc, attributes: companySDescAttr)
        let compURL = NSAttributedString(string: "\n" + jobDetail!.companyURL, attributes: urlAttr)
        let compInfo = NSAttributedString(string: "\n\n" + jobDetail!.companyFDesc, attributes: companyDescAttr)
        
        textViewContent.appendAttributedString(jobInfo)
        textViewContent.appendAttributedString(compTitle)
        textViewContent.appendAttributedString(compShortInfo)
        textViewContent.appendAttributedString(compURL)
        textViewContent.appendAttributedString(compInfo)
        
        
        jobAndCompanyText?.attributedText = textViewContent
        jobAndCompanyText.layer.cornerRadius = 10.0
        jobAndCompanyText.layer.shadowOpacity = 0.9
        jobAndCompanyText.layer.shadowOffset = CGSize(width: 0, height: 5)
        
//        jobAndCompanyText.layer.masksToBounds = false


        
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
