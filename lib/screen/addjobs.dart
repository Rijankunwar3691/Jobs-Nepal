import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:uuid/uuid.dart';

import 'hompage.dart';

class AddJobsPage extends StatefulWidget {
  AddJobsPage({Key? key}) : super(key: key);

  @override
  State<AddJobsPage> createState() => _AddJobsPageState();
}

class _AddJobsPageState extends State<AddJobsPage> {
  TextEditingController jobcategory = TextEditingController();

  TextEditingController jobtitle = TextEditingController();

  TextEditingController jobdescription = TextEditingController();
  TextEditingController companyName = TextEditingController();
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  String dropdownvalue = 'Select Category';
  var items = [
    'Select Category',
    'Flutter Developer',
    'Doctor',
    'Web Developer',
    'Network Engineer',
  ];
  bool isloading = false;
  final TextEditingController _deadlineDateController =
      TextEditingController(text: 'Job Deadline Date');
  DateTime? picked;

  Timestamp? deadlineDateTimeStamp;

  TextEditingController intialdateval = TextEditingController();

  void _pickDateDialog() async {
    picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(
        const Duration(days: 0),
      ),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        _deadlineDateController.text =
            '${picked!.year}- ${picked!.month} - ${picked!.day}';
        deadlineDateTimeStamp = Timestamp.fromMicrosecondsSinceEpoch(
            picked!.microsecondsSinceEpoch);
      });
    }
  }

  void validate() async {
    if (formkey.currentState!.validate()) {
      final jodId = const Uuid().v4();
      if (dropdownvalue == 'Select Category') {
        Fluttertoast.showToast(
            msg: 'please fill all fields',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.black45,
            textColor: Colors.white,
            fontSize: 16.0);
      } else {
        isloading = true;
        await FirebaseFirestore.instance.collection("Jobs").doc(jodId).set({
          'jobId': jodId,
          'Jobcategory': dropdownvalue,
          'JobTitle': jobtitle.text,
          'JobDescription': jobdescription.text,
          'deadlineDate': _deadlineDateController.text,
          'deadlineDateTimeStamp': deadlineDateTimeStamp,
          'requirement': true,
          'createdAt': Timestamp.now(),
          'applicants': 0,
          'companyname': companyName.text,
        }).then((value) async {
          isloading = false;
          Fluttertoast.showToast(
              msg: 'Job Posted.',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.black45,
              textColor: Colors.white,
              fontSize: 16.0);
          jobtitle.clear();
          jobdescription.clear();
          _deadlineDateController.clear();
          companyName.clear();
          setState(() {
            dropdownvalue = 'Select Category';
          });
        });
      }
    }
  }

  Widget _customtext(String text) {
    return Text(
      text,
      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    );
  }

  Widget _customtextfield(
      String hintext, TextEditingController controller, String errormsg) {
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return errormsg;
        }
        return null;
      },
      controller: controller,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        hintText: hintext,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    jobdescription.dispose();
    jobtitle.dispose();
    jobcategory.dispose();
    companyName.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomePage(),
                  ));
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
        centerTitle: true,
        backgroundColor: Colors.grey[400],
        title: const Text(
          "Add Details",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Form(
            key: formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(
                  child: Text(
                    'Please fill all the details',
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Lobster'),
                  ),
                ),
                const Divider(
                  height: 40,
                ),
                const SizedBox(
                  height: 8,
                ),
                _customtext('Job Title : '),
                const SizedBox(
                  height: 8,
                ),
                _customtextfield(
                    'Job Title', jobtitle, 'Please Enter Job Title'),
                const SizedBox(
                  height: 8,
                ),
                _customtext('Job Description : '),
                const SizedBox(
                  height: 8,
                ),
                TextFormField(
                  controller: jobdescription,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter description';
                    } else if (value.length < 10) {
                      return 'Please Enter at leat 10 digits';
                    }
                    return null;
                  },
                  maxLines: null, // allow user to enter 5 line in textfield
                  keyboardType: TextInputType.text,
                  maxLength: 100,
                  textAlignVertical: TextAlignVertical.top,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.only(bottom: 80, top: 10),
                    border: OutlineInputBorder(),
                    hintText: 'Job Description',
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                _customtext('Company Name : '),
                const SizedBox(
                  height: 8,
                ),
                _customtextfield(
                    'Company Name', companyName, 'Please Enter Company Name'),
                const SizedBox(
                  height: 8,
                ),
                _customtext('Deadline Date : '),
                const SizedBox(
                  height: 8,
                ),
                TextFormField(
                    controller: _deadlineDateController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Select Date';
                      }
                      return null;
                    },
                    onTap: () {
                      // Below line stops keyboard from appearing
                      FocusScope.of(context).requestFocus(new FocusNode());
                      _pickDateDialog();
                      // Show Date Picker Here
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Select date',
                    )),
                const SizedBox(
                  height: 8,
                ),
                _customtext('Job Category : '),
                const SizedBox(
                  height: 8,
                ),
                DropdownButton(
                  // Initial Value
                  value: dropdownvalue,

                  // Down Arrow Icon
                  icon: const Icon(Icons.keyboard_arrow_down),

                  // Array list of items
                  items: items.map((String items) {
                    return DropdownMenuItem(
                      value: items,
                      child: Text(items),
                    );
                  }).toList(),
                  // After selecting the desired option,it will
                  // change button value to selected value
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownvalue = newValue!;
                    });
                  },
                ),
                Center(
                  child: ElevatedButton(
                      onPressed: () {
                        //navigates to signup page------
                        validate();
                      }, //validate,
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0))),
                      child: isloading == false
                          ? const Text(
                              "Post",
                              style:
                                  TextStyle(letterSpacing: 1.0, fontSize: 20),
                            )
                          : const Center(
                              child: CircularProgressIndicator(),
                            )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
