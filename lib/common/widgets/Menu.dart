import 'package:flutter/material.dart';
import 'package:optima_delivery_mobile/generated/l10n.dart';
import 'package:optima_delivery_mobile/samples/pages/ControlPage.dart';
import 'package:optima_delivery_mobile/samples/pages/DeliveryComponentsPage.dart';
import 'package:optima_delivery_mobile/samples/pages/FontPage.dart';
import 'package:optima_delivery_mobile/samples/pages/IconPage.dart';
import 'package:optima_delivery_mobile/samples/pages/MapPage.dart';
import 'package:optima_delivery_mobile/samples/pages/ModalPage.dart';
import 'package:optima_delivery_mobile/samples/pages/ProfileComponentsPage.dart';
import 'package:optima_delivery_mobile/samples/pages/UrlChangePage.dart';

class Menu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          ExpansionTile(
            title: Text(S.of(context).componentSamples),
            children: <Widget>[
              ListTile(
                title: Text(S.of(context).changeUrl),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => UrlChangePage()),
                  );
                },
              ),
              ListTile(
                title: Text(S.of(context).samplesIcon),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => IconPage()),
                  );
                },
              ),
              ListTile(
                title: Text(S.of(context).samplesControl),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ControlPage()),
                  );
                },
              ),
              ListTile(
                title: Text(S.of(context).samplesFonts),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => FontPage()),
                  );
                },
              ),
              ListTile(
                title: Text(S.of(context).samplesModal),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ModalPage()),
                  );
                },
              ),
              ListTile(
                title: Text(S.of(context).samplesDelivery),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DeliveryComponentsPage()),
                  );
                },
              ),
              ListTile(
                title: Text(S.of(context).samplesProfile),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ProfileComponentsPage()),
                  );
                },
              ),
              ListTile(
                title: Text(S.of(context).samplesMap),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MapPage()),
                  );
                },
              ),
            ],
          ),
          ExpansionTile(
            title: Text(S.of(context).pagesSamples),
            children: <Widget>[
              ListTile(
                title: Text(S.of(context).pageSign),
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    '/',
                  );
                },
              ),
              ListTile(
                title: Text(S.of(context).pageDeliveryList),
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    '/delivery-list',
                  );
                },
              ),
              ListTile(
                title: Text(S.of(context).pageDelivery),
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    '/delivery',
                    arguments: 123,
                  );
                },
              ),
              ListTile(
                title: Text(S.of(context).pageMap),
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    '/map',
                  );
                },
              ),
              ListTile(
                title: Text(S.of(context).pageProfile),
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    '/profile',
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
