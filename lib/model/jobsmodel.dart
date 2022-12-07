class JobsModel {
  final String jobTitle;
  final String jobDescription;
  final String deadlineDate;
  final String jobcategory;
  //final DateTime createdAt;
  final int applicants;
  final String jobId;
  // final DateTime deadlineDateTimeStamp;
  final bool requirement;
  final String companyname;
  JobsModel(
      {required this.jobDescription,
      required this.companyname,
      required this.jobTitle,
      required this.jobcategory,
      required this.applicants,
      //  required this.createdAt,
      required this.deadlineDate,
      //  required this.deadlineDateTimeStamp,
      required this.jobId,
      required this.requirement});
}
