//
//  DetailViewController.swift
//  Hackathon
//
//  Created by Kan Chen on 4/14/15.
//  Copyright (c) 2015 NYU-poly. All rights reserved.
//

import UIKit


class DetailViewController: UIViewController {
    var json: JSON?
       
    @IBOutlet weak var ayncImageView: AsyncImageView!
    
    @IBOutlet weak var textView: UITextView!
    
    @IBOutlet weak var bigButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let a = json!["title"].string!
        
        println("aaaa"+a)
        
        textView.text = ""
        
        
        
        
    }
    
    @IBAction func clickBigButton(sender: AnyObject) {
        
    }
    override func viewWillAppear(animated: Bool) {
        
        textView.text = json!["body"].string!
        
        ayncImageView.placeholderImage = UIImage(named: "unchecked")
        let b = json!["image"].string ?? "no image"
        println("bbbb"+b)
        if b != "no image" {
            ayncImageView.url = NSURL(string:json!["image"].string!)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "detailPic" {
            var vc = segue.destinationViewController as! PictureViewController
            if ayncImageView.url != nil {
                vc.imageURL = ayncImageView.url
            }
        }
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    

}
