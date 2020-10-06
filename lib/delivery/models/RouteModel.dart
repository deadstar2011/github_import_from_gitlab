import 'dart:async';
import 'package:flutter/material.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:optima_delivery_mobile/common/helpers/HttpSerivce.dart';
import 'package:optima_delivery_mobile/common/helpers/geolocation.dart';
import 'package:optima_delivery_mobile/common/helpers/loading_statuses.dart';
import 'package:optima_delivery_mobile/common/styles/colors.dart';
import 'package:optima_delivery_mobile/common/styles/sizes.dart';
import 'package:optima_delivery_mobile/common/types/AddressTypes.dart';
import 'package:optima_delivery_mobile/delivery/types/DeliveryTypes.dart';

const int defaultTimerDuration = 60;
const timeout = Duration(seconds: defaultTimerDuration);

const defaultPolylineId = '0';

class RouteModel extends ChangeNotifier {
  static final _scheme = GlobalConfiguration().getString('osrmScheme');
  static final _host = GlobalConfiguration().getString('osrmHost');
  static Timer _timer;
  static final Geolocation _geolocation = Geolocation();
  static bool _shouldCalculate = false;
  Set<Polyline> polyLineList = {};
  DeliveryItem targetDelivery;
  LoadingStatuses loadingStatus = LoadingStatuses.untouched;

  RouteModel(this.targetDelivery) {
    tryStartTimer();
  }

  void updateItem(DeliveryItem newTargetDelivery) {
    if (_shouldCalculate &&
        ((targetDelivery == null && newTargetDelivery != null) ||
            (targetDelivery != null &&
                newTargetDelivery != null &&
                targetDelivery.id != newTargetDelivery.id))) {
      targetDelivery = newTargetDelivery;
      loadRoute();
    } else {
      targetDelivery = newTargetDelivery;
    }
  }

  void startCalculate() {
    _shouldCalculate = true;

    polyLineList = {};
    loadingStatus = LoadingStatuses.untouched;
    tryStartTimer();
  }

  void tryStartTimer() {
    if (targetDelivery != null && _shouldCalculate) {
      if (_timer == null) {
        loadRoute();
        _timer = Timer.periodic(timeout, _handleTick);
      }
    } else {
      if (_timer != null) {
        _timer.cancel();
        _timer = null;
      }
    }
  }

  void stopCalculate() {
    if (_timer != null) {
      _timer.cancel();
      _timer = null;
    }

    _shouldCalculate = false;
    polyLineList = {};
    loadingStatus = LoadingStatuses.untouched;
  }

  void _handleTick(Timer timer) {
    loadRoute();
  }

  Future<Map<String, dynamic>> _fetchRoute(String coordinatesPath) {
    return httpService.get('/route/v1/driving/$coordinatesPath',
        scheme: _scheme,
        host: _host,
        params: {
          'overview': false,
          'geometries': 'geojson',
          'steps': true,
        });
  }

  Future<void> loadRoute() async {
    if (targetDelivery == null) {
      return;
    }

    final hasGeolocationPermission =
        await _geolocation.checkGeolocationStatusGranted();

    var currentCoordinates;
    if (hasGeolocationPermission == true) {
      currentCoordinates = await _geolocation.getCurrentPosition();
    }

    if (currentCoordinates == null) {
      return;
    }

    final coordinate = targetDelivery.address.coordinates;
    final transformedCurrentCoordinates = AddressCoordinates(
        lat: currentCoordinates.latitude as double,
        lon: currentCoordinates.longitude as double);

    final coordinatesPath = _transformCoordinatesToPath(
        [transformedCurrentCoordinates, coordinate]);

    loadingStatus = LoadingStatuses.loading;

    final response = await _fetchRoute(coordinatesPath);

    if (response['code'] != 'Ok') {
      polyLineList = {};
      loadingStatus = LoadingStatuses.failed;
    } else {
      final route = response['routes'][0];

      if (route == null) {
        polyLineList = {};
        loadingStatus = LoadingStatuses.failed;
      }

      final legList = route['legs'] as List;
      polyLineList = _transformResponseLeg(legList);
      loadingStatus = LoadingStatuses.finished;
    }

    notifyListeners();
  }

  String _transformCoordinatesToPath(List<AddressCoordinates> list) {
    var coordinatePath = '';

    list.forEach((AddressCoordinates address) {
      coordinatePath += '${address.lon},${address.lat};';
    });

    return coordinatePath.substring(0, coordinatePath.length - 1);
  }

  Set<Polyline> _transformResponseLeg(List legList) {
    final polyLineList = <Polyline>{};
    final latLonList = <LatLng>[];

    legList.forEach((leg) {
      final steps = leg['steps'] as List;

      if (steps is List) {
        steps.forEach((step) {
          final coordinateList = step['geometry']['coordinates'] as List;

          if (coordinateList is List) {
            coordinateList.forEach((dot) {
              latLonList.add(LatLng(dot[1] as double, dot[0] as double));
            });
          }
        });
      }

      polyLineList.add(
        Polyline(
          polylineId: PolylineId(defaultPolylineId),
          width: StyleSizes.mapLineWidth,
          points: latLonList,
          color: StyleColors.greenMark,
        ),
      );
    });

    return polyLineList;
  }
}
