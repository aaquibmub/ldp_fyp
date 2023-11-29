class LdpHistoryListModel {
  final String name;
  final DateTime date;
  final int score;

  LdpHistoryListModel(
    this.name,
    this.date,
    this.score,
  );
  factory LdpHistoryListModel.fromJson(dynamic json) => LdpHistoryListModel(
        json['name'] as String,
        json['date'] != null ? DateTime.parse(json['date']) : null,
        json['score'] as int,
      );
}
