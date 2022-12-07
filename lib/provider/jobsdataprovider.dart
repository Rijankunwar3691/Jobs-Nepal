import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/cupertino.dart';

import '../model/jobsmodel.dart';

class JobsDataProvider with ChangeNotifier {
  List<JobsModel> allJobs = [];
  late JobsModel jobsModel;
  Future<void> getJobsData() async {
    List<JobsModel> newList = [];

    QuerySnapshot data =
        await FirebaseFirestore.instance.collection('Jobs').get();
    data.docs.forEach((element) {
      jobsModel = JobsModel(
          companyname: element.get('companyname'),
          jobDescription: element.get('JobDescription'),
          jobTitle: element.get('JobTitle'),
          jobcategory: element.get('Jobcategory'),
          applicants: element.get('applicants'),
          // createdAt: element.get('createdAt'),
          deadlineDate: element.get('deadlineDate'),
          // deadlineDateTimeStamp: element.get('deadlineDateTimeStamp'),
          jobId: element.get('jobId'),
          requirement: element.get('requirement'));
      return newList.add(jobsModel);
    });
    allJobs = newList;
    notifyListeners();
  }

  List<JobsModel> get getjobsDatalist {
    return allJobs;
  }
}
