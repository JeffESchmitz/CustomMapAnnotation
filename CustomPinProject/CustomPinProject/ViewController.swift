//
//  ViewController.swift
//  CustomPinProject
//
//  Created by Jeff Schmitz on 1/7/17.
//  Copyright © 2017 Codefume. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate {
  
  @IBOutlet weak var mapView: MKMapView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    self.mapView.delegate = self
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    // Center the map on Boston
    let BostonCoordinates: CLLocationCoordinate2D = CLLocationCoordinate2DMake(42.3601, -71.0589)
    let viewRegion: MKCoordinateRegion = MKCoordinateRegionMakeWithDistance(BostonCoordinates, 500, 500)
    let adjustedRegion: MKCoordinateRegion = self.mapView!.regionThatFits(viewRegion)
    self.mapView?.setRegion(adjustedRegion, animated:true)
    
    let point1: CustomPointAnnotation = CustomPointAnnotation()
    point1.coordinate = CLLocationCoordinate2DMake(42.3601, -71.0589)
    point1.price = 3
    self.mapView?.addAnnotation(point1)
    
    let point2: CustomPointAnnotation = CustomPointAnnotation()
    point2.coordinate = CLLocationCoordinate2DMake(42.3606, -71.0583)
    point2.price = 5
    self.mapView?.addAnnotation(point2)

  }
  
  
  // MARK: - MKMapViewDelegate
  func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
    // Don't do anything if it's the users location
    if annotation is MKUserLocation {
      return nil
    }

    var annotationView = self.mapView.dequeueReusableAnnotationView(withIdentifier: "Pin")
    
    if annotationView == nil {
      if annotation is CustomPointAnnotation {
//        annotationView = CustomPinAnnotationView(annotation: annotation)
        annotationView = CustomPinAnnotationView(annotation: annotation, reuseIdentifier: "Pin")
        annotationView?.canShowCallout = false
      } else {
        annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "Pin")
      }
    } else {
      annotationView?.annotation = annotation
    }
    
    return annotationView
  }
  
  func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
    if view.isKind(of: CustomPinAnnotationView.self) {
      for subView in view.subviews {
        subView.removeFromSuperview()
      }
    }
  }
  
  func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
    print("Selected annotation: \(view.description)")
  }
}

