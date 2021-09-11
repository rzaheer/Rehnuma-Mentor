class MentorModel {
  final String mentorId;
  final String fullname;
  final String cnic;
  final String email;
  final String password;
  final String gender;
  final String educationlevel;
  final String fieldOfEducation;
  final String jobDesc;
  final String expYears;
  final String phone;

  MentorModel({
    this.phone,
    this.mentorId,
    this.fullname,
    this.email,
    this.password,
    this.gender,
    this.educationlevel,
    this.fieldOfEducation,
    this.cnic,
    this.expYears,
    this.jobDesc,
  });

  factory MentorModel.fromJson(Map<String, dynamic> json) => MentorModel();

  Map<String, dynamic> toJson() => {
        "mentorId": mentorId,
        "fullname": fullname,
        "email": email,
        "gender": gender,
        "cnic": cnic,
        "expYears": expYears,
        "jobDesc": jobDesc,
        "fieldOfEducation": fieldOfEducation,
        "educationlevel": educationlevel,
        "password": password,
        "phone": phone,
      };
}
