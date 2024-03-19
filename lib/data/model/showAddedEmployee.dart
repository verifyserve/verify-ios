class ShowAddedEmployee {
  int? eeid;
  String? employeeImage;
  String? employeeName;
  String? employeeJoiningdate;
  String? employeeSalary;
  String? employeeWork;
  String? employeeAbout;
  String? employeeMobile;
  String? employeeEmail;
  String? employeeAddress;
  String? uuserId;
  String? employeeType;

  ShowAddedEmployee(
      {this.eeid,
        this.employeeImage,
        this.employeeName,
        this.employeeJoiningdate,
        this.employeeSalary,
        this.employeeWork,
        this.employeeAbout,
        this.employeeMobile,
        this.employeeEmail,
        this.employeeAddress,
        this.uuserId,
        this.employeeType});

  ShowAddedEmployee.fromJson(Map<String, dynamic> json) {
    eeid = json['eeid'];
    employeeImage = json['Employee_image'];
    employeeName = json['Employee_name'];
    employeeJoiningdate = json['Employee_joiningdate'];
    employeeSalary = json['Employee_salary'];
    employeeWork = json['Employee_work'];
    employeeAbout = json['Employee_About'];
    employeeMobile = json['Employee_mobile'];
    employeeEmail = json['Employee_email'];
    employeeAddress = json['Employee_address'];
    uuserId = json['Employee_userid'];
    employeeType = json['Employee_Type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['eeid'] = this.eeid;
    data['Employee_image'] = this.employeeImage;
    data['Employee_name'] = this.employeeName;
    data['Employee_joiningdate'] = this.employeeJoiningdate;
    data['Employee_Salary'] = this.employeeSalary;
    data['Employee_work'] = this.employeeWork;
    data['Employee_About'] = this.employeeAbout;
    data['Employee_mobile'] = this.employeeMobile;
    data['Employee_email'] = this.employeeEmail;
    data['Employee_address'] = this.employeeAddress;
    data['Uuser_id'] = this.uuserId;
    data['Employee_type'] = this.employeeType;
    return data;
  }
}