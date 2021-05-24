import 'package:demo_app/business_logic/utils/chart_data.dart';
import 'package:demo_app/ui/theme/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'fruit_list_page.dart';

class MarketPage extends StatelessWidget {
  const MarketPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 15),
      child: Column(
        children: [
          SizedBox(
            height: size.height * 0.02,
          ),
          Container(
            height: size.height * 0.6,
            child: Center(
              child: Container(
                child: SfCartesianChart(
                    // Enables the legend
                    title: ChartTitle(
                      text: 'Fruit sales and market analysis',
                      textStyle: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: red,
                        letterSpacing: 0.5,
                      ),
                    ),
                    legend: Legend(
                      isVisible: true,
                      borderColor: Colors.black26,
                      borderWidth: 2,
                    ),
                    // Initialize category axis
                    primaryXAxis: CategoryAxis(),
                    series: <CartesianSeries>[
                      ColumnSeries<ChartData, String>(
                          dataSource: [
                            ChartData('Jan', 35),
                            ChartData('Feb', 28),
                            ChartData('Mar', 34),
                            ChartData('Apr', 32),
                            ChartData('May', 40)
                          ],
                          xValueMapper: (ChartData data, _) => data.x,
                          yValueMapper: (ChartData data, _) => data.y),
                      ColumnSeries<ChartData, String>(
                          dataSource: [
                            ChartData('Jan', 12),
                            ChartData('Feb', 33),
                            ChartData('Mar', 44),
                            ChartData('Apr', 56),
                            ChartData('May', 23)
                          ],
                          xValueMapper: (ChartData data, _) => data.x,
                          yValueMapper: (ChartData data, _) => data.y),
                    ]),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'SHOWING DETAILS OF',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12,
                color: Colors.black54,
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FruitListPage(),
                ),
              );
            },
            child: Container(
              height: 60,
              decoration: BoxDecoration(
                color: lightBlue,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Color(0XFFf8f1f1),
                    blurRadius:
                        2, // was 0.5 -- has the effect of softening the shadow
                  )
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'ORANGE',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: red,
                      ),
                    ),
                    const Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                      color: Colors.black54,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
