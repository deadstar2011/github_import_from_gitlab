import 'package:flutter/material.dart';
import 'package:optima_delivery_mobile/common/models/PushNotificationModel.dart';
import 'package:optima_delivery_mobile/common/styles/colors.dart';
import 'package:optima_delivery_mobile/common/styles/paddings.dart';
import 'package:optima_delivery_mobile/common/widgets/ActionInfoItem.dart';
import 'package:optima_delivery_mobile/common/widgets/Box.dart';
import 'package:optima_delivery_mobile/common/widgets/Layout.dart';
import 'package:optima_delivery_mobile/common/widgets/LoadingStatusContainer.dart';
import 'package:optima_delivery_mobile/common/widgets/Modal.dart';
import 'package:optima_delivery_mobile/common/widgets/NoAutorizeChecker.dart';
import 'package:optima_delivery_mobile/common/widgets/VersionInfoItem.dart';
import 'package:optima_delivery_mobile/courier/models/CourierModel.dart';
import 'package:optima_delivery_mobile/courier/widgets/CourierExitModalContent.dart';
import 'package:optima_delivery_mobile/courier/widgets/CourierProfileCard.dart';
import 'package:optima_delivery_mobile/courier/widgets/CourierProfileInfo.dart';
import 'package:optima_delivery_mobile/delivery/models/DeliveryModel.dart';
import 'package:optima_delivery_mobile/generated/l10n.dart';
import 'package:provider/provider.dart';

class FullName {
  String firstName;
  String middleName;
  String lastName;

  FullName(this.firstName, this.lastName, this.middleName);
}

final emptyFullName = FullName(null, null, null);

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> with WidgetsBindingObserver {
  CourierModel courierModel;
  PushNotificationsModel pushModel;
  DeliveryModel deliveryModel;
  AppLifecycleState lastState;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    courierModel = Provider.of<CourierModel>(context, listen: false);
    pushModel = Provider.of<PushNotificationsModel>(context, listen: false);
    deliveryModel = Provider.of<DeliveryModel>(context, listen: false);
    courierModel.loadProfile();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed &&
        (lastState != AppLifecycleState.inactive && lastState != null)) {
      courierModel.loadProfile();
    }
    lastState = state;
  }

  @override
  Widget build(BuildContext context) {
    courierModel = Provider.of<CourierModel>(context);
    final courier = courierModel.item;
    final loadingStatus = courierModel.profileLoadingStatus;

    final fullNameData = courier != null
        ? FullName(courier.firstName, courier.middleName, courier.lastName)
        : emptyFullName;

    final dispatcherPhone =
        courier != null ? courier.warehouse.dispatcherPhone : null;

    return Layout(
      title: S.of(context).profile,
      body: Box(
        children: <Widget>[
          Material(
            color: StyleColors.primary1,
            child: LoadingStatusContainer(
              loadingStatus: loadingStatus,
              child: NoAuthorizeChecker(
                loadingStatus: loadingStatus,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: StylePaddings.xs,
                      child: CourierProfileCard(
                        firstName: fullNameData.firstName,
                        middleName: fullNameData.middleName,
                        lastName: fullNameData.lastName,
                      ),
                    ),
                    CourierProfileInfo(
                      courier: courier,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: StylePaddings.xxsValue,
                      ),
                      child: VersionInfoItem(),
                    ),
                    ActionInfoItem(
                      svgPath: 'assets/icons/logout.svg',
                      value: S.of(context).endShift,
                      onPressed: () async {
                        await showSpecialDialog(
                          mainAxisAlignment: MainAxisAlignment.start,
                          context: context,
                          children: [
                            CourierExitModalContent(
                              onYesTab: () {
                                pushModel.deleteToken().then((_) {
                                  courierModel.logout().then((_) {
                                    Navigator.pushNamedAndRemoveUntil(
                                        context, '/', (route) => false);
                                  });
                                  deliveryModel.clear();
                                });
                              },
                              dispatcherPhone: dispatcherPhone,
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
