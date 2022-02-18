//
//  ViewController.swift
//  GPA Calculator
//
//  Created by Joshua Lopez-Boutier.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var assessmentProp: [UITextField]!
    @IBOutlet weak var cHours: UITextField!
    @IBOutlet var courses: [UILabel]!
    @IBOutlet weak var cTitle: UITextField!
    @IBOutlet var cImages: [UIImageView]!
    @IBOutlet weak var gpaLabel: UILabel!
    @IBOutlet weak var Delete: UIButton!
    @IBOutlet weak var deletedCourse: UITextField!
    
    var all = [course]()
    var totalC = 0
    var alertMessage = ""
    
    override func viewDidLoad() {
        for x in assessmentProp{
            x.delegate = self
        }
        cHours.delegate = self
        cTitle.delegate = self
        deletedCourse.delegate = self
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        checkDel()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
    
    func checkDel(){
        if (all.isEmpty){
            Delete.isEnabled = false
        }
        else{
            Delete.isEnabled = true
        }
    }
    
    func assignAssessments() -> [assessments] {
        let assignment = assessments(points: assessmentProp[0].text!,                             max: assessmentProp[1].text!,                                percent: assessmentProp[2].text!)
        let midterm = assessments(points: assessmentProp[3].text!,                             max: assessmentProp[4].text!,                                percent: assessmentProp[5].text!)
        
        let final = assessments(points: assessmentProp[6].text!,                             max: assessmentProp[7].text!,                                percent: assessmentProp[8].text!)
        
        return [assignment, midterm, final]
    }
    
    func gpaCalc() -> Double {
        var gpa = 0.00
        var totCredits = 0.00
        
        for x in all{
            gpa += x.nGrade(lGrade: x.lGrade()) * Double(x.credits)
            totCredits += Double(x.credits)
        }
        
        return gpa/totCredits
    }
    
    func setAlert(mes : String) {
        let alert = UIAlertController(title: "Error", message: mes, preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        
        alert.message = alertMessage
        self.present(alert, animated: true, completion: nil)
    }
   
    func gpaColor() -> UIColor{
        var color = UIColor.white
        switch self.gpaCalc(){
        case 3.0...4.0:
            color = UIColor.green
        case 2.0..<3.0:
            color = UIColor.orange
        case 0.0..<2.0:
            color = UIColor.red
        default:
            break
        }
        return color
    }
    
    func checkErrors(input1 : [assessments], input2 : String) -> Bool{
        var errors = false
        var weightCheck = 0.0

        for x in input1{
            weightCheck += x.percent
            
            switch x.checkE()
            {
            case 1:
                alertMessage = "Points has to be less than max"
                setAlert(mes: alertMessage)
                errors = true
            case 2:
                alertMessage = "No negatives"
                setAlert(mes: alertMessage)
                errors = true
            default:
                break
            }
        }
        
        if (weightCheck != 100.0){
            alertMessage = "Total weight is not 100"
            setAlert(mes: alertMessage)
            errors = true
        }
        else if (totalC > 3)
        {
            alertMessage = "No more than 4 courses"
            setAlert(mes: alertMessage)
            errors = true
        }
        
        for x in all{
            if (input2 == x.name)
            {
                alertMessage = "No repeating titles"
                setAlert(mes: alertMessage)
                errors = true
            }
        }
        
        return errors
    }
    
    func update(direction : Int) {
        for x in totalC ... 3{
            courses[x].text = " "
            cImages[x].image = nil
        }
        if(!all.isEmpty){
            for x in 0 ... (totalC+direction){
                courses[x].text = "\(x+1).) \(all[x].name) | \(all[x].credits)"
                                    
                cImages[x].image = UIImage(named:  "\(all[x].lGrade())")
            }
            let gpaText = String(format: "%.2f", self.gpaCalc())
            gpaLabel.text = "GPA : \(gpaText)"
            gpaLabel.textColor = self.gpaColor()
        }
        else{
            gpaLabel.text = "GPA : "
            gpaLabel.textColor = UIColor.white
        }
        
        checkDel()
    }
    
    @IBAction func Add(_ sender: UIButton) {
        let cWork = self.assignAssessments()
        
        if (!self.checkErrors(input1: cWork, input2: cTitle.text!)) {
            all.append(course(inAssessments: cWork, inCredits: cHours.text!, inName: cTitle.text!))
        
            update(direction: 0)
            totalC += 1
        }
    }
    
    @IBAction func Delete(_ sender: UIButton) {
        let cNum = Int(deletedCourse.text!)!-1
        
        if(cNum>=totalC)
        {
            alertMessage = "Course not in list"
            setAlert(mes: alertMessage)
        }
        else{
            all.remove(at: cNum)
            totalC = totalC-1
            update(direction: -1)
        }
    }
    
}

