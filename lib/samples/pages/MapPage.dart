import 'package:flutter/material.dart';
import 'package:optima_delivery_mobile/common/styles/paddings.dart';
import 'package:optima_delivery_mobile/common/types/AddressTypes.dart';
import 'package:optima_delivery_mobile/common/widgets/DeliveriesGoogleMap.dart';
import 'package:optima_delivery_mobile/common/widgets/Layout.dart';
import 'package:optima_delivery_mobile/delivery/types/DeliveryTypes.dart';
import 'package:optima_delivery_mobile/delivery/widgets/DeliveryListCard.dart';
import 'package:optima_delivery_mobile/generated/l10n.dart';

final List<DeliveryItem> deliveryList = [
  DeliveryItem(
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
        lat: 56.452111,
        lon: 84.977956,
      ),
    ),
  ),
  DeliveryItem(
    id: 2,
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
        lat: 56.459336,
        lon: 84.971956,
      ),
    ),
  )
];

final Map<int, DeliveryItem> deliveryData = {
  for (var e in deliveryList) e.id: e
};

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  int activeId;

  @override
  Widget build(BuildContext context) {
    return Layout(
      isAppNavigatorVisible: false,
      title: S.of(context).samplesMap,
      body: Container(
        height: 600,
        child: Stack(
          children: [
            DeliveriesGoogleMap(
              warehouseCoordinates: AddressCoordinates(
                lat: 56.453366,
                lon: 84.971576,
              ),
              deliveryList: deliveryList,
              activeId: activeId,
              onMarkerTap: (int id) {
                return () {
                  setState(() {
                    activeId = id;
                  });
                };
              },
            ),
            if (activeId != null && deliveryData[activeId] != null)
              Padding(
                padding: const EdgeInsets.only(
                  top: StylePaddings.xsValue,
                  left: StylePaddings.xsValue,
                  right: StylePaddings.xsValue,
                ),
                child: DeliveryListCard(
                  delivery: deliveryData[activeId],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
