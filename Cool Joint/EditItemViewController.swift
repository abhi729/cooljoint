//
//  EditItemViewController.swift
//  Cool Joint
//
//  Created by Zoojoobe on 01/04/16.
//  Copyright © 2016 Abhishek Agarwal. All rights reserved.
//

import UIKit

class EditItemViewController: UIViewController, UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource {
    
    var categorySelected: Int!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var pageControl: UIPageControl!
    @IBOutlet var scrollView: UIScrollView!
    
    var menuArray = ["Starters", "Main Course", "Rotis and Parathas", "Rice and Noodles", "Beverages"]
    var menuImageArray = ["starters.jpeg", "main_course.jpeg", "parathas.jpeg", "rice.jpg", "beers.jpg"]
    
    @IBAction func backButtonPressed(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.allowsMultipleSelection = false
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        tableView.reloadData()
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        let pageNumber = round(scrollView.contentOffset.x / scrollView.frame.size.width)
        pageControl.currentPage = Int(pageNumber)
    }
   
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuImageArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! MenuTableCell
        cell.menuImage!.image = UIImage(named: menuImageArray[indexPath.row])
        cell.nameOfItem.text = menuArray[indexPath.row]
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        categorySelected = indexPath.row
        performSegueWithIdentifier("SegueToMenuDetails", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "SegueToMenuDetails" {
            let x = segue.destinationViewController as! ItemListViewController
            x.categorySelected = categorySelected
        }
    }
}
