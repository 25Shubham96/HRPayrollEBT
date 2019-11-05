import 'dart:convert';

NavigateResponseKins navigateResponseKinsFromJson(String str) =>
    NavigateResponseKins.fromJson(json.decode(str));

String navigateResponseKinsToJson(NavigateResponseKins data) =>
    json.encode(data.toJson());

class NavigateResponseKins {
  bool status;
  String message;
  List<KinsModel> data;

  NavigateResponseKins({
    this.status,
    this.message,
    this.data,
  });

  factory NavigateResponseKins.fromJson(Map<String, dynamic> json) =>
      new NavigateResponseKins(
        status: json["status"],
        message: json["message"],
        data: new List<KinsModel>.from(
            json["data"].map((x) => KinsModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": new List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class KinsModel {
  String employeeNo;
  String name;
  String relation;
  var emergencyContact;
  String address1;
  String address2;
  String address3;
  String address4;
  String address5;
  String postCode;
  String homePhoneNo;
  String workPhoneNo;
  String eMai;
  String mobileNumber;
  var beneficiary;
  String notes;
  String firstName;
  String lastName;
  String knownAs;
  var nominee;
  String dateOfBirth;
  String sex;
  String sponsoredBy;
  String educationStatus;
  String placeOfBirth;
  String relationCode;
  int age;
  var benefitStatus;
  String relationshipType;
  String religion;
  String countryCode;

  KinsModel({
    this.employeeNo,
    this.name,
    this.relation,
    this.emergencyContact,
    this.address1,
    this.address2,
    this.address3,
    this.address4,
    this.address5,
    this.postCode,
    this.homePhoneNo,
    this.workPhoneNo,
    this.eMai,
    this.mobileNumber,
    this.beneficiary,
    this.notes,
    this.firstName,
    this.lastName,
    this.knownAs,
    this.nominee,
    this.dateOfBirth,
    this.sex,
    this.sponsoredBy,
    this.educationStatus,
    this.placeOfBirth,
    this.relationCode,
    this.age,
    this.benefitStatus,
    this.relationshipType,
    this.religion,
    this.countryCode,
  });

  factory KinsModel.fromJson(Map<String, dynamic> json) => new KinsModel(
        employeeNo: json["Employee No_"],
        name: json["Name"],
        relation: json["Relation"],
        emergencyContact: json["Emergency Contact"],
        address1: json["Address1"],
        address2: json["Address2"],
        address3: json["Address3"],
        address4: json["Address4"],
        address5: json["Address5"],
        postCode: json["Post Code"],
        homePhoneNo: json["Home Phone No"],
        workPhoneNo: json["Work Phone No"],
        eMai: json["E-mai"],
        mobileNumber: json["Mobile Number"],
        beneficiary: json["Beneficiary"],
        notes: json["Notes"],
        firstName: json["First Name"],
        lastName: json["Last Name"],
        knownAs: json["Known As"],
        nominee: json["Nominee"],
        dateOfBirth: json["Date of Birth"],
        sex: json["Sex"],
        sponsoredBy: json["Sponsored By"],
        educationStatus: json["Education Status"],
        placeOfBirth: json["Place of Birth"],
        relationCode: json["Relation Code"],
        age: json["Age"],
        benefitStatus: json["Benefit Status"],
        relationshipType: json["Relationship Type"],
        religion: json["Religion"],
        countryCode: json["Country Code"],
      );

  Map<String, dynamic> toJson() => {
        "Employee No_": employeeNo,
        "Name": name,
        "Relation": relation,
        "Emergency Contact": emergencyContact,
        "Address1": address1,
        "Address2": address2,
        "Address3": address3,
        "Address4": address4,
        "Address5": address5,
        "Post Code": postCode,
        "Home Phone No": homePhoneNo,
        "Work Phone No": workPhoneNo,
        "E-mai": eMai,
        "Mobile Number": mobileNumber,
        "Beneficiary": beneficiary,
        "Notes": notes,
        "First Name": firstName,
        "Last Name": lastName,
        "Known As": knownAs,
        "Nominee": nominee,
        "Date of Birth": dateOfBirth,
        "Sex": sex,
        "Sponsored By": sponsoredBy,
        "Education Status": educationStatus,
        "Place of Birth": placeOfBirth,
        "Relation Code": relationCode,
        "Age": age,
        "Benefit Status": benefitStatus,
        "Relationship Type": relationshipType,
        "Religion": religion,
        "Country Code": countryCode,
      };
}
