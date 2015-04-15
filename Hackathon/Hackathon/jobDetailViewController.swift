//
//  jobDetailViewController.swift
//  Hackathon
//
//  Created by Kan Chen on 4/14/15.
//  Copyright (c) 2015 NYU-poly. All rights reserved.
//

import UIKit

class jobDetailViewController: UIViewController {

    @IBOutlet weak var companyLogo: UIImageView!
    @IBOutlet weak var companyNameLabel: UILabel!
    @IBOutlet weak var jobTitleLabel: UILabel!
    @IBOutlet weak var jobRoleTagLabel: UILabel!
    @IBOutlet weak var jobTypeLabel: UILabel!
    @IBOutlet weak var locationTagLabel: UILabel!
    @IBOutlet weak var salaryLabel: UILabel!
    @IBOutlet weak var skillTageText: UILabel!
    @IBOutlet weak var jobAndCompanyText: UITextView!
    
    
    //if have time could impletement this to mark as interested
    @IBOutlet weak var markAsInterestedButton: UIButton!
    @IBAction func markAsInterested(sender: UIButton) {
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

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
