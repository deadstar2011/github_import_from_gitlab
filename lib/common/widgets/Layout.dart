import 'package:flutter/material.dart';
import 'package:optima_delivery_mobile/common/widgets/BottomNavigation.dart';
import 'package:optima_delivery_mobile/common/widgets/Header.dart';
import 'package:optima_delivery_mobile/common/widgets/Menu.dart';
import 'package:optima_delivery_mobile/common/widgets/Modal.dart';
import 'package:optima_delivery_mobile/courier/models/CourierModel.dart';
import 'package:optima_delivery_mobile/courier/widgets/CourierExitModalContent.dart';
import 'package:provider/provider.dart';

class Layout extends StatefulWidget {
  final Widget body;
  final String title;
  final bool isAppBarActionVisible;
  final bool isAppNavigatorVisible;
  final bool isAppActionButtonVisible;
  final bool isBackVisible;
  final Widget actionButton;

  Layout({
    @required this.body,
    @required this.title,
    this.isAppBarActionVisible = true,
    this.isAppNavigatorVisible = true,
    this.isAppActionButtonVisible = false,
    this.isBackVisible = false,
    this.actionButton,
  });

  @override
  _LayoutState createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
  @override
  Widget build(BuildContext context) {
    final courierModel = Provider.of<CourierModel>(context, listen: true);
    final dispatcherPhone = courierModel.item != null
        ? courierModel.item.warehouse.dispatcherPhone
        : null;

    return WillPopScope(
      onWillPop: () async {
        final isNotBeforeAppClosed = Navigator.canPop(context);

        if (!isNotBeforeAppClosed) {
          final shouldClose = await showSpecialDialog(
            mainAxisAlignment: MainAxisAlignment.start,
            context: context,
            children: [
              CourierExitModalContent(dispatcherPhone: dispatcherPhone)
            ],
          );

          return shouldClose as bool;
        }

        return true;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: Header(
          title: widget.title,
          isActionVisible: widget.isAppBarActionVisible,
          isBackVisible: widget.isBackVisible,
          dispatcherPhone: dispatcherPhone,
        ),
        body: widget.body,
        bottomNavigationBar:
            widget.isAppNavigatorVisible ? BottomNavigation() : null,
        drawer: Menu(),
        floatingActionButton:
            widget.isAppActionButtonVisible ? widget.actionButton : null,
      ),
    );
  }
}
