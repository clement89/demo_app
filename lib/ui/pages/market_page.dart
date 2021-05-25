import 'package:demo_app/business_logic/models/sales.dart';
import 'package:demo_app/business_logic/utils/chart_data.dart';
import 'package:demo_app/business_logic/view_models/home_viewmodel.dart';
import 'package:demo_app/ui/theme/colors.dart';
import 'package:demo_app/ui/widgets/bottom_cell.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class MarketPage extends StatelessWidget {
  const MarketPage({Key key}) : super(key: key);

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
                      height: size.height * 0.6, child: _buildChart(viewModel)),
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
    return SfCartesianChart(
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
        series: _buildSales(viewModel));
  }

  List<CartesianSeries> _buildSales(HomeViewModel viewModel) {
    List<CartesianSeries> salesList = [];
    salesList.add(
      ColumnSeries<ChartData, String>(
          name: 'Sales',
          dataSource: _dataSource(viewModel.selectedFruit.sales),
          xValueMapper: (ChartData data, _) => data.x,
          yValueMapper: (ChartData data, _) => data.y),
    );
    salesList.add(
      ColumnSeries<ChartData, String>(
          name: 'Availability',
          dataSource: _dataSource(viewModel.selectedFruit.availabilities),
          xValueMapper: (ChartData data, _) => data.x,
          yValueMapper: (ChartData data, _) => data.y),
    );
    return salesList;
  }

  List<ChartData> _dataSource(List<Data> sales) {
    List<ChartData> dataList = [];
    sales.forEach((sales) {
      dataList.add(ChartData(sales.month, sales.value.toDouble()));
    });
    return dataList;
  }
}
