import 'dart:convert';

EmployeeMasterResponse employeeMasterFromJson(String str) =>
    EmployeeMasterResponse.fromJson(json.decode(str));

String employeeMasterToJson(EmployeeMasterResponse data) =>
    json.encode(data.toJson());

class EmployeeMasterResponse {
  bool status;
  String message;
  List<EmployeeMasterModel> data;

  EmployeeMasterResponse({
    this.status,
    this.message,
    this.data,
  });

  factory EmployeeMasterResponse.fromJson(Map<String, dynamic> json) =>
      new EmployeeMasterResponse(
        status: json["status"],
        message: json["message"],
        data: new List<EmployeeMasterModel>.from(
            json["data"].map((x) => EmployeeMasterModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": new List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class EmployeeMasterModel {
  String no;
  String firstName;
  String lastName;
  String gradePayCadre;
  String employmentDate;
  String sponser;
  String employeeLocation;
  var postToGl;
  var entitleForDepedantFlight;
  var entitleForDepedantIsurance;
  var resigned;
  var termination;
  String city;
  String countryCode;
  String designation;
  int status;
  String periodStartDate;
  String periodEndDate;
  String departmentCode;
  String empPostingGroup;
  String payrollBusPostingGroup;
  var probation;
  String no1;
  String employeeLocation1;
  String jobTitle;
  String operationType;
  String initials;
  String searchName;
  String address;
  String address2;
  String postCode;
  String phoneNo;
  String mobilePhoneNo;
  String eMail;
  String extension;
  String country;
  String birthDate;
  int age;
  int gender;
  String inactiveDate;
  String causeOfInactivityCode;
  String terminationDate;
  String groundsForTermCode;
  String globalDimension1Code;
  String globalDimension2Code;
  String lastDateModified;
  String noSeries;
  int maritalStatus;
  String spouseName;
  String weddingDate;
  int noOfChildren;
  String drivingLicenseNo;
  String fatherHusband;
  int bloodGroup;
  int paymentMethod;
  String resignationDate;
  String confirmationDate;
  int experience;
  var releaseStatus;
  var blocked;
  var attendanceNotGenerated;
  var otApplicable;
  double otNormalRate;
  var leavesNotGenerated;
  String blockedDate;
  String userId;
  var stopPayment;
  String placeOfBirth;
  String nationalityCountry;
  String probnDuration;
  int probLeavesAdded;
  String emiratesIdNo;
  String emiratesIdExpiryDate;
  String insuranceCompanyName;
  String insuranceNo;
  String insuranceCardExpiryDate;
  String homeCountryNumber;
  String employeeACWithAgent;
  String firstNameArabic;
  String middleNameArabic;
  String lastNameArabic;
  var hajLeaveApplicable;
  String passportNumber;
  String passportExpiryDate;
  var passpostRetentionRequired;
  var passportObtained;
  var passportReleased;
  var maternityApplicable;
  String passportIssueDate;
  String visaSponsorsedBy;
  String visaExpiryDate;
  String laborCardStatus;
  String laborExpiryDate;
  String labourCardNumber;
  String probationEndDate;
  String employmentEndDate;
  var jobStatus;
  String employeeUniqueId;
  String employeeIbanNo;
  String employeeBankName;
  String employeeBranchName;
  String probationReviewDate;
  String probationExtendedFor;
  String visaCategory;
  String visaNo;
  String employeeAccountNo;
  String employeeBankCode;
  String employeeBankId;
  double airfareAllowance;
  String nomineeContactNo;
  String swift;
  String routingNo;
  String personalEmail;
  String homeCountryAirport;
  double otHolidayRate;
  String middleName;
  int noOfChildren1;

  bool selected = false;

  EmployeeMasterModel({
    this.no,
    this.firstName,
    this.lastName,
    this.gradePayCadre,
    this.employmentDate,
    this.sponser,
    this.employeeLocation,
    this.postToGl,
    this.entitleForDepedantFlight,
    this.entitleForDepedantIsurance,
    this.resigned,
    this.termination,
    this.city,
    this.countryCode,
    this.designation,
    this.status,
    this.periodStartDate,
    this.periodEndDate,
    this.departmentCode,
    this.empPostingGroup,
    this.payrollBusPostingGroup,
    this.probation,
    this.no1,
    this.employeeLocation1,
    this.jobTitle,
    this.operationType,
    this.initials,
    this.searchName,
    this.address,
    this.address2,
    this.postCode,
    this.phoneNo,
    this.mobilePhoneNo,
    this.eMail,
    this.extension,
    this.country,
    this.birthDate,
    this.age,
    this.gender,
    this.inactiveDate,
    this.causeOfInactivityCode,
    this.terminationDate,
    this.groundsForTermCode,
    this.globalDimension1Code,
    this.globalDimension2Code,
    this.lastDateModified,
    this.noSeries,
    this.maritalStatus,
    this.spouseName,
    this.weddingDate,
    this.noOfChildren,
    this.drivingLicenseNo,
    this.fatherHusband,
    this.bloodGroup,
    this.paymentMethod,
    this.resignationDate,
    this.confirmationDate,
    this.experience,
    this.releaseStatus,
    this.blocked,
    this.attendanceNotGenerated,
    this.otApplicable,
    this.otNormalRate,
    this.leavesNotGenerated,
    this.blockedDate,
    this.userId,
    this.stopPayment,
    this.placeOfBirth,
    this.nationalityCountry,
    this.probnDuration,
    this.probLeavesAdded,
    this.emiratesIdNo,
    this.emiratesIdExpiryDate,
    this.insuranceCompanyName,
    this.insuranceNo,
    this.insuranceCardExpiryDate,
    this.homeCountryNumber,
    this.employeeACWithAgent,
    this.firstNameArabic,
    this.middleNameArabic,
    this.lastNameArabic,
    this.hajLeaveApplicable,
    this.passportNumber,
    this.passportExpiryDate,
    this.passpostRetentionRequired,
    this.passportObtained,
    this.passportReleased,
    this.maternityApplicable,
    this.passportIssueDate,
    this.visaSponsorsedBy,
    this.visaExpiryDate,
    this.laborCardStatus,
    this.laborExpiryDate,
    this.labourCardNumber,
    this.probationEndDate,
    this.employmentEndDate,
    this.jobStatus,
    this.employeeUniqueId,
    this.employeeIbanNo,
    this.employeeBankName,
    this.employeeBranchName,
    this.probationReviewDate,
    this.probationExtendedFor,
    this.visaCategory,
    this.visaNo,
    this.employeeAccountNo,
    this.employeeBankCode,
    this.employeeBankId,
    this.airfareAllowance,
    this.nomineeContactNo,
    this.swift,
    this.routingNo,
    this.personalEmail,
    this.homeCountryAirport,
    this.otHolidayRate,
    this.middleName,
    this.noOfChildren1,
  });

  factory EmployeeMasterModel.fromJson(Map<String, dynamic> json) =>
      new EmployeeMasterModel(
        no: json["No_"],
        firstName: json["First Name"],
        lastName: json["Last Name"],
        gradePayCadre: json["Grade_Pay Cadre"],
        employmentDate: json["Employment Date"],
        sponser: json["Sponser"],
        employeeLocation: json["Employee Location"],
        postToGl: json["Post to GL"],
        entitleForDepedantFlight: json["Entitle for Depedant Flight"],
        entitleForDepedantIsurance: json["Entitle for Depedant Isurance"],
        resigned: json["Resigned"],
        termination: json["Termination"],
        city: json["City"],
        countryCode: json["Country Code"],
        designation: json["Designation"],
        status: json["Status"],
        periodStartDate: json["Period Start Date"],
        periodEndDate: json["Period End Date"],
        departmentCode: json["Department Code"],
        empPostingGroup: json["Emp Posting Group"],
        payrollBusPostingGroup: json["Payroll Bus_ Posting Group"],
        probation: json["Probation"],
        no1: json["No_1"],
        employeeLocation1: json["Employee Location1"],
        jobTitle: json["Job Title"],
        operationType: json["Operation Type"],
        initials: json["Initials"],
        searchName: json["Search Name"],
        address: json["Address"],
        address2: json["Address 2"],
        postCode: json["Post Code"],
        phoneNo: json["Phone No_"],
        mobilePhoneNo: json["Mobile Phone No_"],
        eMail: json["E-Mail"],
        extension: json["Extension"],
        country: json["Country"],
        birthDate: json["Birth Date"],
        age: json["Age"],
        gender: json["Gender"],
        inactiveDate: json["Inactive Date"],
        causeOfInactivityCode: json["Cause of Inactivity Code"],
        terminationDate: json["Termination Date"],
        groundsForTermCode: json["Grounds for Term_ Code"],
        globalDimension1Code: json["Global Dimension 1 Code"],
        globalDimension2Code: json["Global Dimension 2 Code"],
        lastDateModified: json["Last Date Modified"],
        noSeries: json["No_ Series"],
        maritalStatus: json["Marital Status"],
        spouseName: json["Spouse Name"],
        weddingDate: json["Wedding Date"],
        noOfChildren: json["No_ Of Children"],
        drivingLicenseNo: json["Driving License No_"],
        fatherHusband: json["Father_Husband"],
        bloodGroup: json["Blood Group"],
        paymentMethod: json["Payment Method"],
        resignationDate: json["Resignation Date"],
        confirmationDate: json["Confirmation Date"],
        experience: json["Experience"],
        releaseStatus: json["Release Status"],
        blocked: json["Blocked"],
        attendanceNotGenerated: json["Attendance Not Generated"],
        otApplicable: json["OT Applicable"],
        otNormalRate: json["OT Normal Rate"],
        leavesNotGenerated: json["Leaves Not Generated"],
        blockedDate: json["Blocked Date"],
        userId: json["User Id"],
        stopPayment: json["Stop Payment"],
        placeOfBirth: json["Place of Birth"],
        nationalityCountry: json["Nationality Country"],
        probnDuration: json["Probn_Duration"],
        probLeavesAdded: json["Prob Leaves Added"],
        emiratesIdNo: json["Emirates ID No_"],
        emiratesIdExpiryDate: json["Emirates ID Expiry Date"],
        insuranceCompanyName: json["Insurance Company Name"],
        insuranceNo: json["Insurance No_"],
        insuranceCardExpiryDate: json["Insurance Card Expiry Date"],
        homeCountryNumber: json["Home Country Number"],
        employeeACWithAgent: json["Employee A_C With Agent"],
        firstNameArabic: json["First Name (Arabic)"],
        middleNameArabic: json["Middle Name (Arabic)"],
        lastNameArabic: json["Last Name (Arabic)"],
        hajLeaveApplicable: json["Haj leave Applicable"],
        passportNumber: json["Passport Number"],
        passportExpiryDate: json["Passport Expiry Date"],
        passpostRetentionRequired: json["Passpost Retention Required"],
        passportObtained: json["Passport Obtained"],
        passportReleased: json["Passport Released"],
        maternityApplicable: json["Maternity Applicable"],
        passportIssueDate: json["Passport Issue Date"],
        visaSponsorsedBy: json["Visa Sponsorsed by"],
        visaExpiryDate: json["Visa Expiry Date"],
        laborCardStatus: json["Labor Card Status"],
        laborExpiryDate: json["Labor Expiry Date"],
        labourCardNumber: json["Labour Card Number"],
        probationEndDate: json["Probation End Date"],
        employmentEndDate: json["Employment End Date"],
        jobStatus: json["Job Status"],
        employeeUniqueId: json["Employee Unique ID"],
        employeeIbanNo: json["Employee IBAN No"],
        employeeBankName: json["Employee Bank Name"],
        employeeBranchName: json["Employee Branch Name"],
        probationReviewDate: json["Probation Review Date"],
        probationExtendedFor: json["Probation Extended For"],
        visaCategory: json["Visa Category"],
        visaNo: json["Visa No_"],
        employeeAccountNo: json["Employee Account No_"],
        employeeBankCode: json["Employee Bank Code"],
        employeeBankId: json["Employee Bank ID"],
        airfareAllowance: json["Airfare Allowance"],
        nomineeContactNo: json["Nominee Contact No_"],
        swift: json["SWIFT"],
        routingNo: json["Routing no_"],
        personalEmail: json["Personal Email"],
        homeCountryAirport: json["Home Country Airport"],
        otHolidayRate: json["OT Holiday Rate"],
        middleName: json["Middle Name"],
        noOfChildren1: json["No_ Of Children1"],
      );

  Map<String, dynamic> toJson() => {
        "No_": no,
        "First Name": firstName,
        "Last Name": lastName,
        "Grade_Pay Cadre": gradePayCadre,
        "Employment Date": employmentDate,
        "Sponser": sponser,
        "Employee Location": employeeLocation,
        "Post to GL": postToGl,
        "Entitle for Depedant Flight": entitleForDepedantFlight,
        "Entitle for Depedant Isurance": entitleForDepedantIsurance,
        "Resigned": resigned,
        "Termination": termination,
        "City": city,
        "Country Code": countryCode,
        "Designation": designation,
        "Status": status,
        "Period Start Date": periodStartDate,
        "Period End Date": periodEndDate,
        "Department Code": departmentCode,
        "Emp Posting Group": empPostingGroup,
        "Payroll Bus_ Posting Group": payrollBusPostingGroup,
        "Probation": probation,
        "No_1": no1,
        "Employee Location1": employeeLocation1,
        "Job Title": jobTitle,
        "Operation Type": operationType,
        "Initials": initials,
        "Search Name": searchName,
        "Address": address,
        "Address 2": address2,
        "Post Code": postCode,
        "Phone No_": phoneNo,
        "Mobile Phone No_": mobilePhoneNo,
        "E-Mail": eMail,
        "Extension": extension,
        "Country": country,
        "Birth Date": birthDate,
        "Age": age,
        "Gender": gender,
        "Inactive Date": inactiveDate,
        "Cause of Inactivity Code": causeOfInactivityCode,
        "Termination Date": terminationDate,
        "Grounds for Term_ Code": groundsForTermCode,
        "Global Dimension 1 Code": globalDimension1Code,
        "Global Dimension 2 Code": globalDimension2Code,
        "Last Date Modified": lastDateModified,
        "No_ Series": noSeries,
        "Marital Status": maritalStatus,
        "Spouse Name": spouseName,
        "Wedding Date": weddingDate,
        "No_ Of Children": noOfChildren,
        "Driving License No_": drivingLicenseNo,
        "Father_Husband": fatherHusband,
        "Blood Group": bloodGroup,
        "Payment Method": paymentMethod,
        "Resignation Date": resignationDate,
        "Confirmation Date": confirmationDate,
        "Experience": experience,
        "Release Status": releaseStatus,
        "Blocked": blocked,
        "Attendance Not Generated": attendanceNotGenerated,
        "OT Applicable": otApplicable,
        "OT Normal Rate": otNormalRate,
        "Leaves Not Generated": leavesNotGenerated,
        "Blocked Date": blockedDate,
        "User Id": userId,
        "Stop Payment": stopPayment,
        "Place of Birth": placeOfBirth,
        "Nationality Country": nationalityCountry,
        "Probn_Duration": probnDuration,
        "Prob Leaves Added": probLeavesAdded,
        "Emirates ID No_": emiratesIdNo,
        "Emirates ID Expiry Date": emiratesIdExpiryDate,
        "Insurance Company Name": insuranceCompanyName,
        "Insurance No_": insuranceNo,
        "Insurance Card Expiry Date": insuranceCardExpiryDate,
        "Home Country Number": homeCountryNumber,
        "Employee A_C With Agent": employeeACWithAgent,
        "First Name (Arabic)": firstNameArabic,
        "Middle Name (Arabic)": middleNameArabic,
        "Last Name (Arabic)": lastNameArabic,
        "Haj leave Applicable": hajLeaveApplicable,
        "Passport Number": passportNumber,
        "Passport Expiry Date": passportExpiryDate,
        "Passpost Retention Required": passpostRetentionRequired,
        "Passport Obtained": passportObtained,
        "Passport Released": passportReleased,
        "Maternity Applicable": maternityApplicable,
        "Passport Issue Date": passportIssueDate,
        "Visa Sponsorsed by": visaSponsorsedBy,
        "Visa Expiry Date": visaExpiryDate,
        "Labor Card Status": laborCardStatus,
        "Labor Expiry Date": laborExpiryDate,
        "Labour Card Number": labourCardNumber,
        "Probation End Date": probationEndDate,
        "Employment End Date": employmentEndDate,
        "Job Status": jobStatus,
        "Employee Unique ID": employeeUniqueId,
        "Employee IBAN No": employeeIbanNo,
        "Employee Bank Name": employeeBankName,
        "Employee Branch Name": employeeBranchName,
        "Probation Review Date": probationReviewDate,
        "Probation Extended For": probationExtendedFor,
        "Visa Category": visaCategory,
        "Visa No_": visaNo,
        "Employee Account No_": employeeAccountNo,
        "Employee Bank Code": employeeBankCode,
        "Employee Bank ID": employeeBankId,
        "Airfare Allowance": airfareAllowance,
        "Nominee Contact No_": nomineeContactNo,
        "SWIFT": swift,
        "Routing no_": routingNo,
        "Personal Email": personalEmail,
        "Home Country Airport": homeCountryAirport,
        "OT Holiday Rate": otHolidayRate,
        "Middle Name": middleName,
        "No_ Of Children1": noOfChildren1,
      };
}
