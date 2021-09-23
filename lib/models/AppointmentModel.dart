class AppointmentModel {
  String appointmentId, mentorId, studentId, slotId, mentorName, studentName;
  DateTime startTime, endTime;

  bool isCompleted, paymentReceived;

  AppointmentModel(
      {this.appointmentId,
      this.mentorId,
      this.studentId,
      this.studentName,
      this.slotId,
      this.mentorName,
      this.endTime,
      this.startTime,
      this.isCompleted,
      this.paymentReceived});

  factory AppointmentModel.fromJson(Map<String, dynamic> json) =>
      AppointmentModel(
          appointmentId: json["appointmentId"],
          mentorId: json["mentorId"],
          slotId: json["slotId"],
          studentId: json["studentId"],
          endTime: json["endTime"].toDate(),
          startTime: json["startTime"].toDate(),
          isCompleted: json["isCompleted"] ?? false,
          mentorName: json["mentorName"] ?? "",
          studentName: json["studentName"] ?? "",
          paymentReceived: json["paymentReceived"]);

  Map<String, dynamic> toJson() => {
        "appointmentId": appointmentId,
        "mentorId": mentorId,
        "studentId": studentId,
        "endTime": endTime,
        "startTime": startTime,
        "isCompleted": isCompleted,
        "slotId": slotId,
        "mentorName": mentorName,
        "studentName": studentName,
        "paymentReceived": paymentReceived
      };
}
