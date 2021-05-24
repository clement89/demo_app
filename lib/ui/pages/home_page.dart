import 'package:demo_app/business_logic/utils/chart_data.dart';
import 'package:demo_app/business_logic/view_models/home_viewmodel.dart';
import 'package:demo_app/ui/theme/colors.dart';
import 'package:demo_app/ui/widgets/bottom_cell.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                    child: _buildChart(viewModel),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  BottomCell(name: viewModel.selectedFruit.name)
                ],
              ),
      ),
    );
  }

  _buildChart(HomeViewModel viewModel) {
    return SfCircularChart(
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
    );
  }

  List<ChartData> _dataSource(HomeViewModel viewModel) {
    List<ChartData> dataList = [];
    viewModel.selectedFruit.vitamins.forEach((vitamin) {
      dataList.add(ChartData(vitamin.name, vitamin.value.toDouble()));
    });
    return dataList;
  }
}
