import UIKit
import MapKit
import CoreLocation

class AdminViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    private let mapView = MKMapView()
    private let locationManager = CLLocationManager()
    private var geofenceRegion: CLCircularRegion?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //setupMap()
        setupLocationServices()
        
        // Observe user location updates
        LocationManager.shared.onLocationUpdate = { [weak self] location in
            //self?.updateUserLocationOnMap(location)
        }
        
        // Set up the geofence around specified coordinates
        let geofenceCenter = CLLocationCoordinate2D(latitude: 12.823782, longitude: 80.046156)
        createGeofence(at: geofenceCenter, radius: 100) // Adjust radius as needed
    }

    private func setupMap() {
        mapView.delegate = self
        view.addSubview(mapView)
//        mapView.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            mapView.topAnchor.constraint(equalTo: view.topAnchor),
//            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
//            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
//        ])
        
//        // Center the map on the geofence
//        let geofenceCenter = CLLocationCoordinate2D(latitude: 12.823782, longitude: 80.046156)
//        let region = MKCoordinateRegion(center: geofenceCenter, latitudinalMeters: 500, longitudinalMeters: 500)
//        mapView.setRegion(region, animated: true)
    }

    private func setupLocationServices() {
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        
//        if let region = geofenceRegion {
//            locationManager.startMonitoring(for: region)
//        }
    }

    // Update the map with the user's location
    private func updateUserLocationOnMap(_ location: CLLocation) {
        // Remove any previous user annotation
        mapView.annotations.forEach { if $0 is MKPointAnnotation { mapView.removeAnnotation($0) } }
        
//        // Add new annotation for user's latest location
//        let userAnnotation = MKPointAnnotation()
//        userAnnotation.coordinate = location.coordinate
//        userAnnotation.title = "User Location"
//        mapView.addAnnotation(userAnnotation)
        
        // Optionally, adjust map center to user's location
        mapView.setCenter(location.coordinate, animated: true)
    }

    // Create geofence around specified coordinates
    func createGeofence(at center: CLLocationCoordinate2D, radius: CLLocationDistance) {
        geofenceRegion = CLCircularRegion(center: center, radius: radius, identifier: "Geofence")
        geofenceRegion?.notifyOnEntry = true
        geofenceRegion?.notifyOnExit = true
        locationManager.startMonitoring(for: geofenceRegion!)
        
        // Add geofence annotation on map
     //   let geofenceAnnotation = MKCircle(center: center, radius: radius)
     //   mapView.addOverlay(geofenceAnnotation)
    }
    
    // Add circle overlay to visualize the geofence on the map
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if let circleOverlay = overlay as? MKCircle {
            let circleRenderer = MKCircleRenderer(overlay: circleOverlay)
            circleRenderer.strokeColor = .red
            circleRenderer.fillColor = UIColor.red.withAlphaComponent(0.1)
            circleRenderer.lineWidth = 2
            return circleRenderer
        }
        return MKOverlayRenderer(overlay: overlay)
    }

    // Handle entering the geofence
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        if region.identifier == geofenceRegion?.identifier {
            //print("User entered the geofence.")
        }
    }
    
    // Handle exiting the geofence
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        if region.identifier == geofenceRegion?.identifier {
            //print("User exited the geofence.")
        }
    }
}
