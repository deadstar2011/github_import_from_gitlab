import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:optima_delivery_mobile/common/styles/colors.dart';
import 'package:optima_delivery_mobile/common/styles/fonts.dart';
import 'package:optima_delivery_mobile/generated/l10n.dart';

class Tab {
  String id;
  String iconPath;
  String title;

  Tab({this.id, this.iconPath, this.title});
}

const List<String> tabIdList = ['/delivery-list', '/map', '/profile'];

class BottomNavigation extends StatelessWidget {
  List<Tab> _getTabs(BuildContext context) {
    return [
      Tab(
        id: '/delivery-list',
        iconPath: 'assets/icons/routes.svg',
        title: S.of(context).route,
      ),
      Tab(
        id: '/map',
        iconPath: 'assets/icons/map.svg',
        title: S.of(context).map,
      ),
      Tab(
        id: '/profile',
        iconPath: 'assets/icons/profile.svg',
        title: S.of(context).profile,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final currentRouteName = ModalRoute.of(context).settings.name;
    final tabList = _getTabs(context);

    return BottomNavigationBar(
      backgroundColor: StyleColors.white,
      type: BottomNavigationBarType.fixed,
      items: tabList.map(
        (Tab tab) {
          final color = currentRouteName == tab.id
              ? StyleColors.primary6
              : StyleColors.bottomNavigationItemColor;

          return BottomNavigationBarItem(
            icon: SvgPicture.asset(
              tab.iconPath,
              color: color,
            ),
            title: Text(
              tab.title,
              style: StyleFont.styleCaption.merge(
                TextStyle(color: color),
              ),
            ),
          );
        },
      ).toList(),
      onTap: (int index) {
        final tabId = tabIdList.length > index ? tabIdList[index] : null;

        if (tabId != null && tabId != currentRouteName) {
          Navigator.pushNamedAndRemoveUntil(context, tabId, (route) => false);
        }
      },
    );
  }
}
