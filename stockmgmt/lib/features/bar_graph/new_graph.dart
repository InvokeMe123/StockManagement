import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stockmgmt/const/app_color_const.dart';
import 'package:stockmgmt/features/bar_graph/model/sales_model.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class BarGraph extends ConsumerWidget {
  const BarGraph({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SfCartesianChart(
      primaryXAxis: CategoryAxis(),
      series: <CartesianSeries>[
        ColumnSeries<SalesData, String>(
          pointColorMapper: (SalesData sales, _) {
            // Change the color to red if sales data is less than 10
            return sales.sales < 10 ? Colors.red : Colors.green;
          },
          borderRadius: BorderRadius.circular(12),
          dataSource: <SalesData>[
            SalesData('Jan', 35),
            SalesData('Feb', 5),
            SalesData('Mar', 34),
            SalesData('Apr', 32),
            SalesData('May', 35),
            SalesData('Jun', 7),
            SalesData('Jul', 12),
            SalesData('Aug', 10),
            SalesData('Sep', 35),
            SalesData('Oct', 7),
            SalesData('Nov', 12),
            SalesData('Dec', 10),
          ],
          xValueMapper: (SalesData sales, _) => sales.month,
          yValueMapper: (SalesData sales, _) => sales.sales,
        )
      ],
    );
  }
}
