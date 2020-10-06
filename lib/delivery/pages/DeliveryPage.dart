import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:optima_delivery_mobile/common/helpers/loading_statuses.dart';
import 'package:optima_delivery_mobile/common/helpers/snack.dart';
import 'package:optima_delivery_mobile/common/styles/colors.dart';
import 'package:optima_delivery_mobile/common/styles/fonts.dart';
import 'package:optima_delivery_mobile/common/styles/paddings.dart';
import 'package:optima_delivery_mobile/common/widgets/Box.dart';
import 'package:optima_delivery_mobile/common/widgets/Button.dart';
import 'package:optima_delivery_mobile/common/widgets/Layout.dart';
import 'package:optima_delivery_mobile/common/widgets/LoadingStatusContainer.dart';
import 'package:optima_delivery_mobile/common/widgets/Modal.dart';
import 'package:optima_delivery_mobile/common/widgets/NoAutorizeChecker.dart';
import 'package:optima_delivery_mobile/common/widgets/RadioGroup.dart';
import 'package:optima_delivery_mobile/common/widgets/StatusBanner.dart';
import 'package:optima_delivery_mobile/delivery/models/DeliveryModel.dart';
import 'package:optima_delivery_mobile/delivery/widgets/DeliveryCard.dart';
import 'package:optima_delivery_mobile/delivery/widgets/DeliveryFinishModalContent.dart';
import 'package:optima_delivery_mobile/delivery/widgets/DeliveryInfo.dart';
import 'package:optima_delivery_mobile/generated/l10n.dart';
import 'package:optima_delivery_mobile/refuse_reason/models/RefuseReasonModel.dart';
import 'package:provider/provider.dart';

const showCardStatusList = [
  'doNotDial',
  'refused',
  'problems',
  'finished',
];

class DeliveryPage extends StatefulWidget {
  final int id;

  DeliveryPage(this.id);

  @override
  _DeliveryPageState createState() => _DeliveryPageState();
}

class _DeliveryPageState extends State<DeliveryPage>
    with WidgetsBindingObserver {
  DeliveryModel deliveryModel;
  RefuseReasonModel refuseReasonModel;
  AppLifecycleState lastState;
  String _picked;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    deliveryModel = Provider.of<DeliveryModel>(context, listen: false);
    refuseReasonModel = Provider.of<RefuseReasonModel>(context, listen: false);
    deliveryModel.loadItem(widget.id);
    refuseReasonModel.loadList(widget.id);
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
      deliveryModel.loadItem(widget.id);
      refuseReasonModel.loadList(widget.id);
    }
    lastState = state;
  }

  String _getStatusBannerMessage(BuildContext context, String status) {
    switch (status) {
      case ('refused'):
        return S.of(context).refuseDelivery;
      case ('problems'):
        return S.of(context).finishedWithProblems;
      case ('finished'):
        return S.of(context).finished;
      case ('doNotDial'):
        return S.of(context).doNotDial;
      default:
        return '';
    }
  }

  void Function() _handleNotDial(BuildContext context) {
    return () {
      deliveryModel.setCallItem(widget.id, 0).then((isSuccess) {
        if (!isSuccess) {
          final snackBar = getErrorSnackBar(context);
          Scaffold.of(context).showSnackBar(snackBar);
        }
      });
    };
  }

  void Function() _handleClientReady(BuildContext context) {
    return () {
      deliveryModel.setCallItem(widget.id, 1).then((isSuccess) {
        if (!isSuccess) {
          final snackBar = getErrorSnackBar(context);
          Scaffold.of(context).showSnackBar(snackBar);
        }
      });
    };
  }

  void Function() _handleStartMoving(BuildContext context) {
    return () {
      deliveryModel.setGoItem(widget.id).then((isSuccess) {
        if (!isSuccess) {
          final snackBar = getErrorSnackBar(context);
          Scaffold.of(context).showSnackBar(snackBar);
        }
      });
    };
  }

  void Function() _handleDelivered(int rest, BuildContext context) {
    return () {
      deliveryModel.setFinishItem(widget.id).then((isSuccess) {
        if (isSuccess == true) {
          showSpecialDialog(context: context, children: [
            StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                final restPositive = rest < 0 ? 0 : rest;
                return DeliveryFinishModalContent(restPositive);
              },
            ),
          ]);
        } else {
          final snackBar = getErrorSnackBar(context);
          Scaffold.of(context).showSnackBar(snackBar);
        }
      });
    };
  }

  @override
  Widget build(BuildContext context) {
    final deliveryModel = Provider.of<DeliveryModel>(context);
    final delivery = deliveryModel.getDeliveryItem(widget.id);
    final restDeliveryCount = deliveryModel.restCount;
    final client = delivery != null
        ? deliveryModel.getClientItem(delivery.clientId)
        : null;
    final deliveryLoadingStatus = deliveryModel.itemLoadingStatus;
    final deliveryChangeLoadingStatus = deliveryModel.itemChangeStatus;

    final refuseReasonModel = Provider.of<RefuseReasonModel>(context);
    final refuseReasonList = refuseReasonModel.optionItems;
    final refuseReasonLoadingStatus = refuseReasonModel.loadingStatus;

    final shouldShowInfo =
        deliveryLoadingStatus == LoadingStatuses.finished && delivery != null;
    final shouldShowCard =
        shouldShowInfo && !showCardStatusList.contains(delivery.status);
    final shouldShowBanner = shouldShowInfo && !shouldShowCard;

    return Layout(
      isAppNavigatorVisible: false,
      isAppActionButtonVisible: true,
      isBackVisible: true,
      title: S
          .of(context)
          .deliveryHeader(delivery != null ? '#${delivery.number}' : ''),
      actionButton: FloatingActionButton(
        backgroundColor: StyleColors.white,
        child: SvgPicture.asset(
          'assets/icons/address_filled.svg',
        ),
        onPressed: () {
          Navigator.pushNamedAndRemoveUntil(context, '/map', (route) => false,
              arguments: delivery != null && delivery.address != null
                  ? delivery.address.coordinates
                  : null);
        },
      ),
      body: Builder(
        builder: (layoutContext) => Box(
          children: <Widget>[
            LoadingStatusContainer(
              loadingStatus: mergeLoadingStatusList([
                deliveryLoadingStatus,
                refuseReasonLoadingStatus,
              ]),
              child: NoAuthorizeChecker(
                loadingStatus: mergeLoadingStatusList([
                  deliveryLoadingStatus,
                  deliveryChangeLoadingStatus,
                  refuseReasonLoadingStatus,
                ]),
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      StatusBanner(
                        isVisible: shouldShowBanner,
                        message: _getStatusBannerMessage(
                            context, delivery != null ? delivery.status : ''),
                        type: 'notify',
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      if (shouldShowCard)
                        Padding(
                          padding: StylePaddings.xs,
                          child: DeliveryCard(
                            delivery: delivery,
                            onNotDial: _handleNotDial(layoutContext),
                            onClientReady: _handleClientReady(layoutContext),
                            onStartMoving: _handleStartMoving(layoutContext),
                            onDelivered: _handleDelivered(
                                restDeliveryCount - 1, layoutContext),
                            onHaveProblems: () {
                              showSpecialDialog(
                                mainAxisAlignment: MainAxisAlignment.start,
                                context: context,
                                padding: EdgeInsets.only(
                                  top: StylePaddings.lValue,
                                  right: StylePaddings.lValue,
                                  bottom: StylePaddings.lValue,
                                ),
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: StylePaddings.lValue),
                                    child: Text(
                                      (S.of(context).whatIsTheProblem),
                                      style: StyleFont.styleH6,
                                    ),
                                  ),
                                  Material(
                                    child: StatefulBuilder(builder:
                                        (BuildContext context,
                                            StateSetter setState) {
                                      return Column(
                                        children: <Widget>[
                                          RadioGroup(
                                            options: refuseReasonList,
                                            onChanged: (String value) {
                                              setState(() {
                                                _picked = value;
                                              });
                                            },
                                            value: _picked,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: <Widget>[
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    right: 10.0),
                                                child: Button(
                                                  hasShadow: false,
                                                  color: Colors.transparent,
                                                  textColor:
                                                      StyleColors.primary7,
                                                  text: S
                                                      .of(context)
                                                      .cancel
                                                      .toUpperCase(),
                                                  onPressed: () {
                                                    setState(() {
                                                      _picked = null;
                                                    });
                                                    Navigator.pop(context);
                                                  },
                                                ),
                                              ),
                                              Button(
                                                text: S
                                                    .of(context)
                                                    .save
                                                    .toUpperCase(),
                                                onPressed: _picked != null
                                                    ? () {
                                                        deliveryModel
                                                            .setRefuseItem(
                                                                widget.id,
                                                                _picked)
                                                            .then(
                                                          (isSuccess) {
                                                            if (isSuccess ==
                                                                true) {
                                                              final restPositive =
                                                                  restDeliveryCount -
                                                                              1 <
                                                                          0
                                                                      ? 0
                                                                      : restDeliveryCount -
                                                                          1;
                                                              Navigator.pop(
                                                                  context);
                                                              showSpecialDialog(
                                                                  context:
                                                                      context,
                                                                  children: [
                                                                    DeliveryFinishModalContent(
                                                                        restPositive),
                                                                  ]);
                                                            } else {
                                                              Navigator.pop(
                                                                  context);
                                                              final snackBar =
                                                                  getErrorSnackBar(
                                                                      layoutContext);
                                                              Scaffold.of(
                                                                      layoutContext)
                                                                  .showSnackBar(
                                                                      snackBar);
                                                            }
                                                          },
                                                        );
                                                      }
                                                    : null,
                                              ),
                                            ],
                                          ),
                                        ],
                                      );
                                    }),
                                    color: Colors.transparent,
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      if (shouldShowInfo)
                        Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: StylePaddings.xsValue,
                          ),
                          child: DeliveryInfo(
                            client: client,
                            delivery: delivery,
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
