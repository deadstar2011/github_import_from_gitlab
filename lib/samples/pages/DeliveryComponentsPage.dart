import 'package:flutter/material.dart';
import 'package:optima_delivery_mobile/common/helpers/geolocation.dart';
import 'package:optima_delivery_mobile/common/types/AddressTypes.dart';
import 'package:optima_delivery_mobile/common/styles/colors.dart';
import 'package:optima_delivery_mobile/common/styles/paddings.dart';
import 'package:optima_delivery_mobile/common/widgets/Box.dart';
import 'package:optima_delivery_mobile/common/widgets/Layout.dart';
import 'package:optima_delivery_mobile/common/widgets/StatusBanner.dart';
import 'package:optima_delivery_mobile/delivery/types/DeliveryTypes.dart';
import 'package:optima_delivery_mobile/delivery/widgets/DeliveryCard.dart';
import 'package:optima_delivery_mobile/delivery/widgets/DeliveryInfo.dart';
import 'package:optima_delivery_mobile/delivery/widgets/DeliveryCourierCard.dart';
import 'package:optima_delivery_mobile/delivery/widgets/DeliveryListCard.dart';
import 'package:optima_delivery_mobile/generated/l10n.dart';

final DeliveryItem delivery = DeliveryItem(
  id: 1,
  number: '#123',
  saleNumber: '1234-1234-1234-1234',
  deliveryTimePlanned: '10:35',
  deliveryTimeFrom: '10:00',
  deliveryTimeTo: '10:30',
  description: 'За гаражами',
  isDeliveryPaid: true,
  isOrderPaid: true,
  paymentMethod: 'Наличные',
  deliveryCost: 123.123,
  orderCost: 1231.123,
  comment: 'За гаражами',
  clientId: 1,
  status: 'needCall',
  buyer: DeliveryBuyer(
    name: 'Иван Иванов',
    phone: '7912341231',
  ),
  address: Address(
    title: 'г. Томск, ул. Ленина, д. 1, кв. 1',
    coordinates: AddressCoordinates(
      lon: 11.453,
      lat: 54.231,
    ),
  ),
);

final DeliveryItem delivery1 = DeliveryItem(
  id: 1,
  number: '#123',
  saleNumber: '1234-1234-1234-1234',
  deliveryTimePlanned: '10:35',
  deliveryTimeFrom: '10:00',
  deliveryTimeTo: '10:30',
  description: 'За гаражами',
  isDeliveryPaid: true,
  isOrderPaid: true,
  paymentMethod: 'Наличные',
  deliveryCost: 123.123,
  orderCost: 1231.123,
  comment: 'За гаражами',
  clientId: 1,
  status: 'inProgress',
  buyer: DeliveryBuyer(
    name: 'Иван Иванов',
    phone: '7912341231',
  ),
  address: Address(
    title: 'г. Томск, ул. Ленина, д. 1, кв. 1',
    coordinates: AddressCoordinates(
      lon: 11.453,
      lat: 54.231,
    ),
  ),
);

final DeliveryItem delivery2 = DeliveryItem(
  id: 1,
  number: '#123',
  saleNumber: '1234-1234-1234-1234',
  deliveryTimePlanned: '10:35',
  deliveryTimeFrom: '10:00',
  deliveryTimeTo: '10:30',
  description: 'За гаражами',
  isDeliveryPaid: true,
  isOrderPaid: true,
  paymentMethod: 'Наличные',
  deliveryCost: 123.123,
  orderCost: 1231.123,
  comment: 'За гаражами',
  clientId: 1,
  status: 'current',
  buyer: DeliveryBuyer(
    name: 'Иван Иванов',
    phone: '7912341231',
  ),
  address: Address(
    title: 'г. Томск, ул. Ленина, д. 1, кв. 1',
    coordinates: AddressCoordinates(
      lon: 11.453,
      lat: 54.231,
    ),
  ),
);

final DeliveryItem delivery3 = DeliveryItem(
  id: 1,
  number: '#123',
  saleNumber: '1234-1234-1234-1234',
  deliveryTimePlanned: '10:35',
  deliveryTimeFrom: '10:00',
  deliveryTimeTo: '10:30',
  description: 'За гаражами',
  isDeliveryPaid: true,
  isOrderPaid: true,
  paymentMethod: 'Наличные',
  deliveryCost: 123.123,
  orderCost: 1231.123,
  comment: 'За гаражами',
  clientId: 1,
  status: 'refused',
  buyer: DeliveryBuyer(
    name: 'Иван Иванов',
    phone: '7912341231',
  ),
  address: Address(
    title: 'г. Томск, ул. Ленина, д. 1, кв. 1',
    coordinates: AddressCoordinates(
      lon: 11.453,
      lat: 54.231,
    ),
  ),
);

final DeliveryClient client = DeliveryClient(name: 'KDV', id: 1);

void stub() {}

class DeliveryComponentsPage extends StatefulWidget {
  @override
  _DeliveryComponentsPageState createState() => _DeliveryComponentsPageState();
}

class _DeliveryComponentsPageState extends State<DeliveryComponentsPage> {
  bool isStatusBannerVisible;
  bool isLocationGranted;
  Geolocation geo;

  @override
  void initState() {
    super.initState();
    isStatusBannerVisible = true;
    isLocationGranted = false;
    geo = Geolocation();
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
      isAppNavigatorVisible: false,
      title: S.of(context).samplesDelivery,
      body: SingleChildScrollView(
        child: Box(children: <Widget>[
          Column(
            children: <Widget>[
              StatusBanner(
                isVisible: isStatusBannerVisible,
                message: 'Заказ был отменен диспетчером',
                type: 'notify',
                onPressed: () {
                  setState(() {
                    isStatusBannerVisible = false;
                  });
                },
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: StylePaddings.xsValue,
                ),
                child: DeliveryCard(
                  delivery: delivery,
                  onClientReady: stub,
                  onDelivered: stub,
                  onHaveProblems: stub,
                  onNotDial: stub,
                  onStartMoving: stub,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: StylePaddings.xsValue,
                ),
                child: DeliveryCard(
                  delivery: delivery1,
                  onClientReady: stub,
                  onDelivered: stub,
                  onHaveProblems: stub,
                  onNotDial: stub,
                  onStartMoving: stub,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: StylePaddings.xsValue,
                ),
                child: DeliveryCard(
                  delivery: delivery2,
                  onClientReady: stub,
                  onDelivered: stub,
                  onHaveProblems: stub,
                  onNotDial: stub,
                  onStartMoving: stub,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: StylePaddings.xsValue,
                ),
                child: DeliveryInfo(
                  delivery: delivery3,
                  client: client,
                ),
              ),
              Container(
                padding: StylePaddings.xs,
                color: StyleColors.primary1,
                child: DeliveryCourierCard(
                  status: 'notOnShift',
                  address: delivery.address,
                ),
              ),
              Container(
                padding: StylePaddings.xs,
                color: StyleColors.primary1,
                child: DeliveryCourierCard(
                  status: 'calculation',
                  address: delivery.address,
                ),
              ),
              Container(
                padding: StylePaddings.xs,
                color: StyleColors.primary1,
                child: DeliveryCourierCard(
                  status: 'emptyWarehouse',
                  address: delivery.address,
                ),
              ),
              Container(
                padding: StylePaddings.xs,
                color: StyleColors.primary1,
                child: DeliveryCourierCard(
                  status: 'finished',
                  address: delivery.address,
                ),
              ),
              Container(
                padding: StylePaddings.xs,
                color: StyleColors.primary1,
                child: DeliveryCourierCard(
                  status: 'noGeolocation',
                  onGetLocationPermission: () async {
                    final isGranted = await geo.requestGeolocationPermission();
                    setState(() {
                      isLocationGranted = isGranted;
                    });
                  },
                  address: delivery.address,
                ),
              ),
              Container(
                padding: StylePaddings.xs,
                color: StyleColors.primary1,
                child: DeliveryListCard(
                  delivery: delivery,
                ),
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
