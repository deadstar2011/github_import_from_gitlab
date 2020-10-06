import 'package:flutter/material.dart';
import 'package:optima_delivery_mobile/common/types/AddressTypes.dart';
import 'package:optima_delivery_mobile/common/styles/paddings.dart';
import 'package:optima_delivery_mobile/common/widgets/Box.dart';
import 'package:optima_delivery_mobile/common/widgets/Layout.dart';
import 'package:optima_delivery_mobile/courier/widgets/CourierProfileInfo.dart';
import 'package:optima_delivery_mobile/courier/types/CourierTypes.dart';
import 'package:optima_delivery_mobile/courier/widgets/CourierProfileCard.dart';
import 'package:optima_delivery_mobile/generated/l10n.dart';

final Courier courier = Courier(
  id: 1,
  firstName: 'Иван',
  middleName: 'Иванович',
  lastName: 'Иванов',
  isInWarehouse: false,
  isOnShift: true,
  warehouseId: 1,
  vehicle: CourierVehicle(
    name: 'Lada Largus',
    id: 1,
    number: 'АБ123В',
  ),
  warehouse: CourierWarehouse(
    name: 'Самый большой склад',
    id: 1,
    dispatcherPhone: '79235671212',
    address: Address(
      title: 'г. Томск ул. Пушкина дом Колотушкина',
      coordinates: AddressCoordinates(
        lat: 1.23,
        lon: 1.23,
      ),
    ),
  ),
);

class ProfileComponentsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Layout(
      isAppNavigatorVisible: false,
      title: S.of(context).samplesProfile,
      body: Box(children: <Widget>[
        Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: StylePaddings.sValue,
              ),
              child: CourierProfileCard(
                firstName: courier.firstName,
                middleName: courier.middleName,
                lastName: courier.lastName,
              ),
            ),
            CourierProfileInfo(
              courier: courier,
            ),
          ],
        ),
      ]),
    );
  }
}
