import 'package:flutter/material.dart';
import 'package:tithe_box/domain/enums/enums.dart';
import 'package:tithe_box/domain/models/models.dart';
import 'package:tithe_box/presentation/shared/custom_card.dart';
import 'package:tithe_box/theme.dart';

class ChurchCard extends StatelessWidget {
  final String id;
  final String name;
  final List<ChurchServiceDay> serviceDays;
  final String address;

  final bool withElevation;

  const ChurchCard({
    Key? key,
    required this.id,
    required this.name,
    required this.serviceDays,
    required this.address,
    this.withElevation = true,
  }) : super(key: key);

  ChurchCard.item({
    Key? key,
    required ChurchCardModel church,
    this.withElevation = true,
  })  : id = church.id,
        name = church.name,
        serviceDays = church.serviceDays,
        address = church.address,
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
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 80,
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            name,
                            style: textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w500),
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.start,
                          ),
                          const SizedBox(height: 5),
                          Row(
                            children: [
                              Text(
                                address,
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
                    child: CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.grey.withOpacity(0.5),
                      child: const Icon(Icons.church_outlined, color: Colors.black87, size: 20),
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
