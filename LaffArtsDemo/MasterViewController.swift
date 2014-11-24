//
//  MasterViewController.swift
//  LaffArtsDemo
//
//  Created by hollarab on 11/23/14.
//  Copyright (c) 2014 a. brooks hollar. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {

    var artWorks:[WorkOfArt]? = nil

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        DataParser.sharedInstance.fetchData({ (worksOfArt:[WorkOfArt]?) -> () in
            self.artWorks = worksOfArt
            self.tableView!.reloadData()
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Segues

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow() {
                let object = artWorks![indexPath.row]
                (segue.destinationViewController as DetailViewController).detailItem = object
            }
        }
    }

    // MARK: - Table View

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return artWorks == nil ? 0 : artWorks!.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell

        let work = artWorks![indexPath.row]
        cell.textLabel!.text = "\(work.title!) by \(work.artist!)"
        cell.detailTextLabel!.text = work.address!
        
        // we should create thumbnails of the images before we add them in
        // cell.imageView!.image = UIImage(named: work.imageName!)
        
        return cell
    }

    

}

