class SlotModel {
  final String slotId, day;

  final DateTime startTime, endTime;
  SlotModel({this.slotId, this.day, this.endTime, this.startTime});
  factory SlotModel.fromMap(Map<String, dynamic> json) => SlotModel(
      slotId: json["slotId"],
      day: json["day"],
      startTime: json["startTime"].toDate(),
      endTime: json["endTime"].toDate());
}
