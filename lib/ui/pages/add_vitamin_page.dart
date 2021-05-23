import 'package:demo_app/business_logic/models/vitamins.dart';
import 'package:demo_app/business_logic/view_models/add_item_viewmodel.dart';
import 'package:demo_app/ui/theme/colors.dart';
import 'package:demo_app/ui/widgets/filled_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Vitamins _vitamins;

class AddVitaminPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final _viewModel = Provider.of<AddItemViewModel>(context, listen: false);
    _vitamins = Vitamins('', 0);
    return Scaffold(
      backgroundColor: lightBlue,
      appBar: AppBar(
        backgroundColor: white,
        elevation: 3,
        title: const Text(
          'Add Vitamin',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: red,
            letterSpacing: 1,
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            color: red,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: <Widget>[],
      ),
      body: SingleChildScrollView(
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
                  _vitamins.name = value;
                },
                isDouble: false,
                viewModel: _viewModel,
              ),
              _buildTextField(
                title: 'Value',
                hintText: 'Enter the amount',
                onSave: (var value) {
                  _vitamins.value = int.parse(value);
                },
                isDouble: true,
                viewModel: _viewModel,
              ),

              SizedBox(
                height: 40,
              ),
              FilledButton(
                title: 'DONE',
                onClickAction: () {
                  if (_formKey.currentState.validate()) {
                    _formKey.currentState.save();
                    _viewModel.addVitamin(_vitamins);
                    Navigator.pop(context);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    String title,
    String hintText,
    Function onSave,
    bool isDouble,
    AddItemViewModel viewModel,
  }) {
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
}
