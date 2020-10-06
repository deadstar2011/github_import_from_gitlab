enum LoadingStatuses {
  untouched,
  loading,
  failed,
  noConnection,
  noAuthorize,
  finished
}

bool isErrorStatus(LoadingStatuses status) {
  return status == LoadingStatuses.failed ||
      status == LoadingStatuses.noConnection;
}

LoadingStatuses mergeLoadingStatusList(List<LoadingStatuses> list) {
  final isError = list.contains(LoadingStatuses.failed);

  if (isError) {
    return LoadingStatuses.failed;
  }

  final isNoConnection = list.contains(LoadingStatuses.noConnection);

  if (isNoConnection) {
    return LoadingStatuses.noConnection;
  }

  final isNoAuthorize = list.contains(LoadingStatuses.noAuthorize);

  if (isNoAuthorize) {
    return LoadingStatuses.noAuthorize;
  }

  final isLoading = list.contains(LoadingStatuses.loading);

  if (isLoading) {
    return LoadingStatuses.loading;
  }

  final isUntouched = list.contains(LoadingStatuses.untouched);

  if (isUntouched) {
    return LoadingStatuses.untouched;
  }

  return LoadingStatuses.finished;
}
