import 'package:flutter/cupertino.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class SalesPage extends StatelessWidget {
  const SalesPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      child: Center(
          child: Container(
              child: SfCartesianChart(
                  // Enables the legend
                  legend: Legend(isVisible: true),
                  // Initialize category axis
                  primaryXAxis: CategoryAxis(),
                  series: <ChartSeries>[
            // Initialize line series
            LineSeries<SalesData, String>(
              dataSource: [
                // Bind data source
                SalesData('Jan', 35),
                SalesData('Feb', 28),
                SalesData('Mar', 34),
                SalesData('Apr', 32),
                SalesData('May', 40)
              ],
              xValueMapper: (SalesData sales, _) => sales.year,
              yValueMapper: (SalesData sales, _) => sales.sales,
            )
          ]))),
    );
  }
}

class SalesData {
  SalesData(this.year, this.sales);
  final String year;
  final double sales;
}
