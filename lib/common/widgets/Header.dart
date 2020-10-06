import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:optima_delivery_mobile/common/helpers/snack.dart';
import 'package:optima_delivery_mobile/common/styles/colors.dart';
import 'package:optima_delivery_mobile/common/styles/fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class Header extends StatelessWidget with PreferredSizeWidget {
  final String title;
  final bool isActionVisible;
  final bool isBackVisible;
  final String dispatcherPhone;

  Header({
    @required this.title,
    this.isActionVisible,
    this.isBackVisible,
    this.dispatcherPhone,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      leading: isBackVisible == true
          ? IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(
                  context,
                );
              },
            )
          : null,
      title: Text(title, style: StyleFont.styleH6),
      actions: _renderActions(context),
    );
  }

  List<Widget> _renderActions(BuildContext context) {
    final actions = <Widget>[];
    final isMenuHidden = GlobalConfiguration().getBool('isProduction');
    if (isActionVisible) {
      actions.add(_renderCallDispatcher(context));
    }

    if (!isMenuHidden) {
      actions.add(
        _renderMenu(context),
      );
    }

    return actions;
  }

  Widget _renderCallDispatcher(BuildContext context) {
    return IconButton(
      icon: SvgPicture.asset('assets/icons/dispatcher.svg'),
      onPressed: () async {
        if (dispatcherPhone != null &&
            await canLaunch('tel:$dispatcherPhone')) {
          await launch('tel:$dispatcherPhone');
        } else {
          final snackBar =
              getErrorSnackBar(context, messageKey: 'incorrectPhone');
          Scaffold.of(context).showSnackBar(snackBar);
        }
      },
    );
  }

  Widget _renderMenu(BuildContext context) {
    return IconButton(
      icon: SvgPicture.asset(
        'assets/icons/note_list.svg',
        color: StyleColors.primary6,
      ),
      onPressed: () {
        Scaffold.of(context).openDrawer();
      },
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
