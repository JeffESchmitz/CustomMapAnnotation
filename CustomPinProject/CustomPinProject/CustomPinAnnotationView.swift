//
//  CustomPinAnnotationView.swift
//  CustomPinProject
//
//  Created by Jeff Schmitz on 1/7/17.
//  Copyright © 2017 Codefume. All rights reserved.
//

import UIKit
import MapKit

class CustomPinAnnotationView: MKAnnotationView {
  
//  init(annotation: MKAnnotation)
  override init(annotation: MKAnnotation?, reuseIdentifier: String?)
  {
    // The re-use identifier is always nil because these custom pins may be visually different from one another
    super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
    
    // Fetch all necessary data from the point object
    let customPointAnnotation: CustomPointAnnotation = (annotation as? CustomPointAnnotation)!
//    self.price = Int(myCustomPointAnnotation.price)
    
    // Callout settings - if you want a callout bubble
    self.canShowCallout = true
    self.rightCalloutAccessoryView = UIButton(type:UIButtonType.detailDisclosure)
//    if  self.price == 3 {
//    if customPointAnnotation.price == 3 {
//      self.image = UIImage(named:"pinGreen")
//    } else {
      self.image = UIImage(named:"myPinImage")
//    }
    
    let label: UILabel = UILabel(frame:CGRect(origin:CGPoint(x:3, y:2), size:CGSize(width:12, height:12)))
    label.textAlignment = NSTextAlignment.center
    label.textColor = UIColor.black
    //  label.backgroundColor = [UIColor grayColor];
    label.text = String(Int(customPointAnnotation.price))    //customPointAnnotation.price
    label.font = label.font.withSize(9)
    self.addSubview(label)
  }
  
  required public init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
    let hitView = super.hitTest(point, with: event)
    if (hitView != nil) {
      self.superview?.bringSubview(toFront: self)
    }
    return hitView
  }
  
  override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
    let rect = self.bounds;
    var isInside: Bool = rect.contains(point);
    if(!isInside) {
      for view in self.subviews {
        isInside = view.frame.contains(point);
        if isInside {
          break;
        }
      }
    }
    return isInside;
  }
}
