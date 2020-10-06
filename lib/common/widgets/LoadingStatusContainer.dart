import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:optima_delivery_mobile/common/helpers/loading_statuses.dart';
import 'package:optima_delivery_mobile/common/styles/colors.dart';
import 'package:optima_delivery_mobile/common/styles/fonts.dart';
import 'package:optima_delivery_mobile/generated/l10n.dart';

class LoadingStatusContainer extends StatelessWidget {
  final LoadingStatuses loadingStatus;
  final Widget child;

  LoadingStatusContainer({
    @required this.loadingStatus,
    @required this.child,
  });

  @override
  Widget build(BuildContext context) {
    if (loadingStatus == LoadingStatuses.loading) {
      return Center(
        child: SpinKitDualRing(
          lineWidth: 5,
          color: StyleColors.primary6,
          duration: Duration(milliseconds: 1500),
        ),
      );
    }
    if (loadingStatus == LoadingStatuses.failed ||
        loadingStatus == LoadingStatuses.noConnection) {
      return Center(
        child: Text(
          S.of(context).loadingFailed,
          style: StyleFont.styleH5,
        ),
      );
    }
    if (loadingStatus == LoadingStatuses.finished ||
        loadingStatus == LoadingStatuses.untouched ||
        loadingStatus == LoadingStatuses.noAuthorize) {
      return child;
    }

    return Container();
  }
}
