import 'package:flutter/material.dart';
import 'package:tithe_box/domain/enums/enums.dart';
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
    return InkWell(
      borderRadius: Styles.mainCardBorderRadius,
      onTap: () {},
      child: CustomCard(
        clipBehavior: Clip.hardEdge,
        margin: Styles.edgeInsetAll10,
        shape: Styles.mainCardShape,
        elevation: withElevation ? Styles.cardTenElevation : 0,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 5),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 10,
                    child: CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.grey.withOpacity(0.2),
                      child: const Icon(Icons.download_outlined, color: Colors.black87),
                    ),
                  ),
                  Expanded(
                    flex: 70,
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            businessName,
                            style: Theme.of(context).textTheme.headline2!.copyWith(fontWeight: FontWeight.w300, fontSize: 16),
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.start,
                          ),
                          const SizedBox(height: 5),
                          Row(
                            children: [
                              Text(
                                'Time',
                                style: Theme.of(context).textTheme.bodyText2!.copyWith(fontSize: 13, fontWeight: FontWeight.normal),
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
                    flex: 10,
                    child: Text(
                      '$amount',
                      textAlign: TextAlign.center,
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