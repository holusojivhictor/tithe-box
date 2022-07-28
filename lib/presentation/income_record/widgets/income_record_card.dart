import 'package:flutter/material.dart';
import 'package:tithe_box/domain/enums/enums.dart';
import 'package:tithe_box/domain/extensions/string_extensions.dart';
import 'package:tithe_box/domain/models/models.dart';
import 'package:tithe_box/presentation/shared/custom_card.dart';
import 'package:tithe_box/theme.dart';

class IncomeRecordCard extends StatelessWidget {
  final UserAccountType type;
  final String businessName;
  final double amount;
  final SalaryType frequency;
  final String createdAt;

  final bool withElevation;

  const IncomeRecordCard({
    Key? key,
    required this.type,
    required this.businessName,
    required this.amount,
    required this.frequency,
    required this.createdAt,
    this.withElevation = true,
  }) : super(key: key);

  IncomeRecordCard.item({
    Key? key,
    required IncomeCardModel income,
    this.withElevation = true,
  })  : type = income.type,
        businessName = income.businessName,
        amount = income.amount,
        frequency = income.frequency,
        createdAt = income.createdAt,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return InkWell(
      borderRadius: Styles.mainCardBorderRadius,
      onTap: () {},
      child: CustomCard(
        clipBehavior: Clip.hardEdge,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        shape: Styles.mainCardShape,
        color: Colors.white,
        elevation: withElevation ? Styles.cardTenElevation : 0,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 13,
                    child: CircleAvatar(
                      radius: 20,
                      backgroundColor: frequency.color,
                      child: const RotatedBox(
                        quarterTurns: 3,
                        child: Icon(Icons.arrow_back, color: Colors.black87, size: 20),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 57,
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            businessName,
                            style: textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w500),
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.start,
                          ),
                          const SizedBox(height: 5),
                          Row(
                            children: [
                              Text(
                                createdAt.formatTimeString(hasYear: true),
                                style: textTheme.bodyMedium!.copyWith(color: Colors.black54),
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.start,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 20,
                    child: Text(
                      'N$amount',
                      textAlign: TextAlign.center,
                      style: textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}