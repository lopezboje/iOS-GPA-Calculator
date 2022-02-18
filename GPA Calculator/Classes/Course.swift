//
//  Course.swift
//  GPA Calculator
//
//  Created by Joshua Lopez-Boutier.
//

import Foundation

class course {
    var cAssessments : [assessments]
    var credits : Int
    var name : String
    
    init(inAssessments: [assessments], inCredits : String, inName : String){
        cAssessments = inAssessments
        credits = Int(inCredits)!
        name = inName
    }
    
    func lGrade() -> String {
        var grade = 0.0
        var result : String
        
        for x in cAssessments{
            grade += x.grade()
        }
        
        switch grade{
        case 0..<60:
            result = "F"
        case 60..<70:
            result = "D"
        case 70..<80:
            result = "C"
        case 80..<90:
            result = "B"
        case 90...100:
            result = "A"
        default:
            result = ""
        }
        
        return result
    }
    
    func nGrade(lGrade: String) -> Double {
        var num = 0.0
        
        switch lGrade{
        case "A":
            num = 4.0
        case "B":
            num = 3.0
        case "C":
            num = 2.0
        case "D":
            num = 1.0
        case "F":
            num = 0.0
        default:
            break
        }
        
        return num
    }
}
