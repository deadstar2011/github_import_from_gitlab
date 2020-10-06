import 'package:flutter/material.dart';
import 'package:optima_delivery_mobile/common/helpers/geolocation.dart';
import 'package:optima_delivery_mobile/common/helpers/loading_statuses.dart';
import 'package:optima_delivery_mobile/common/models/LocationPermissionModel.dart';
import 'package:optima_delivery_mobile/common/styles/colors.dart';
import 'package:optima_delivery_mobile/common/styles/paddings.dart';
import 'package:optima_delivery_mobile/common/types/AddressTypes.dart';
import 'package:optima_delivery_mobile/common/widgets/Box.dart';
import 'package:optima_delivery_mobile/common/widgets/DeliveriesGoogleMap.dart';
import 'package:optima_delivery_mobile/common/widgets/Layout.dart';
import 'package:optima_delivery_mobile/common/widgets/NoAutorizeChecker.dart';
import 'package:optima_delivery_mobile/courier/models/CoordinateModel.dart';
import 'package:optima_delivery_mobile/courier/models/CourierModel.dart';
import 'package:optima_delivery_mobile/courier/types/CourierTypes.dart';
import 'package:optima_delivery_mobile/delivery/models/DeliveryModel.dart';
import 'package:optima_delivery_mobile/delivery/models/RouteModel.dart';
import 'package:optima_delivery_mobile/delivery/widgets/DeliveryCourierCard.dart';
import 'package:optima_delivery_mobile/delivery/widgets/DeliveryListCard.dart';
import 'package:optima_delivery_mobile/generated/l10n.dart';
import 'package:optima_delivery_mobile/main.dart';
import 'package:provider/provider.dart';

class DeliveryMapPage extends StatefulWidget {
  final AddressCoordinates initialCoordinates;

  DeliveryMapPage(this.initialCoordinates);

  @override
  _DeliveryMapPageState createState() => _DeliveryMapPageState();
}

class _DeliveryMapPageState extends State<DeliveryMapPage>
    with WidgetsBindingObserver, RouteAware {
  int activeId;
  DeliveryModel deliveryModel;
  CourierModel courierModel;
  RouteModel routeModel;
  CoordinateModel coordinateModel;
  Geolocation geo;
  AppLifecycleState lastState;
  bool isLocationGranted;
  bool isLocationEnabled;
  AddressCoordinates initialCoordinates;
  LoadingStatuses coordinateLoadingStatus = LoadingStatuses.untouched;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    geo = Geolocation();

    deliveryModel = Provider.of<DeliveryModel>(context, listen: false);
    courierModel = Provider.of<CourierModel>(context, listen: false);
    coordinateModel = Provider.of<CoordinateModel>(context, listen: false);
    routeModel = Provider.of<RouteModel>(context, listen: false);
    deliveryModel.loadList();
    courierModel.loadProfile();
    _checkLocationWork();
  }

  void _checkLocationWork() async {
    isLocationGranted = await geo.checkGeolocationStatusGranted();
    isLocationEnabled = await geo.checkGeolocationEnabled();
    _setInitialCoordinates();
    _startLoadingRoute();
  }

  void _setInitialCoordinates() async {
    if (widget.initialCoordinates == null &&
        isLocationGranted == true &&
        isLocationEnabled == true) {
      setState(() {
        coordinateLoadingStatus = LoadingStatuses.loading;
      });

      final coordinates = await geo.getCurrentPosition();
      if (coordinates != null) {
        initialCoordinates = AddressCoordinates(
            lat: coordinates.latitude, lon: coordinates.longitude);
      }
    } else {
      initialCoordinates = widget.initialCoordinates;
    }
    setState(() {
      coordinateLoadingStatus = LoadingStatuses.finished;
    });
  }

  void _startLoadingRoute() {
    if (isLocationGranted == true && isLocationEnabled == true) {
      routeModel.startCalculate();
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context));
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didPopNext() {
    super.didPopNext();
    courierModel.loadProfile();
    deliveryModel.loadList();
    _startLoadingRoute();
  }

  @override
  void didPushNext() {
    super.didPush();
    routeModel.stopCalculate();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed &&
        (lastState != AppLifecycleState.inactive && lastState != null)) {
      deliveryModel.loadList();
      courierModel.loadProfile();
    }
    lastState = state;
  }

  AddressCoordinates _getWarehouseCoordinates(Courier courier) {
    return courier != null &&
            courier.warehouse != null &&
            courier.warehouse.address != null
        ? courier.warehouse.address.coordinates
        : null;
  }

  void Function() _handleMarkerClick(int id) {
    return () {
      setState(() {
        activeId = id;
      });
    };
  }

  void _getLocationPermission() async {
    final isGranted = await geo.requestGeolocationPermission();
    final isEnabled = await geo.checkGeolocationEnabled();

    if (isGranted) {
      coordinateModel.tryInitDependencies();
    }

    setState(() {
      isLocationGranted = isGranted;
      isLocationEnabled = isEnabled;
    });

    _setInitialCoordinates();
    _startLoadingRoute();
  }

  void _getLocationEnabled() async {
    final isEnabled = await geo.checkGeolocationEnabled();

    setState(() {
      isLocationEnabled = isEnabled;
    });

    _setInitialCoordinates();
    _startLoadingRoute();
  }

  String _getCardStatus() {
    if (isLocationGranted == null || isLocationEnabled == null) {
      return null;
    }

    if (isLocationGranted != true) {
      return 'noGeolocation';
    }

    if (isLocationEnabled != true) {
      return 'disabledGeolocation';
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    final deliveryModel = Provider.of<DeliveryModel>(context);
    final routeModel = Provider.of<RouteModel>(context);
    final deliveryList = deliveryModel.listItems;
    final deliveryLoadingStatus = deliveryModel.listLoadingStatus;
    final deliveryData = deliveryModel.data;

    final courier = context.select((CourierModel m) => m.item);
    final courierLoadingStatus =
        context.select((CourierModel m) => m.profileLoadingStatus);

    final polylines = routeModel.polyLineList;

    final locationPermissionModel =
        Provider.of<LocationPermissionModel>(context);

    if (isLocationGranted != true &&
        locationPermissionModel.isLocationPermissionGranted == true) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          setState(() {
            isLocationGranted = true;
          });
          _setInitialCoordinates();
          _startLoadingRoute();
        }
      });
    }

    final isMapVisible = isLocationEnabled == true &&
        isLocationGranted == true &&
        coordinateLoadingStatus == LoadingStatuses.finished;
    final isCardVisible =
        isLocationEnabled == false || isLocationGranted == false;
    final cardStatus = _getCardStatus();
    final authorizeCheckerStatus =
        mergeLoadingStatusList([courierLoadingStatus, deliveryLoadingStatus]);

    return Layout(
      title: S.of(context).map,
      body: NoAuthorizeChecker(
        loadingStatus: authorizeCheckerStatus,
        child: Box(
          children: <Widget>[
            if (isCardVisible)
              Container(
                height: double.infinity,
                color: StyleColors.primary1,
                padding: StylePaddings.xs,
                child: Wrap(children: [
                  DeliveryCourierCard(
                    status: cardStatus,
                    onGetLocationPermission: _getLocationPermission,
                    onEnableGeolocation: _getLocationEnabled,
                  ),
                ]),
              ),
            if (isMapVisible)
              Stack(
                children: [
                  DeliveriesGoogleMap(
                    initialCoordinates: initialCoordinates,
                    warehouseCoordinates: _getWarehouseCoordinates(courier),
                    deliveryList: deliveryList,
                    polylines: polylines,
                    activeId: activeId,
                    onMarkerTap: _handleMarkerClick,
                  ),
                  if (activeId != null && deliveryData[activeId] != null)
                    Container(
                      alignment: Alignment.bottomCenter,
                      padding: const EdgeInsets.only(
                        bottom: StylePaddings.xsValue,
                        left: StylePaddings.xsValue,
                        right: StylePaddings.xsValue,
                      ),
                      child: Dismissible(
                        key: Key('mapCard'),
                        onDismissed: (_) {
                          setState(() {
                            activeId = null;
                          });
                        },
                        child: DeliveryListCard(
                          delivery: deliveryData[activeId],
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              '/delivery',
                              arguments: deliveryData[activeId].id,
                            );
                          },
                        ),
                      ),
                    ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
