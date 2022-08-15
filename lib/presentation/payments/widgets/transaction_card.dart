import 'package:flutter/material.dart';
import 'package:tithe_box/domain/assets.dart';
import 'package:tithe_box/domain/enums/enums.dart';
import 'package:tithe_box/domain/extensions/string_extensions.dart';
import 'package:tithe_box/domain/models/models.dart';
import 'package:tithe_box/presentation/pay_tithe/widgets/container_tag.dart';
import 'package:tithe_box/presentation/shared/custom_card.dart';
import 'package:tithe_box/theme.dart';

class TransactionCard extends StatelessWidget {
  final String id;
  final double amount;
  final double tithePercentage;
  final TransactionStatus status;
  final String createdAt;

  final bool withElevation;

  const TransactionCard({
    Key? key,
    required this.id,
    required this.amount,
    required this.tithePercentage,
    required this.status,
    required this.createdAt,
    this.withElevation = true,
  }) : super(key: key);

  TransactionCard.item({
    Key? key,
    required TransactionCardModel transaction,
    this.withElevation = true,
  })  : id = transaction.id,
        amount = transaction.amount,
        tithePercentage = transaction.tithePercentage,
        status = transaction.status,
        createdAt = transaction.createdAt,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
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
          padding: Styles.edgeInsetAll5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 70,
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'N${amount.toStringAsFixed(1)}',
                            style: textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.start,
                          ),
                          const SizedBox(height: 5),
                          Text(
                            createdAt.formatDateString(),
                            style: textTheme.bodyMedium!.copyWith(color: Colors.black54),
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.start,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 30,
                    child: Text(
                      '$tithePercentage%',
                      textAlign: TextAlign.end,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ContainerTag(
                      tagText: Assets.translateTransactionStatus(status),
                      color: status.color,
                    ),
                    Text(
                      createdAt.formatTimeString(hasYear: true),
                      style: textTheme.bodySmall!.copyWith(fontWeight: FontWeight.w600),
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.end,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
