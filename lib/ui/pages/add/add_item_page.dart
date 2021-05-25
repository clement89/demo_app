import 'package:demo_app/business_logic/models/sales.dart';
import 'package:demo_app/business_logic/models/vitamins.dart';
import 'package:demo_app/business_logic/view_models/add_item_viewmodel.dart';
import 'package:demo_app/ui/pages/add/add_data_page.dart';
import 'package:demo_app/ui/pages/add/add_vitamin_page.dart';
import 'package:demo_app/ui/theme/colors.dart';
import 'package:demo_app/ui/widgets/add_button.dart';
import 'package:demo_app/ui/widgets/filled_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';

class AddItemPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final _viewModel = Provider.of<AddItemViewModel>(context, listen: false);

    _viewModel.initialize();
    return Scaffold(
      backgroundColor: lightBlue,
      appBar: _buildAppBar(context),
      body: SafeArea(
        child: Consumer<AddItemViewModel>(
          builder: (context, viewModel, child) => ModalProgressHUD(
            inAsyncCall: viewModel.isLoading,
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    // Add TextFormFields and ElevatedButton here.
                    SizedBox(
                      height: 10,
                    ),
                    _buildTextField(
                      title: 'NAME',
                      hintText: 'Enter name of the fruit',
                      onSave: (var value) {
                        _viewModel.fruit.name = value.toString();
                      },
                      isDouble: false,
                      viewModel: _viewModel,
                    ),
                    _buildVitamins(context),

                    _buildData(context: context, isSale: true),

                    _buildData(context: context, isSale: false),

                    SizedBox(
                      height: 40,
                    ),
                    FilledButton(
                      title: 'DONE',
                      onClickAction: () async {
                        if (_formKey.currentState.validate()) {
                          viewModel.isLoading = true;
                          _formKey.currentState.save();
                          await _viewModel.creteNewFruit();
                          Navigator.pop(context);
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: white,
      elevation: 3,
      title: const Text(
        'Add Item',
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w700,
          color: red,
          letterSpacing: 1,
        ),
      ),
      leading: Container(),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            'Cancel',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: blue,
            ),
          ),
          style: ButtonStyle(
            overlayColor:
                MaterialStateProperty.all(Colors.white.withOpacity(0.2)),
          ),
        )
      ],
    );
  }

  Widget _buildTextField(
      {String title,
      String hintText,
      Function onSave,
      bool isDouble,
      AddItemViewModel viewModel}) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 15, bottom: 8, left: 8),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.black,
                letterSpacing: 0.5,
              ),
            ),
          ),
        ),
        Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.only(
                left: 10.0, right: 10.0, bottom: 10.0, top: 10.0),
            child: TextFormField(
              validator: (value) {
                if (value.isEmpty) {
                  return 'Enter a value';
                }
                if (isDouble && !viewModel.isNumeric(value)) {
                  return 'Enter a valid number';
                }
                return null;
              },
              onSaved: (val) {
                onSave(val);
              },
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black,
                letterSpacing: 0.7,
              ),
              keyboardType: TextInputType.multiline,
              maxLines: 1,
              decoration: InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                contentPadding:
                    EdgeInsets.only(left: 0, bottom: 0, top: 0, right: 0),
                hintText: hintText,
                hintStyle: TextStyle(
                  color: Colors.black26,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildVitamins(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 15, bottom: 8, left: 8),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'VITAMINS',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.black,
                letterSpacing: 0.5,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Consumer<AddItemViewModel>(
            builder: (context, viewModel, child) {
              return Align(
                alignment: Alignment.centerLeft,
                child: Wrap(
                  alignment: WrapAlignment.start,
                  spacing: 8.0, // gap between adjacent chips
                  runSpacing: 8.0, // gap between lines
                  children: _vitaminList(viewModel.fruit.vitamins, context),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  List<Widget> _vitaminList(List<Vitamins> vitamins, BuildContext context) {
    List<Widget> widgets = [];
    vitamins.forEach((vitamin) {
      widgets.add(
        Chip(
          padding: EdgeInsets.all(10),
          backgroundColor: Colors.white,
          label: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                vitamin.name,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                  letterSpacing: 0.5,
                ),
              ),
              Text(
                ' ' + vitamin.value.toString() + ' %',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.black45,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
        ),
      );
    });

    if (widgets.length == 0) {
      widgets.add(AddButton(
        title: 'Add Vitamin',
        onClickAction: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddVitaminPage(),
            ),
          );
        },
      ));
    } else {
      widgets.add(AddButton(
        title: 'Edit Vitamin',
        onClickAction: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddVitaminPage(),
            ),
          );
        },
        iconData: Icons.edit,
      ));
    }

    return widgets;
  }

  Widget _buildData({BuildContext context, bool isSale}) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 15, bottom: 8, left: 8),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              isSale ? 'SALES' : 'AVAILABILITY',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.black,
                letterSpacing: 0.5,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Consumer<AddItemViewModel>(
            builder: (context, viewModel, child) {
              return Align(
                alignment: Alignment.centerLeft,
                child: Wrap(
                  alignment: WrapAlignment.start,
                  spacing: 8.0, // gap between adjacent chips
                  runSpacing: 8.0, // gap between lines
                  children: _dataList(
                    data: isSale
                        ? viewModel.fruit.sales
                        : viewModel.fruit.availability,
                    context: context,
                    isSale: isSale,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  List<Widget> _dataList({List<Data> data, BuildContext context, bool isSale}) {
    List<Widget> widgets = [];
    data.forEach((eachData) {
      widgets.add(
        Chip(
          padding: EdgeInsets.all(10),
          backgroundColor: Colors.white,
          label: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                eachData.month,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                  letterSpacing: 0.5,
                ),
              ),
              Text(
                ' ' + eachData.value.toString() + ' %',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.black45,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
        ),
      );
    });

    if (widgets.length == 0) {
      widgets.add(AddButton(
        title: isSale ? 'Add Sales' : 'Add Availability',
        onClickAction: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddDataPage(
                isSales: isSale,
              ),
            ),
          );
        },
      ));
    } else {
      widgets.add(AddButton(
        title: isSale ? 'Edit Sales' : 'Edit Availability',
        onClickAction: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddDataPage(
                isSales: isSale,
              ),
            ),
          );
        },
        iconData: Icons.edit,
      ));
    }
    return widgets;
  }
}
