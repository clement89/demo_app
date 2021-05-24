import 'package:demo_app/business_logic/utils/chart_data.dart';
import 'package:demo_app/business_logic/view_models/home_viewmodel.dart';
import 'package:demo_app/ui/pages/fruit_list_page.dart';
import 'package:demo_app/ui/theme/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _homeViewModel = Provider.of<HomeViewModel>(context, listen: false);
    _homeViewModel.loadData();
    var size = MediaQuery.of(context).size;
    return Consumer<HomeViewModel>(
      builder: (context, viewModel, child) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 15),
        child: viewModel.selectedFruit == null
            ? Container()
            : Column(
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
                            dataSource: _dataSource(viewModel),
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
                              viewModel.selectedFruit.name.toUpperCase(),
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
      ),
    );
  }
}

List<ChartData> _dataSource(HomeViewModel viewModel) {
  List<ChartData> dataList = [];
  viewModel.selectedFruit.vitamins.forEach((vitamin) {
    dataList.add(ChartData(vitamin.name, vitamin.value.toDouble()));
  });
  return dataList;
}
