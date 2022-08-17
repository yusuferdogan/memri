import 'dart:io';

import 'package:memri_web/model/user_commits.dart';
import 'package:memri_web/services/console_client.dart';
import 'package:memri_web/services/server.dart';

void main(List<String> arguments) async {
  if (arguments.isEmpty) {
    stdout.writeln("Invalid usage");
    return;
  }

  ConsoleClient client = ConsoleClient();
  List<User> userList = [];
  for (var item in arguments) {
    var result = await client.fetchCommits(item);
    userList.add(result);
  }
  _writerConsole(userList);
  stdout.write("Would you like to see data? Y/n ");
  final input = stdin.readLineSync();
  if (input!.toLowerCase() == 'y') {
    await httpServer(userList);

    stdout.write("Opening the web api. Please wait");
    await Process.run("flutter", ["run", "-d", "chrome", "--web-port", "8000"]);
  }
}

void _writerConsole(List<User> userList) {
  for (var item in userList) {
    var repos = item.repo();
    for (var repo in repos) {
      stdout.writeln('${item.author}/${repo.label}: ${repo.value}');
    }
  }
}
