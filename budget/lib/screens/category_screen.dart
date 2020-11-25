import 'dart:math';

import 'package:budget/helpers/color_helper.dart';
import 'package:budget/models/category_model.dart';
import 'package:budget/widgets/radial_painter.dart';
import 'package:flutter/material.dart';

class CategoryScreen extends StatefulWidget {
  final Category category;

  CategoryScreen({this.category});

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  buildExpenses() {
    List<Widget> expenseList = [];
    widget.category.expenses.forEach((expense) {
      expenseList.add(Container(
        alignment: Alignment.center,
        margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        height: 80.0,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
                color: Colors.black12, offset: Offset(0, 2), blurRadius: 6.0),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.all(30.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                expense.name,
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '-\$${expense.cost.toStringAsFixed(2)}',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
        ),
      ));
    });

    return Column(
      children: expenseList,
    );
  }

  @override
  Widget build(BuildContext context) {
    double totalAmountSpend = 0;
    widget.category.expenses.forEach((expense) {
      totalAmountSpend += expense.cost;
    });
    final double amountLeft = widget.category.maxAmount - totalAmountSpend;
    final double percent = amountLeft / widget.category.maxAmount;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category.name),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            iconSize: 30.0,
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(20.0),
              padding: EdgeInsets.all(20.0),
              height: 250.0,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      offset: Offset(0, 2),
                      blurRadius: 6.0,
                    ),
                  ]),
              child: CustomPaint(
                foregroundPainter: RadialPainter(
                  bgColor: Colors.grey.shade200,
                  lineColor: getColor(context, percent),
                  percent: percent,
                  width: 15.0,
                ),
                child: Center(
                  child: Text(
                    '\$${amountLeft.toStringAsFixed(2)} / \$${widget.category.maxAmount.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
            buildExpenses(),
          ],
        ),
      ),
    );
  }
}
