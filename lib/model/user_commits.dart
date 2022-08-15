class Commit {
  String repo;
  String date;

  Commit(this.repo, this.date);

  factory Commit.fromMap(Map<String, dynamic> map) {
    return Commit(map['repo'], map['date']);
  }

  Map<String, dynamic> toMap() {
    return {'repo': repo, 'date': date};
  }
}

class User {
  String author;
  List<Commit> commits;

  User(this.author, this.commits);

  factory User.fromMap(Map<String, dynamic> map) {
    return User(map['author'],
        map['commits'].map((e) => Commit.fromMap(e)).toList().cast<Commit>());
  }

  Map<String, dynamic> toMap() {
    return {
      'author': author,
      'commits': commits.map((e) => e.toMap()).toList()
    };
  }

  List<Histogram> hourlyCommit() {
    List<int> hours = List.filled(24, 0);
    List<Histogram> histograms = [];
    for (var commit in commits) {
      DateTime date = DateTime.parse(commit.date);
      hours[date.hour]++;
    }
    for (int i = 0; i < hours.length; ++i) {
      histograms.add(Histogram(i.toString(), hours[i]));
    }
    return histograms;
  }

  List<Histogram> dailyCommit() {
    List<int> week = List.filled(7, 0);
    List<String> dayOfWeek = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];
    List<Histogram> histograms = [];
    for (var commit in commits) {
      DateTime date = DateTime.parse(commit.date);

      week[date.weekday - 1]++;
    }

    for (int i = 0; i < week.length; ++i) {
      histograms.add(Histogram(dayOfWeek[i], week[i]));
    }
    return histograms;
  }

  List<Histogram> repo() {
    List<Histogram> histograms = [];
    Map<String, int> map = <String, int>{};
    for (var repo in commits) {
      if (!map.containsKey(repo.repo)) {
        map[repo.repo] = 1;
      } else {
        int val = map[repo.repo]!;
        val++;
        map[repo.repo] = val;
      }
    }

    for (var item in map.keys) {
      histograms.add(Histogram(item, map[item]!));
    }
    return histograms;
  }
}

class Histogram {
  final String label;
  final int value;

  Histogram(this.label, this.value);
}
