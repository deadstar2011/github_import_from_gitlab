class LocationPermissionModel {
  bool _isPermissionGranted = false;

  LocationPermissionModel(this._isPermissionGranted);

  bool get isLocationPermissionGranted => _isPermissionGranted;
  set isLocationPermissionGranted(bool value) {
    _isPermissionGranted = value;
  }
}
