import 'package:flutter/material.dart';
import 'package:tithe_box/presentation/home/widgets/forms/add_income_form.dart';

class SliverAddIncomeForm extends StatelessWidget {
  const SliverAddIncomeForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      sliver: SliverToBoxAdapter(
        child: AddIncomeForm(),
      ),
    );
  }
}
