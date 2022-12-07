import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:jobsnepal/provider/jobsdataprovider.dart';
import 'package:jobsnepal/widgets/curvednaviagtionbar.dart';
import 'package:jobsnepal/widgets/jobs_widget.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  int _page = 0;
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  late JobsDataProvider jobsDataProvider;
  @override
  Widget build(BuildContext context) {
    jobsDataProvider = Provider.of(context);
    jobsDataProvider.getJobsData();
    return Scaffold(
      backgroundColor: Colors.grey[200],
      bottomNavigationBar: MyCurvedNavigationBar(
        indexnum: 0,
      ),
      appBar: AppBar(
        backgroundColor: Colors.grey[400],
        title: const Text(
          "Jobs Nepal",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              print(jobsDataProvider.getjobsDatalist.length);
            },
            icon: const Icon(
              Icons.menu,
              color: Colors.black,
            )),
      ),
      body: ListView(
          children: jobsDataProvider.getjobsDatalist.map((e) {
        if (jobsDataProvider.getjobsDatalist.isEmpty) {
          return CircularProgressIndicator();
        } else {
          return JobWidget(
              companyname: e.companyname,
              jobDescription: e.jobDescription,
              jobTitle: e.jobTitle,
              jobcategory: e.jobcategory,
              applicants: e.applicants,
              deadlineDate: e.deadlineDate,
              jobId: e.jobId,
              requirement: e.requirement);
        }
      }).toList()),
    );
  }
}
