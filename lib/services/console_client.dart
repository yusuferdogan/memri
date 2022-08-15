import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:memri_web/model/events.dart';
import 'package:memri_web/model/user_commits.dart';


class ConsoleClient {
  final String _url = "https://api.github.com/users";
  final String _api = "events";
  final String _query = "per_page=100";
  final String _token = "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";

  /// Returns the User object of the given [userName]
  ///
  ///   fetchCommits('yusuferdogan') == Instance of User
  Future<User> fetchCommits(String userName) async {
    int pageCount = 3; // Github API limitied to 3 pages.
    List<Events> eventList = [];
    Map<String, int> repoMap = <String, int>{};
    for (int i = 1; i <= pageCount; ++i) {
      try {
        http.Response response = await http
            .get(Uri.parse("$_url/$userName/$_api?$_query&page=$i"), headers: {
          'Content-Type': 'application/json',
          "Accept": "application/vnd.github+json",
          'Authorization': 'Bearer $_token',
        });
        var jsonBody = jsonDecode(response.body);
        List<Events> event =
            jsonBody.map((e) => Events.fromJson(e)).toList().cast<Events>();
        eventList.addAll(event);
      } catch (e) {
        break;
      }
    }

    var pushhEvents = eventList
        .where((element) => element.type == "PushEvent")
        .toList(); //Filter the Push Events
    List<Commit> commitList = [];
    for (var item in pushhEvents) {
      String name = item.repo!.name!;
      if (!repoMap.containsKey(name)) {
        repoMap[name] = 1;
      } else {
        int val = repoMap[name]!;
        val++;
        repoMap[name] = val;
      }
      commitList.add(Commit(item.repo!.name!, item.createdAt!));
    }
    User usr = User(userName, commitList);
    return usr;
  }
}
