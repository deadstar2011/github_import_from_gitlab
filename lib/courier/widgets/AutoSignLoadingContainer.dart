import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:optima_delivery_mobile/common/helpers/loading_statuses.dart';
import 'package:optima_delivery_mobile/common/styles/colors.dart';

class AutoSignLoadingContainer extends StatelessWidget {
  final LoadingStatuses loadingStatus;
  final bool isLoading;
  final Widget child;

  AutoSignLoadingContainer({
    @required this.loadingStatus,
    @required this.child,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    if (loadingStatus == LoadingStatuses.loading ||
        loadingStatus == LoadingStatuses.finished ||
        isLoading) {
      return Center(
        child: SpinKitDualRing(
          lineWidth: 5,
          color: StyleColors.primary6,
          duration: Duration(milliseconds: 1500),
        ),
      );
    } else {
      return child;
    }
  }
}
