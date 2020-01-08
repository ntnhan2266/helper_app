import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import '../services/category.dart';

class StatisticScreen extends StatefulWidget {
  @override
  _StatisticScreenState createState() => _StatisticScreenState();
}

class _StatisticScreenState extends State<StatisticScreen> {
  List<charts.Series> _seriesList = [];

  @override
  void initState() {
    super.initState();

    _getStatistic();
  }

  void _getStatistic() async {
    final res = await CategoryService.getStatisticCategories();
    if (res['isValid'] && mounted) {
      List<CategoryCount> categoryCount = [];
      for (var statistic in res['statistic']) {
        categoryCount.add(new CategoryCount(
          statistic['category']['nameVi'],
          statistic['count'],
        ));
      }
      setState(() {
        _seriesList = [
          new charts.Series<CategoryCount, String>(
            id: 'Category',
            domainFn: (CategoryCount categoryCount, _) =>
                categoryCount.category,
            measureFn: (CategoryCount categoryCount, _) => categoryCount.count,
            data: categoryCount,
          )
        ];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Localization
    var data = EasyLocalizationProvider.of(context).data;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          AppLocalizations.of(context).tr('statistic'),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(50),
        child: _seriesList.isEmpty
            ? Container()
            : charts.PieChart(
                _seriesList,
                animate: true,
                behaviors: [
                  new charts.DatumLegend(
                    position: charts.BehaviorPosition.bottom,
                    outsideJustification:
                        charts.OutsideJustification.middleDrawArea,
                    desiredMaxColumns: 1,
                    cellPadding: new EdgeInsets.only(left: 40.0, bottom: 10.0),
                    showMeasures: true,
                    legendDefaultMeasure:
                        charts.LegendDefaultMeasure.firstValue,
                    measureFormatter: (num value) {
                      return value == null ? '-' : '$value times';
                    },
                    entryTextStyle: charts.TextStyleSpec(
                      color: charts.MaterialPalette.blue.shadeDefault,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

class CategoryCount {
  final String category;
  final int count;

  CategoryCount(this.category, this.count);
}
