import 'package:flutter/material.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:optima_delivery_mobile/common/helpers/geolocation.dart';
import 'package:optima_delivery_mobile/common/helpers/loading_statuses.dart';
import 'package:optima_delivery_mobile/common/helpers/snack.dart';
import 'package:optima_delivery_mobile/common/models/LocationPermissionModel.dart';
import 'package:optima_delivery_mobile/common/styles/colors.dart';
import 'package:optima_delivery_mobile/common/styles/fonts.dart';
import 'package:optima_delivery_mobile/common/styles/paddings.dart';
import 'package:optima_delivery_mobile/common/widgets/Box.dart';
import 'package:optima_delivery_mobile/common/widgets/Layout.dart';
import 'package:optima_delivery_mobile/common/widgets/LoadingStatusContainer.dart';
import 'package:optima_delivery_mobile/common/widgets/NoAutorizeChecker.dart';
import 'package:optima_delivery_mobile/courier/models/CoordinateModel.dart';
import 'package:optima_delivery_mobile/courier/models/CourierModel.dart';
import 'package:optima_delivery_mobile/delivery/models/DeliveryModel.dart';
import 'package:optima_delivery_mobile/delivery/types/DeliveryTypes.dart';
import 'package:optima_delivery_mobile/delivery/widgets/DeliveryCourierCard.dart';
import 'package:optima_delivery_mobile/delivery/widgets/DeliveryListCard.dart';
import 'package:optima_delivery_mobile/generated/l10n.dart';
import 'package:optima_delivery_mobile/main.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class DeliveryListPage extends StatefulWidget {
  @override
  _DeliveryListPageState createState() => _DeliveryListPageState();
}

class _DeliveryListPageState extends State<DeliveryListPage>
    with WidgetsBindingObserver, RouteAware {
  bool isLocationGranted;
  Geolocation geo;
  DeliveryModel deliveryModel;
  CourierModel courierModel;
  CoordinateModel coordinateModel;
  AppLifecycleState lastState;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    geo = Geolocation();
    deliveryModel = Provider.of<DeliveryModel>(context, listen: false);
    courierModel = Provider.of<CourierModel>(context, listen: false);
    coordinateModel = Provider.of<CoordinateModel>(context, listen: false);
    courierModel.loadProfile();
    deliveryModel.loadList();
    _checkLocationPermission();
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
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed &&
        (lastState != AppLifecycleState.inactive && lastState != null)) {
      courierModel.loadProfile();
      deliveryModel.loadList();
    }
    lastState = state;
  }

  @override
  void didPopNext() {
    super.didPopNext();
    courierModel.loadProfile();
    deliveryModel.loadList();
  }

  void _checkLocationPermission() async {
    isLocationGranted = await geo.checkGeolocationStatusGranted();
  }

  void _getLocationPermission() async {
    final isGranted = await geo.requestGeolocationPermission();

    if (isGranted) {
      coordinateModel.tryInitDependencies();
    }

    setState(() {
      isLocationGranted = isGranted;
    });
  }

  void _setArrivedAtWarehouse() {
    courierModel.setInWarehouse().then((isSuccess) {
      if (isSuccess) {
        deliveryModel.loadList();
      }
    });
  }

  Function() _pushToItem(DeliveryItem item) {
    return () {
      Navigator.pushNamed(
        context,
        '/delivery',
        arguments: item.id,
      );
    };
  }

  Future<void> _handleRefresh() {
    return deliveryModel.loadList();
  }

  void Function() _handleEndOfPage(bool isMore) {
    return () => isMore ? deliveryModel.appendListList(limit: 5) : null;
  }

  @override
  Widget build(BuildContext context) {
    final deliveryModel = Provider.of<DeliveryModel>(context);
    final listItems = deliveryModel.listItems;
    final deliveriesStatus = deliveryModel.deliveriesStatus;
    final deliveriesLoadingStatus = deliveryModel.listLoadingStatus;
    final isMore = deliveryModel.isMore;

    final courierModel = Provider.of<CourierModel>(context);
    final profileLoadingStatus = courierModel.profileLoadingStatus;
    final profile = courierModel.item;
    final warehouseLoadingStatus = courierModel.inWarehouseLoadingStatus;

    final locationPermissionModel =
        Provider.of<LocationPermissionModel>(context);
    if (isLocationGranted != true &&
        locationPermissionModel.isLocationPermissionGranted == true) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          setState(() {
            isLocationGranted = true;
          });
        }
      });
    }

    final cardStatus =
        isLocationGranted == true ? deliveriesStatus : 'noGeolocation';
    final address = profile != null && profile.warehouse != null
        ? profile.warehouse.address
        : null;

    final shouldShowCard =
        deliveriesLoadingStatus == LoadingStatuses.finished &&
            (deliveriesStatus != 'calculated' || isLocationGranted != true);
    final shouldShowList =
        deliveriesLoadingStatus == LoadingStatuses.finished &&
            deliveriesStatus == 'calculated' &&
            isLocationGranted == true;

    return Layout(
      title: S.of(context).routeList,
      body: Builder(
        builder: (layoutContext) => Box(
          children: <Widget>[
            Container(
              color: StyleColors.primary1,
              child: LoadingStatusContainer(
                loadingStatus: mergeLoadingStatusList(
                    [deliveriesLoadingStatus, warehouseLoadingStatus]),
                child: NoAuthorizeChecker(
                  loadingStatus: mergeLoadingStatusList([
                    deliveriesLoadingStatus,
                    warehouseLoadingStatus,
                    profileLoadingStatus
                  ]),
                  child: Column(
                    children: <Widget>[
                      if (shouldShowCard)
                        Expanded(
                          child: Padding(
                            padding: StylePaddings.xs,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                DeliveryCourierCard(
                                  status: cardStatus,
                                  address: address,
                                  onGetLocationPermission:
                                      _getLocationPermission,
                                  onArrivedAtWarehouse: _setArrivedAtWarehouse,
                                ),
                                Material(
                                  color: Colors.transparent,
                                  child: Container(
                                    width: 200,
                                    padding: EdgeInsets.only(
                                      left: StylePaddings.lValue,
                                      bottom: StylePaddings.lValue,
                                    ),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          S.of(context).completeTheShift,
                                          style: StyleFont.styleCaption,
                                          maxLines: 1,
                                        ),
                                        InkWell(
                                          onTap: () async {
                                            final phoneNumber = profile != null
                                                ? profile
                                                    .warehouse.dispatcherPhone
                                                : null;
                                            if (phoneNumber != null &&
                                                await canLaunch(
                                                    'tel:$phoneNumber')) {
                                              await launch('tel:$phoneNumber');
                                            } else {
                                              final snackBar = getErrorSnackBar(
                                                  layoutContext,
                                                  messageKey: 'incorrectPhone');
                                              Scaffold.of(layoutContext)
                                                  .showSnackBar(snackBar);
                                            }
                                          },
                                          child: Text(
                                            S
                                                .of(context)
                                                .completeCallToDispatcher,
                                            maxLines: 1,
                                            style: StyleFont.styleCaption.merge(
                                              TextStyle(
                                                color: StyleColors.primary6,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      if (shouldShowList)
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(
                              top: StylePaddings.xsValue,
                              left: StylePaddings.xsValue,
                              right: StylePaddings.xsValue,
                            ),
                            child: Column(
                              children: <Widget>[
                                Expanded(
                                  child: LazyLoadScrollView(
                                    scrollOffset: 200,
                                    onEndOfPage: _handleEndOfPage(isMore),
                                    child: RefreshIndicator(
                                      onRefresh: _handleRefresh,
                                      child: ListView.builder(
                                        shrinkWrap: true,
                                        physics:
                                            AlwaysScrollableScrollPhysics(),
                                        itemBuilder: (context, position) {
                                          final item = listItems[position];
                                          return Padding(
                                            padding: const EdgeInsets.only(
                                              bottom: StylePaddings.xsValue,
                                            ),
                                            child: DeliveryListCard(
                                              delivery: item,
                                              onTap: _pushToItem(item),
                                            ),
                                          );
                                        },
                                        itemCount: listItems.length,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
