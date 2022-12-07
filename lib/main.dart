import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:jobsnepal/provider/jobsdataprovider.dart';
import 'package:jobsnepal/screen/hompage.dart';
import 'package:provider/provider.dart';

import 'Authentication/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    const JobsNepal(),
  );
}

class JobsNepal extends StatelessWidget {
  const JobsNepal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<JobsDataProvider>(
            create: (context) => JobsDataProvider(),
          ),
        ],
        child: MaterialApp(
          title: 'Jobs Nepal',
          home: StreamBuilder(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return HomePage();
                } else {
                  return const LoginPage();
                }
              }),
          debugShowCheckedModeBanner: false,
        ));
  }
}
