import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:optima_delivery_mobile/common/helpers/snack.dart';
import 'package:optima_delivery_mobile/common/styles/colors.dart';
import 'package:optima_delivery_mobile/common/styles/fonts.dart';
import 'package:optima_delivery_mobile/common/widgets/ActionInfoItem.dart';
import 'package:optima_delivery_mobile/generated/l10n.dart';
import 'package:package_info/package_info.dart';

class VersionInfoItem extends StatefulWidget {
  @override
  _VersionInfoItemState createState() => _VersionInfoItemState();
}

class _VersionInfoItemState extends State<VersionInfoItem> {
  PackageInfo _packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
  );
  AppUpdateInfo updateInfo;
  BuildContext ctx;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initPackageInfo();

      if (Platform.isAndroid) {
        _checkForUpdate();
      }
    });
  }

  Future<void> _checkForUpdate() async {
    await InAppUpdate.checkForUpdate().then((info) {
      setState(() {
        updateInfo = info;
      });
    }).catchError((_) {});
  }

  Future<void> _initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();

    setState(() {
      _packageInfo = info;
    });
  }

  Map _getItemProps() {
    if (Platform.isAndroid && updateInfo?.updateAvailable == true) {
      return {
        'action': () {
          InAppUpdate.checkForUpdate().then((info) {
            if (info?.updateAvailable == true) {
              InAppUpdate.performImmediateUpdate().catchError((_) {
                final snackBar =
                    getErrorSnackBar(context, messageKey: 'updateTryError');
                Scaffold.of(context).showSnackBar(snackBar);
              });
            }
          }).catchError((_) {});
        },
        'comment': S.of(context).updateReady,
      };
    }

    return {'action': null, 'comment': null};
  }

  @override
  Widget build(BuildContext context) {
    ctx = context;
    final itemProps = _getItemProps();

    return ActionInfoItem(
      onPressed: itemProps['action'] as void Function(),
      svgPath: 'assets/icons/settings.svg',
      value: S.of(context).version(_packageInfo.version),
      comment: itemProps['comment'] as String,
      commentStyle: StyleFont.styleOverLine.merge(
        TextStyle(color: StyleColors.green6),
      ),
    );
  }
}
