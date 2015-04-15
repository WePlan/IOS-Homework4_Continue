//
//  CellDataStructure.swift
//  Hackathon
//
//  Created by xi su on 4/15/15.
//  Copyright (c) 2015 NYU-poly. All rights reserved.
//

import Foundation

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