import 'package:flutter/material.dart';
import 'package:tithe_box/domain/app_constants.dart';
import 'package:tithe_box/domain/assets.dart';
import 'package:tithe_box/domain/enums/enums.dart';
import 'package:tithe_box/domain/extensions/string_extensions.dart';
import 'package:tithe_box/domain/models/models.dart';
import 'package:tithe_box/presentation/shared/custom_card.dart';
import 'package:tithe_box/theme.dart';

import 'container_tag.dart';

class IncomeCard extends StatelessWidget {
  final String id;
  final UserAccountType type;
  final String businessName;
  final String businessAddress;
  final double amount;
  final String description;
  final double titheAmount;
  final SalaryType frequency;
  final String createdAt;

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
        super(key: key);

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
        elevation: withElevation ? Styles.cardTenElevation : 0,
        child: Padding(
          padding: Styles.edgeInsetAll10,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ContainerTag(tagText: Assets.translateSalaryType(frequency)),
                  Text(
                    createdAt.formatDateString(),
                    style: theme.textTheme.bodySmall!.copyWith(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Text(
                  businessName,
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
                      description,
                      style: theme.textTheme.bodyMedium,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.start,
                    ),
                  ),
                  Expanded(
                    flex: 30,
                    child: Text(
                      'Tithe: N${titheAmount.toStringAsFixed(1)}',
                      textAlign: TextAlign.end,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              ElevatedButton(
                onPressed: () {},
                child: const Text('Pay Now'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
