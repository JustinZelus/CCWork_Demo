
import Foundation
import UIKit
import GoogleMaps

class GoogleMapViewController: UIViewController,CLLocationManagerDelegate {
    let apiKey = "Your API KEY"
    fileprivate let locationManager: CLLocationManager = {
        let lm = CLLocationManager()
        return lm
    }()
    
    fileprivate let mapView: GMSMapView = {
        let map = GMSMapView()
        map.isMyLocationEnabled = true
//        let mapInsets = UIEdgeInsets(top: 80.0, left: 0.0, bottom: 45.0, right: 0.0)
//        map.padding = mapInsets
        map.settings.compassButton = true
        map.settings.myLocationButton = true
        return map
    }()
    
    fileprivate let titleLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.text = "當前位置"
        return label
    }()
    
    fileprivate let coordinateLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        return label
    }()
    
    fileprivate var bg: UIView = {
       let v = UIView()
        v.backgroundColor = .black
      v.translatesAutoresizingMaskIntoConstraints = false
       return v
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
 
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        
        view.addSubview(titleLabel)
        titleLabel.topAnchor.constraint(equalTo: view.safeTopAnchor, constant: 16).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 24).isActive = true
        titleLabel.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 4).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 24).isActive = true

        view.addSubview(coordinateLabel)
        coordinateLabel.topAnchor.constraint(equalTo: titleLabel.topAnchor, constant: 2).isActive = true
        coordinateLabel.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor,constant: 0).isActive = true
        coordinateLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -24).isActive = true
        coordinateLabel.heightAnchor.constraint(equalToConstant: 24).isActive = true
      
       // view = mapView
        view.addSubview(bg)
        bg.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 24).isActive = true
        bg.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 0).isActive = true
        bg.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: 0).isActive = true
        bg.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        DispatchQueue.main.async(execute: {
    
            UIView.animate(withDuration: 0.4, animations: {
              //  self.bg = self.mapView
                self.mapView.frame = CGRect(x: 0, y: 0, width: self.bg.frame.width, height: self.bg.frame.height)
                self.bg.layoutIfNeeded()
             //   self.mapView.layoutIfNeeded()
            })
        })

        self.bg.addSubview(mapView)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let coordinate: CLLocationCoordinate2D = manager.location?.coordinate else {return }
        print("locations = \(coordinate.latitude) \(coordinate.longitude)")
        DispatchQueue.main.async {
            self.coordinateLabel.text = String(format: "%.6f", coordinate.latitude) + " , " +  String(format: "%.6f", coordinate.longitude)
        }
        mapView.camera = GMSCameraPosition(target: coordinate, zoom: 18, bearing: 0, viewingAngle: 0)
        
    }
}
