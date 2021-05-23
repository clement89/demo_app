import 'package:demo_app/business_logic/view_models/home_viewmodel.dart';
import 'package:demo_app/ui/theme/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _homeViewModel = Provider.of<HomeViewModel>(context, listen: false);
    _homeViewModel.loadData();
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
            child: SfCircularChart(
              title: ChartTitle(
                text: 'Fruit Vitamin analysis',
                textStyle: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: red,
                  letterSpacing: 0.5,
                ),
              ),
              legend: Legend(isVisible: true),
              series: <CircularSeries>[
                // Render pie chart
                PieSeries<ChartData, String>(
                    dataSource: [
                      // Bind data source
                      ChartData('Jan', 35),
                      ChartData('Feb', 28),
                      ChartData('Mar', 34),
                      ChartData('Apr', 32),
                      ChartData('May', 40)
                    ],
                    xValueMapper: (ChartData data, _) => data.x,
                    yValueMapper: (ChartData data, _) => data.y)
              ],
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
            onTap: () {},
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

class ChartData {
  ChartData(this.x, this.y, [this.color]);
  final String x;
  final double y;
  final Color color;
}
