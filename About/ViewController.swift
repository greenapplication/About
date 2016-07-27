//
//  ViewController.swift
//  About
//
//  Created by MindLogic Solutions on 07/06/16.
//  Copyright © 2016 com.mls. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet weak var tblView: UITableView!
    
    var strAbout:String=""
    var strLookingFor:String=""
    var strEducation:String=""
    var strFuturePlan:String=""
    var arrayForBool:NSMutableArray=["0","0","0","0"]
    var arrayForSection:NSMutableArray=["EDUCATION","FUTURE PLANS","ABOUT ME","I AM LOOKING FOR"]
    var section1:CGFloat = 0
    var section2:CGFloat = 0
    var section3:CGFloat = 0
    var section4:CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getAbout()
        self.tblView.tableFooterView=UIView()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func getAbout() {
        let manager = AFHTTPRequestOperationManager()
        manager.responseSerializer = AFHTTPResponseSerializer()
        
        
        manager.GET("https://yismach.com/androidapi/about.php?txtEmail=galasor147@gmail.com&txtId=3126",parameters: nil,
                    success: { (operation: AFHTTPRequestOperation!, responseObject: AnyObject!) in
                        
                        var json :AnyObject!
                        
                        json = (try! NSJSONSerialization.JSONObjectWithData(responseObject as! NSData, options: NSJSONReadingOptions.MutableContainers)) as! Dictionary<String, AnyObject>
                        
                        if json["success"] as! Int == 1
                        {
                            
                            if json["uabout"] != nil
                            {
                                self.strAbout = (json["uabout"] as? String)!
                            }
                            
                            if json["ulookingfor"] != nil
                            {
                                self.strLookingFor = (json["ulookingfor"] as? String)!
                            }
                            
                            if json["ufutureplans"] != nil
                            {
                                self.strFuturePlan = (json["ufutureplans"] as? String)!
                            }
                            
                            if json["ueducation"] != nil
                            {
                                self.strEducation = (json["ueducation"] as? String)!
                            }
                            
                        }else if json["success"] as! Int == 0
                        {
                            let alrt:UIAlertView=UIAlertView(title: "Yismach", message: "no data found..", delegate: nil, cancelButtonTitle: "OK")
                            alrt.show()
                        }
                        else
                        {
                            let alrt:UIAlertView=UIAlertView(title: "Yismach", message: "failed to fetch results..", delegate: nil, cancelButtonTitle: "OK")
                            alrt.show()
                        }
            },
                    failure: { (operation: AFHTTPRequestOperation!,error: NSError!) in
                        print("Error: " + error.localizedDescription)
                        
        })
    }
    
    //MARK: tblview methods
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return arrayForSection.count
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(arrayForBool .objectAtIndex(section).boolValue == true)
        {
            return 1
        }
        return 0
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        let collapsed = arrayForBool.objectAtIndex(indexPath.section).boolValue

        
        if indexPath.section == 0{
            if collapsed == false
            {
                return 0
            }
            else
            {
                return section1
            }
        }else if indexPath.section == 1{
            if collapsed == false
            {
                return 0
            }
            else
            {
                return section2
            }
        }else if indexPath.section == 2{
            if collapsed == false
            {
                return 0
            }
            else
            {
                return section3
            }
        }else{
            if collapsed == false
            {
                return 0
            }
            else
            {
                return section4
            }
        }
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tblView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        
        
        
        for view in cell.contentView.subviews // remove subview from cell
        {
            if let lbl = view as? UILabel {
                lbl.removeFromSuperview()
            }
        }
        
        
        var name = UILabel()
        if indexPath.section == 0{
            
            section1 = 10
            
            let lableFont = UIFont(name: "RobotoCondensed-Regular", size: 14)
            let strName = strEducation
            let lableH = heightForProperty("\(strName)", font: lableFont!)
            name  = UILabel(frame: CGRectMake(30, section1, tblView.frame.size.width-60, lableH))
            name.text = strName
            name.font = lableFont
            name.numberOfLines=0
            name.sizeToFit()
            name.lineBreakMode = .ByWordWrapping
            let h = getStringHeight(strName, fontSize: 14, width: tblView.frame.size.width - 60)
            section1 = section1 + h + 5
            
            cell.contentView.addSubview(name)
            
        }else if indexPath.section == 1{
            
            section2 = 10
            
            let lableFont = UIFont(name: "RobotoCondensed-Regular", size: 14)
            let strName = strFuturePlan
            let lableH = heightForProperty("\(strName)", font: lableFont!)
            name  = UILabel(frame: CGRectMake(30, section2, tblView.frame.size.width-60, lableH))
            name.text = strName
            name.font = lableFont
            name.numberOfLines=0
            name.sizeToFit()
            name.lineBreakMode = .ByWordWrapping
            let h = getStringHeight(strName, fontSize: 14, width: tblView.frame.size.width - 60)
            section2 = section2 + h + 5
            
            cell.contentView.addSubview(name)
            
            
        }else if indexPath.section == 2{
            
            section3 = 10
            
            let lableFont = UIFont(name: "RobotoCondensed-Regular", size: 14)
            let strName = strAbout
            let lableH = heightForProperty("\(strName)", font: lableFont!)
            name  = UILabel(frame: CGRectMake(30, section3, tblView.frame.size.width-60, lableH))
            name.text = strName
            name.font = lableFont
            name.numberOfLines=0
            name.sizeToFit()
            name.lineBreakMode = .ByWordWrapping
            let h = getStringHeight(strName, fontSize: 14, width: tblView.frame.size.width - 60)
            section3 = section3 + h + 5
            
            cell.contentView.addSubview(name)
            
            
        }else if indexPath.section == 3{
            
            section4 = 10
            
            let lableFont = UIFont(name: "RobotoCondensed-Regular", size: 14)
            let strName = strLookingFor
            let lableH = heightForProperty("\(strName)", font: lableFont!)
            name  = UILabel(frame: CGRectMake(30, section4, tblView.frame.size.width-60, lableH))
            name.text = strName
            name.font = lableFont
            name.numberOfLines=0
            name.sizeToFit()
            name.lineBreakMode = .ByWordWrapping
            let h = getStringHeight(strName, fontSize: 14, width: tblView.frame.size.width - 60)
            section4 = section4 + h + 5
            
            cell.contentView.addSubview(name)
            
        }
        
        
        return cell
    }
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        //create header view
        let headerView = UIView(frame: CGRectMake(0, 0, tableView.frame.size.width, 40))
        headerView.backgroundColor = UIColor(red:236.0/255.0, green:236.0/255.0 ,blue:236.0/255.0 ,alpha:1.0)
        headerView.tag = section
        
        let headerViewbg = UIView(frame: CGRectMake(0, 5, tableView.frame.size.width, 35))
        headerViewbg.backgroundColor = UIColor.whiteColor()
        headerView.addSubview(headerViewbg)
        
        //create menunames
        let headerString:UILabel = UILabel(frame: CGRect(x: 30, y: 8, width: tableView.frame.size.width-10, height: 30))
        headerString.text = (arrayForSection.objectAtIndex(section) as? String)
        headerString.font = UIFont(name: "RobotoCondensed-Regular", size: 14)
        headerString.textColor=UIColor.blackColor()
        headerView .addSubview(headerString)
        
        
        //set down and up icon
        let collapsed = arrayForBool.objectAtIndex(section).boolValue
        if collapsed == false
        {
            let frame = CGRectMake(tableView.frame.size.width-50, 10, 22, 22)
            let headerImageView = UIImageView(frame: frame)
            let image: UIImage = UIImage(named: "up.png")!
            headerImageView.image = image
            headerView .addSubview(headerImageView)
        }
        else
        {
            let frame = CGRectMake(tableView.frame.size.width-50, 10, 22, 22)
            let headerImageView = UIImageView(frame: frame)
            let image: UIImage = UIImage(named: "down.png")!
            headerImageView.image = image
            headerView .addSubview(headerImageView)
        }
        
        
        //create sepretor line
        let labelLine = UILabel(frame: CGRectMake(30, 39, tableView.frame.size.width-60, 1))
        labelLine.backgroundColor=UIColor(red:197.0/255.0, green:100.0/255.0 ,blue:136.0/255.0 ,alpha:1.0)
        headerView.addSubview(labelLine)
        
        //display subarryas
        let headerTapped = UITapGestureRecognizer (target: self, action:#selector(ViewController.sectionHeaderTapped(_:)))
        headerView .addGestureRecognizer(headerTapped)
        
        return headerView
        
    }
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    func sectionHeaderTapped(recognizer: UITapGestureRecognizer)
    {
        let indexPath : NSIndexPath = NSIndexPath(forRow: 0, inSection:(recognizer.view?.tag as Int!)!)
        
        var collapsed = self.arrayForBool.objectAtIndex(indexPath.section).boolValue
        collapsed = !collapsed;
        
        self.arrayForBool.replaceObjectAtIndex(indexPath.section, withObject: collapsed)
        
        //reload specific section animated
        let range = NSMakeRange(indexPath.section, 1)
        let sectionToReload = NSIndexSet(indexesInRange: range)
        self.tblView.reloadSections(sectionToReload, withRowAnimation:UITableViewRowAnimation.None)
        
    }
    
    func heightForProperty(text:String, font:UIFont) -> CGFloat{
        let label:UILabel = UILabel(frame: CGRectMake(0, 0, CGFloat.max, CGFloat.max))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.ByWordWrapping
        label.font = font
        label.text = text
        label.sizeToFit()
        return label.frame.size.height
        
    }
    
    func getStringHeight(mytext: String, fontSize: CGFloat, width: CGFloat)->CGFloat {
        
        let font1 = UIFont.systemFontOfSize(14)
        let size = CGSizeMake(width,CGFloat.max)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineBreakMode = .ByWordWrapping;
        let attributes = [NSFontAttributeName:font1,
                          NSParagraphStyleAttributeName:paragraphStyle.copy()]
        
        let text = mytext as NSString
        let rect = text.boundingRectWithSize(size, options:.UsesLineFragmentOrigin, attributes: attributes, context:nil)
        return rect.size.height
    }
}

