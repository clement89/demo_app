import 'package:demo_app/business_logic/models/fruit.dart';
import 'package:demo_app/business_logic/view_models/home_viewmodel.dart';
import 'package:demo_app/ui/theme/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

class FruitListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: white,
        elevation: 1,
        title: const Text(
          'Fruit List',
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
      body: SafeArea(
        child: Consumer<HomeViewModel>(
          builder: (context, viewModel, child) => ListView.separated(
            itemCount: viewModel.fruitList.length,
            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
            separatorBuilder: (context, index) => Divider(
              color: Colors.black54,
              thickness: 0.2,
              height: 1,
            ),
            itemBuilder: (context, index) {
              Fruit fruit = viewModel.fruitList[index];

              return Slidable(
                actionPane: SlidableDrawerActionPane(),
                actionExtentRatio: 0.25,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Text(
                      '${fruit.name}',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                        letterSpacing: 1,
                      ),
                    ),
                    leading: const Icon(
                      Icons.tonality_rounded,
                      size: 26,
                    ),
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                    ),
                    onTap: () {
                      viewModel.updateSelectedFruit(fruit);
                      Navigator.pop(context);
                    },
                  ),
                ),
                secondaryActions: <Widget>[
                  IconSlideAction(
                    caption: 'Edit',
                    color: Colors.black45,
                    icon: Icons.edit,
                    onTap: () {},
                  ),
                  IconSlideAction(
                    caption: 'Delete',
                    color: Colors.red,
                    icon: Icons.delete,
                    onTap: () async {
                      await viewModel.deleteFruit(fruit);
                      final snackBar =
                          SnackBar(content: Text(viewModel.message));
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    },
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
