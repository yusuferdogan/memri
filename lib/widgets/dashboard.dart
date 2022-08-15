import 'package:flutter/material.dart';
import 'package:memri_web/model/user_commits.dart';
import 'dart:math' as math;
import 'package:charts_flutter/flutter.dart' as charts;

class Dashboard extends StatelessWidget {
  final User user;
  const Dashboard({required this.user, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final repo = user.repo();
    List<Color> colorList = [];
    for (int i = 0; i < repo.length; ++i) {
      colorList.add(Color((math.Random().nextDouble() *
                  math.Random().nextDouble() *
                  0xFFFFFF)
              .toInt())
          .withOpacity(0.9));
    }
    return Scaffold(
        body: GridView.count(
      crossAxisCount: 2,
      childAspectRatio: 5 / 3,
      children: [
        Container(
          decoration: BoxDecoration(border: Border.all()),
          margin:
              const EdgeInsets.only(top: 10, left: 50, right: 50, bottom: 150),
          child: Stack(
            children: [
              charts.BarChart([
                charts.Series<Histogram, String>(
                    id: 'hourly',
                    colorFn: (_, __) =>
                        charts.MaterialPalette.blue.shadeDefault,
                    domainFn: (Histogram histogram, _) =>
                        int.parse(histogram.label) < 10
                            ? '0${histogram.label}:00'
                            : '${histogram.label}:00',
                    measureFn: (Histogram histogram, _) => histogram.value,
                    data: user.hourlyCommit())
              ])
            ],
          ),
        ),
        Container(
          decoration: BoxDecoration(border: Border.all()),
          margin:
              const EdgeInsets.only(top: 10, left: 50, right: 50, bottom: 150),
          child: Stack(
            children: [
              charts.BarChart([
                charts.Series<Histogram, String>(
                    id: 'hourly',
                    colorFn: (_, __) =>
                        charts.MaterialPalette.blue.shadeDefault,
                    domainFn: (Histogram histogram, _) => histogram.label,
                    measureFn: (Histogram histogram, _) => histogram.value,
                    data: user.dailyCommit())
              ])
            ],
          ),
        ),
        charts.PieChart([
          charts.Series<Histogram, String>(
              id: 'hourly',
              colorFn: (_, index) {
                return charts.ColorUtil.fromDartColor(colorList[index!]);
              },
              domainFn: (Histogram histogram, _) => histogram.label,
              measureFn: (Histogram histogram, _) => histogram.value,
              data: repo)
        ]),
        ListView.builder(
          itemCount: repo.length,
          itemBuilder: ((context, index) {
            return Row(
              children: [
                Container(
                  width: 50,
                  height: 20,
                  margin: const EdgeInsets.only(bottom: 5),
                  decoration: BoxDecoration(color: colorList[index]),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(repo[index].label.split('/')[1])
              ],
            );
          }),
        ),
      ],
    ));
  }
}
