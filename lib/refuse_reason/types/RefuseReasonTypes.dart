class RefuseReason {
  String title;
  int id;
  bool needComment;

  RefuseReason({
    this.title,
    this.id,
    this.needComment,
  });

  factory RefuseReason.fromJson(dynamic json) {
    if (json == null) {
      return null;
    }
    return RefuseReason(
      id: json['id'] as int,
      title: json['title'] as String,
      needComment: json['needComment'] as bool,
    );
  }

  void merge(RefuseReason mergedItem) {
    id = mergedItem.id ?? id;
    title = mergedItem.title ?? title;
    needComment = mergedItem.needComment ?? needComment;
  }
}
