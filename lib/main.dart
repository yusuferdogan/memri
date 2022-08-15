import 'package:flutter/material.dart';
import 'package:memri_web/model/user_commits.dart';
import 'package:memri_web/services/client.dart';
import 'package:memri_web/widgets/dashboard.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: _body());
  }

  Widget _body() {
    final client = Client();

    return FutureBuilder<List<User>>(
      future: client.fetchUsers(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else {
          return DefaultTabController(
              length: snapshot.data!.length,
              child: Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.white,
                  bottom: TabBar(
                    labelColor: Colors.black,
                    labelStyle: const TextStyle(fontWeight: FontWeight.bold),
                    tabs: snapshot.data!
                        .map((e) => Tab(
                              child: Text(e.author),
                            ))
                        .toList(),
                  ),
                ),
                body: TabBarView(
                  children:
                      snapshot.data!.map((e) => Dashboard(user: e)).toList(),
                ),
              ));
        }
      },
    );
  }
}
