class EmployeeDetail {
  int? eeid;
  String? employeeName;
  String? employeeJoiningdate;
  String? employeeSalary;
  String? employeeWork;
  String? employeeAbout;
  String? employeeMobile;
  String? employeeEmail;
  String? employeeAddress;
  String? employeeUserid;
  String? employeeType;

  EmployeeDetail(
      {this.eeid,
        this.employeeName,
        this.employeeJoiningdate,
        this.employeeSalary,
        this.employeeWork,
        this.employeeAbout,
        this.employeeMobile,
        this.employeeEmail,
        this.employeeAddress,
        this.employeeUserid,
        this.employeeType});

  EmployeeDetail.fromJson(Map<String, dynamic> json) {
    eeid = json['eeid'];
    employeeName = json['Employee_name'];
    employeeJoiningdate = json['Employee_joiningdate'];
    employeeSalary = json['Employee_salary'];
    employeeWork = json['Employee_work'];
    employeeAbout = json['Employee_about'];
    employeeMobile = json['Employee_Mobile'];
    employeeEmail = json['Employee_email'];
    employeeAddress = json['Employee_address'];
    employeeUserid = json['Employee_userid'];
    employeeType = json['Employee_Type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['eeid'] = this.eeid;
    data['Employee_name'] = this.employeeName;
    data['Employee_joiningdate'] = this.employeeJoiningdate;
    data['Employee_salary'] = this.employeeSalary;
    data['Employee_work'] = this.employeeWork;
    data['Employee_about'] = this.employeeAbout;
    data['Employee_Mobile'] = this.employeeMobile;
    data['Employee_email'] = this.employeeEmail;
    data['Employee_address'] = this.employeeAddress;
    data['Employee_userid'] = this.employeeUserid;
    data['Employee_Type'] = this.employeeType;
    return data;
  }
}