//
//  MapViewController.swift
//  LaffArtsDemo
//
//  Created by hollarab on 11/23/14.
//  Copyright (c) 2014 a. brooks hollar. All rights reserved.
//

import UIKit
import MapKit

class CustomPinAnnotation : MKPointAnnotation {
    var workOfArt:WorkOfArt? = nil
    
    func annotationView() -> MKAnnotationView? {
        var view = MKAnnotationView(annotation: self, reuseIdentifier: "CusomAnnotation")
        
        view.enabled = true
        view.canShowCallout = true
        view.rightCalloutAccessoryView = UIButton.buttonWithType(.DetailDisclosure) as UIView
        view.image = UIImage(named: "art_here")
        
        return view
    }
}


class MapViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var artMapView: MKMapView!
    
    var selectedWork:WorkOfArt? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        artMapView.delegate = self
        loadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetailFromMap" {
            (segue.destinationViewController as DetailViewController).detailItem = selectedWork
        }
    }

    
    // MARK: - Data
    func loadData() {
        if let works = DataParser.sharedInstance.artWorks {
            
            let centerLat = Double(39.995000)
            let centerLong = Double(-105.089993)
            
            let point = CLLocationCoordinate2D(latitude: centerLat, longitude:centerLong)
            let region = MKCoordinateRegionMake(point, MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
            artMapView.setRegion(region, animated: true)
            
            for work in works {
                if( work.latitude != nil && work.longitude != nil ){
                    let lat = work.latitude!
                    let long = work.longitude!
                    
                    let coord = CLLocationCoordinate2D(latitude: lat, longitude:long)
                    let aa = CustomPinAnnotation()
                    aa.coordinate = coord
                    aa.title = work.title!
                    aa.subtitle = work.artist!
                    aa.workOfArt = work
                    
                    artMapView.addAnnotation(aa)
                }
            }
            
        }
    }
    
// MARK: - MKMapViewDelegate

    func mapView(mapView: MKMapView!, viewForAnnotation annotation: MKAnnotation!) -> MKAnnotationView! {
        let aa = annotation as CustomPinAnnotation
        return aa.annotationView()
    }
    
    func mapView(mapView: MKMapView!, annotationView view: MKAnnotationView!, calloutAccessoryControlTapped control: UIControl!) {
        self.selectedWork = (view.annotation as CustomPinAnnotation).workOfArt
        self.performSegueWithIdentifier("showDetailFromMap", sender: self)
    }
}
