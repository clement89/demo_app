import 'package:demo_app/business_logic/models/sales.dart';
import 'package:demo_app/business_logic/utils/chart_data.dart';
import 'package:demo_app/business_logic/view_models/home_viewmodel.dart';
import 'package:demo_app/ui/theme/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ComparePage extends StatelessWidget {
  const ComparePage({Key key}) : super(key: key);

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
                ],
              ),
      ),
    );
  }

  _buildChart(HomeViewModel viewModel) {
    return SfCartesianChart(
        // Enables the legend
        title: ChartTitle(
          text: 'Fruit sales analysis',
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
        series: _buildSales(viewModel));
  }

  List<CartesianSeries> _buildSales(HomeViewModel viewModel) {
    List<CartesianSeries> salesList = [];
    viewModel.fruitList.forEach((element) {
      salesList.add(
        LineSeries<ChartData, String>(
            name: element.name,
            dataSource: _dataSource(element.sales),
            xValueMapper: (ChartData data, _) => data.x,
            yValueMapper: (ChartData data, _) => data.y),
      );
    });
    return salesList;
  }

  List<ChartData> _dataSource(List<Sales> sales) {
    List<ChartData> dataList = [];
    sales.forEach((sales) {
      dataList.add(ChartData(sales.month, sales.value.toDouble()));
    });
    return dataList;
  }
}
