import 'package:flutter/material.dart';

class JobWidget extends StatelessWidget {
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
  const JobWidget(
      {Key? key,
      required this.companyname,
      required this.jobDescription,
      required this.jobTitle,
      required this.jobcategory,
      required this.applicants,
      //  required this.createdAt,
      required this.deadlineDate,
      //  required this.deadlineDateTimeStamp,
      required this.jobId,
      required this.requirement})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white24,
      elevation: 8,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        leading: Container(
          padding: const EdgeInsets.only(right: 12),
          decoration: const BoxDecoration(
            border: Border(
              right: BorderSide(width: 1.0),
            ),
          ),
          child: Image.network(
              'https://res.cloudinary.com/crunchbase-production/image/upload/c_lpad,f_auto,q_auto:eco,dpr_1/s1cihnpc1cnekihotv0e'),
        ),
        title: Text(
          jobTitle,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            color: Colors.amberAccent,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              companyname,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.blueGrey,
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              jobDescription,
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 15,
              ),
            ),
          ],
        ),
        trailing: const Icon(
          Icons.keyboard_arrow_right,
          size: 30,
          color: Colors.black,
        ),
      ),
    );
  }
}
