class MemoData {
  MemoData({this.memo, required this.date});

  int? id;
  String? memo;
  DateTime? date;

  Map<String, dynamic> toMap() {
    String savedDate = date.toString();
    return {'memo': memo, 'date': savedDate};
  }
}
