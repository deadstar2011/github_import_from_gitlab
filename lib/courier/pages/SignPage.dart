import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:optima_delivery_mobile/common/helpers/loading_statuses.dart';
import 'package:optima_delivery_mobile/common/helpers/snack.dart';
import 'package:optima_delivery_mobile/common/models/PushNotificationModel.dart';
import 'package:optima_delivery_mobile/common/styles/colors.dart';
import 'package:optima_delivery_mobile/common/styles/fonts.dart';
import 'package:optima_delivery_mobile/common/styles/paddings.dart';
import 'package:optima_delivery_mobile/common/widgets/Box.dart';
import 'package:optima_delivery_mobile/common/widgets/CodeText.dart';
import 'package:optima_delivery_mobile/common/widgets/Layout.dart';
import 'package:optima_delivery_mobile/common/widgets/NumberKeyboard.dart';
import 'package:optima_delivery_mobile/courier/widgets/AutoSignLoadingContainer.dart';
import 'package:optima_delivery_mobile/courier/models/CoordinateModel.dart';
import 'package:optima_delivery_mobile/courier/models/CourierModel.dart';
import 'package:optima_delivery_mobile/generated/l10n.dart';
import 'package:provider/provider.dart';

const int codeLength = 4;

class SignPage extends StatefulWidget {
  @override
  _SignPageState createState() => _SignPageState();
}

class _SignPageState extends State<SignPage> {
  BuildContext ctx;
  String _code = '';
  CourierModel courierModel;
  PushNotificationsModel pushModel;
  CoordinateModel coordinateModel;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    courierModel = Provider.of<CourierModel>(context, listen: false);
    pushModel = Provider.of<PushNotificationsModel>(context, listen: false);
    coordinateModel = Provider.of<CoordinateModel>(context, listen: false);
    isLoading = true;
    courierModel.autoSignIn().then((bool isSuccess) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          setState(() {
            isLoading = false;
          });
        }
      });
      if (isSuccess == true) {
        _handleSignSuccess();
      } else if (isSuccess == false) {
        courierModel.logout();
        WidgetsBinding.instance.addPostFrameCallback((_) {
          final snackBar =
              getErrorSnackBar(ctx, messageKey: 'authNetworkError');
          Scaffold.of(ctx).showSnackBar(snackBar);
        });
      }
    });
  }

  void _handleSignSuccess() async {
    coordinateModel.tryInitDependencies();
    pushModel.init();
    await Navigator.pushReplacementNamed(context, '/delivery-list');
  }

  String _getHeaderMessage(BuildContext context, LoadingStatuses status) {
    if (_code.length != codeLength) {
      return S.of(context).writeCode;
    }

    switch (status) {
      case (LoadingStatuses.noConnection):
        return S.of(context).connectionError;
      case (LoadingStatuses.failed):
      case (LoadingStatuses.noAuthorize):
        return S.of(context).badCode;
      case (LoadingStatuses.loading):
        return S.of(context).loading;
      default:
        return S.of(context).writeCode;
    }
  }

  void _handleKeyboardTap(String number) {
    if (_code.length < codeLength) {
      setState(() {
        _code = _code + number;
      });
    }
    if (_code.length >= codeLength) {
      courierModel.signIn(_code).then((bool isSuccess) {
        if (isSuccess) {
          _handleSignSuccess();
        }
      });
    }
  }

  void _handleTapRightButton() {
    if (_code.isNotEmpty) {
      setState(() {
        _code = _code.substring(0, _code.length - 1);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final loadingStatus =
        context.select((CourierModel m) => m.signLoadingStatus);
    final autoSignInLoadingStatus =
        context.select((CourierModel m) => m.autoSignLoadingStatus);

    return Layout(
      title: S.of(context).signIn,
      isAppBarActionVisible: false,
      isAppNavigatorVisible: false,
      body: Builder(
        builder: (layoutContext) {
          ctx = layoutContext;
          return Box(
            children: <Widget>[
              AutoSignLoadingContainer(
                isLoading: isLoading,
                loadingStatus: autoSignInLoadingStatus,
                child: Container(
                  padding: EdgeInsets.all(
                    StylePaddings.xsValue,
                  ),
                  color: StyleColors.primary1,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(4.0),
                      ),
                      color: StyleColors.white,
                    ),
                    child: Material(
                      child: Column(
                        children: <Widget>[
                          Container(
                            color: Colors.transparent,
                            padding: EdgeInsets.only(
                              top: 40.0,
                              bottom: StylePaddings.lValue,
                            ),
                            alignment: Alignment.topCenter,
                            child: Text(
                              _getHeaderMessage(context, loadingStatus) + '\n',
                              maxLines: 2,
                              textAlign: TextAlign.center,
                              style: StyleFont.styleP1.merge(
                                TextStyle(
                                  color: StyleColors.graphite7,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              bottom: StylePaddings.xlValue,
                            ),
                            child: CodeText(
                              isError: isErrorStatus(loadingStatus) &&
                                  _code.length == codeLength,
                              value: _code,
                              length: codeLength,
                            ),
                          ),
                          NumericKeyboard(
                            onKeyboardTap: _handleKeyboardTap,
                            rightIcon: SvgPicture.asset(
                              'assets/icons/backspace.svg',
                              color: StyleColors.graphite4,
                            ),
                            onTapRightButton: _handleTapRightButton,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
