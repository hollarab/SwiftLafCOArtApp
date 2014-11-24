//
//  DetailViewController.swift
//  LaffArtsDemo
//
//  Created by hollarab on 11/23/14.
//  Copyright (c) 2014 a. brooks hollar. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var bottomLabel: UILabel!
    @IBOutlet weak var artImageView: UIImageView!


    var detailItem: WorkOfArt? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }

    func configureView() {
        // Update the user interface for the detail item.
        if let detail: AnyObject = self.detailItem {
            if let label = self.topLabel {
                label.text = detailItem!.title
            }
            
            if let imageView = artImageView {
                imageView.image = UIImage(named: detailItem!.imageName!)
            }
            
            if let label = bottomLabel {
                label.text = "by \(detailItem!.artist!)"
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.configureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

