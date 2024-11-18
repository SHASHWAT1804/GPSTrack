import CoreLocation

class LocationManager: NSObject, CLLocationManagerDelegate {
    
    static let shared = LocationManager() // Singleton instance
    private let locationManager = CLLocationManager()
    var onLocationUpdate: ((CLLocation) -> Void)?
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.distanceFilter = 10 // Update every 10 meters
        locationManager.pausesLocationUpdatesAutomatically = false
    }
    
    // Request Always Authorization for Background Location Updates
    func requestLocationPermission() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager.requestAlwaysAuthorization()
        } else {
            print("Location services are not enabled.")
        }
    }
    
    func startUpdatingLocation() {
        if locationManager.authorizationStatus == .authorizedAlways {
            locationManager.allowsBackgroundLocationUpdates = true
            locationManager.startUpdatingLocation()
        } else {
            locationManager.requestAlwaysAuthorization()
        }
    }
    
    func stopUpdatingLocation() {
        locationManager.allowsBackgroundLocationUpdates = false
        locationManager.stopUpdatingLocation()
    }
    
    // CLLocationManager Delegate Method
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let latestLocation = locations.last else { return }
        print("Updated Location: \(latestLocation.coordinate.latitude), \(latestLocation.coordinate.longitude)")
        onLocationUpdate?(latestLocation)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to get location: \(error.localizedDescription)")
    }
    
    // Handle authorization changes
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedAlways:
            locationManager.allowsBackgroundLocationUpdates = true
            startUpdatingLocation()
        case .authorizedWhenInUse, .denied, .notDetermined, .restricted:
            locationManager.allowsBackgroundLocationUpdates = false
        @unknown default:
            locationManager.allowsBackgroundLocationUpdates = false
        }

    }
}
