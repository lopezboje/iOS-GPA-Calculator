//
//  Assessments.swift
//  GPA Calculator
//
//  Created by Joshua Lopez-Boutier.
//

import Foundation

class assessments {
    var points, max, percent : Double
    
    init(points: String, max: String, percent: String) {
        self.points = Double(points)!
        self.max = Double(max)!
        self.percent = Double(percent)!
    }
    
    func checkE() -> Int {
        var result = 0
        if max < points{
            result = 1
        }
        else if max < 0 || points < 0{
            result = 2
        }
        return result
    }
    
    func grade() -> Double {
        let result = points/max * percent
        return result
    }
    
    
}

