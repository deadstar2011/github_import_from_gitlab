import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:optima_delivery_mobile/common/helpers/marker.dart';
import 'package:optima_delivery_mobile/common/styles/colors.dart';
import 'package:optima_delivery_mobile/common/styles/sizes.dart';
import 'package:optima_delivery_mobile/common/types/AddressTypes.dart';
import 'package:optima_delivery_mobile/delivery/types/DeliveryTypes.dart';

class MarkerInfo {
  final Color color;
  final String name;
  final int width;
  final int borderWidth;

  const MarkerInfo(this.name, this.color, this.width, this.borderWidth);
}

const List<MarkerInfo> markerInfoList = [
  MarkerInfo('needCall', StyleColors.red6, StyleSizes.markerWidth,
      StyleSizes.markerBorderWidth),
  MarkerInfo('current', StyleColors.greenMark, StyleSizes.markerWidth,
      StyleSizes.markerBorderWidth),
  MarkerInfo('inProgress', StyleColors.primary6, StyleSizes.markerWidth,
      StyleSizes.markerBorderWidth),
  MarkerInfo('doNotDial', StyleColors.orangeMark, StyleSizes.markerWidth,
      StyleSizes.markerBorderWidth),
  MarkerInfo('default', StyleColors.graphite8, StyleSizes.markerWidth,
      StyleSizes.markerBorderWidth),
];

const defaultAddressCoordinates = AddressCoordinates(lat: 0.0, lon: 0.0);

class DeliveriesGoogleMap extends StatefulWidget {
  final AddressCoordinates warehouseCoordinates;
  final AddressCoordinates initialCoordinates;
  final List<DeliveryItem> deliveryList;
  final double zoom;
  final int activeId;
  final Set<Polyline> polylines;
  final void Function() Function(int) onMarkerTap;

  DeliveriesGoogleMap({
    this.initialCoordinates = defaultAddressCoordinates,
    this.deliveryList = const [],
    @required this.warehouseCoordinates,
    this.zoom = 17,
    this.activeId,
    @required this.onMarkerTap,
    this.polylines = const {},
  });

  @override
  _DeliveriesGoogleMapState createState() => _DeliveriesGoogleMapState();
}

class _DeliveriesGoogleMapState extends State<DeliveriesGoogleMap> {
  GoogleMapController mapController;
  Set<Marker> markers = {};
  Map<String, BitmapDescriptor> iconData = {};
  BitmapDescriptor warehouseIcon;
  bool isWarehouseIconLoaded = false;

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  void initState() {
    super.initState();
    _generateIconData();
  }

  void _generateIconData() async {
    var icons = <String, BitmapDescriptor>{};

    markerInfoList.forEach((iconInfo) async {
      final icon = await getMarkerIcon(
          iconInfo.color, iconInfo.width, iconInfo.borderWidth, false);
      final iconActive = await getMarkerIcon(
          iconInfo.color, iconInfo.width, iconInfo.borderWidth, true);

      icons[iconInfo.name] = icon;
      icons['${iconInfo.name}Active'] = iconActive;
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        setState(() {
          iconData = icons;
        });
      }
    });
  }

  void _setWarehouseIcon(BuildContext context) async {
    if (!isWarehouseIconLoaded) {
      isWarehouseIconLoaded = true;
      final icon = await bitmapDescriptorFromSvgAsset(
        context,
        'assets/icons/warehouse.svg',
        StyleSizes.warehouseIconSize,
        StyleSizes.warehouseIconSize,
      );

      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          setState(() {
            warehouseIcon = icon;
          });
        }
      });
    }
  }

  BitmapDescriptor _getIcon(DeliveryItem delivery) {
    final isActive = delivery.id == widget.activeId;
    var status = delivery.status;

    if (status != 'needCall' &&
        status != 'current' &&
        status != 'inProgress' &&
        status != 'doNotDial') {
      status = 'default';
    }

    final key = isActive ? '${status}Active' : status;

    return iconData[key];
  }

  void _setMarkers() async {
    markers = {};

    if (widget.warehouseCoordinates != null) {
      markers.add(
        Marker(
          markerId: MarkerId('warehouse'),
          position: LatLng(
            widget.warehouseCoordinates.lat,
            widget.warehouseCoordinates.lon,
          ),
          icon: warehouseIcon,
        ),
      );
    }

    markers.addAll(
      widget.deliveryList
          .map(
            (delivery) => Marker(
              markerId: MarkerId(
                delivery.id.toString(),
              ),
              onTap: widget.onMarkerTap(delivery.id),
              position: LatLng(
                delivery.address.coordinates.lat,
                delivery.address.coordinates.lon,
              ),
              icon: _getIcon(delivery),
            ),
          )
          .toSet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    _setWarehouseIcon(context);
    _setMarkers();
    final cameraTarget = widget.initialCoordinates != null
        ? LatLng(
            widget.initialCoordinates.lat,
            widget.initialCoordinates.lon,
          )
        : LatLng(
            defaultAddressCoordinates.lat,
            defaultAddressCoordinates.lon,
          );
    return GoogleMap(
      markers: markers,
      polylines: widget.polylines,
      mapType: MapType.normal,
      myLocationEnabled: true,
      myLocationButtonEnabled: true,
      zoomControlsEnabled: false,
      mapToolbarEnabled: false,
      onMapCreated: _onMapCreated,
      initialCameraPosition: CameraPosition(
        target: cameraTarget,
        zoom: widget.zoom,
      ),
    );
  }
}
