class MentorModel {
  String mentorId;
  String fullname;
  String cnic;
  String email;
  String password;
  String gender;
  String educationlevel;
  String fieldOfEducation;
  String jobDesc;
  String expYears;
  String phone;

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

  factory MentorModel.fromJson(Map<String, dynamic> j) => MentorModel(
      cnic: j["cnic"],
      mentorId: j["mentorId"],
      fullname: j["fullname"],
      email: j["email"],
      gender: j["gender"],
      expYears: j["expYears"],
      jobDesc: j["jobDesc"],
      fieldOfEducation: j["fieldOfEducation"],
      educationlevel: j["educationlevel"],
      password: j["password"],
      phone: j["phone"]);

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
