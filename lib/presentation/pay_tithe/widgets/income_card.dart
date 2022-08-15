import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tithe_box/application/bloc.dart';
import 'package:tithe_box/domain/app_constants.dart';
import 'package:tithe_box/domain/assets.dart';
import 'package:tithe_box/domain/enums/enums.dart';
import 'package:tithe_box/domain/extensions/string_extensions.dart';
import 'package:tithe_box/domain/models/models.dart';
import 'package:tithe_box/presentation/churches/churches_page.dart';
import 'package:tithe_box/presentation/pay_tithe/widgets/payment_modal.dart';
import 'package:tithe_box/presentation/shared/custom_alert_dialog.dart';
import 'package:tithe_box/presentation/shared/custom_card.dart';
import 'package:tithe_box/theme.dart';

import 'container_tag.dart';

class IncomeCard extends StatefulWidget {
  final String id;
  final UserAccountType type;
  final String businessName;
  final String businessAddress;
  final double amount;
  final String description;
  final double titheAmount;
  final SalaryType frequency;
  final String createdAt;
  final bool isPaid;

  final bool withElevation;

  const IncomeCard({
    Key? key,
    required this.id,
    required this.type,
    required this.businessName,
    required this.businessAddress,
    required this.amount,
    required this.description,
    required this.titheAmount,
    required this.frequency,
    required this.createdAt,
    required this.isPaid,
    this.withElevation = true,
  }) : super(key: key);

  IncomeCard.card({
    Key? key,
    required IncomeCardModel income,
    this.withElevation = true,
  })  : id = income.id,
        type = income.type,
        businessName = income.businessName,
        businessAddress = income.businessAddress,
        amount = income.amount,
        description = income.description,
        titheAmount = calculateTithe(income.amount, income.tithePercentage),
        frequency = income.frequency,
        createdAt = income.createdAt,
        isPaid = income.isPaid,
        super(key: key);

  @override
  State<IncomeCard> createState() => _IncomeCardState();
}

class _IncomeCardState extends State<IncomeCard> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      borderRadius: Styles.mainCardBorderRadius,
      onTap: () {},
      child: CustomCard(
        clipBehavior: Clip.hardEdge,
        margin: Styles.edgeInsetHorizontal16Vertical5,
        shape: Styles.mainCardShape,
        color: Colors.white,
        elevation: widget.withElevation ? Styles.cardTenElevation : 0,
        child: Padding(
          padding: Styles.edgeInsetAll10,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ContainerTag(tagText: Assets.translateSalaryType(widget.frequency)),
                  Text(
                    widget.createdAt.formatDateString(),
                    style: theme.textTheme.bodySmall!.copyWith(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Text(
                  widget.businessName,
                  style: theme.textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.start,
                ),
              ),
              const SizedBox(height: 5),
              Row(
                children: [
                  Expanded(
                    flex: 70,
                    child: Text(
                      widget.description,
                      style: theme.textTheme.bodyMedium,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.start,
                    ),
                  ),
                  Expanded(
                    flex: 30,
                    child: Text(
                      'Tithe: N${widget.titheAmount.toStringAsFixed(1)}',
                      textAlign: TextAlign.end,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              ElevatedButton(
                onPressed: widget.isPaid ? null : () => _payNow(context),
                child: Text(widget.isPaid ? 'Paid' : 'Pay Now'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _payNow(BuildContext context) async {
    final churchesBloc = context.read<ChurchesBloc>();
    final route = MaterialPageRoute<Map<String, String>>(builder: (_) => const ChurchesPage(isInSelectionMode: true));
    final keys = await Navigator.push(context, route);

    churchesBloc.add(const ChurchesEvent.init());
    if (keys == null) {
      return;
    }

    _showDialog(keys);
  }

  Future<void> _showDialog(Map<String, String> keys) async {
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => CommonAlertDialog(
        titleText: 'Pay Tithe',
        contentText: 'Proceed to pay tithe of N${widget.titheAmount}, for ${widget.businessName} income, created on ${widget.createdAt.formatDateString()}?',
        cancelText: 'Cancel',
        actionText: 'Okay',
        cancelOnPressed: () {
          Navigator.of(context).pop();
        },
        actionOnPressed: () async {
          Navigator.of(context).pop();
          await _handlePayment(keys["id"]!, keys["accountId"]!);
        },
      ),
    );
  }

  Future<void> _handlePayment(String churchId, String accountId) async {
    String link;
    final bloc = context.read<DataBloc>();
    bloc.add(DataEvent.addPayment(incomeId: widget.id, churchId: churchId, accountId: accountId));
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => BlocListener<DataBloc, DataState>(
        listener: (ctx, state) => state.maybeMap(
          data: (state) async {
            final data = state.data;
            final response = data.data as Map<String, dynamic>;
            link = response["data"]["link"];
            Navigator.of(context).pop();
            final route = MaterialPageRoute(builder: (_) => PaymentModal(link: link));
            await Navigator.push(context, route);
            await route.completed;
            return;
          },
          orElse: () => {},
        ),
        child: const CustomAlertDialog(text: 'Processing...'),
      ),
    );
  }
}
