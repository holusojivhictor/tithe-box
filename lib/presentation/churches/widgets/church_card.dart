import 'package:flutter/material.dart';
import 'package:tithe_box/domain/enums/enums.dart';
import 'package:tithe_box/domain/models/models.dart';
import 'package:tithe_box/presentation/pay_tithe/widgets/container_tag.dart';
import 'package:tithe_box/presentation/shared/custom_card.dart';
import 'package:tithe_box/theme.dart';

class ChurchCard extends StatelessWidget {
  final String id;
  final String name;
  final List<ChurchServiceDay> serviceDays;
  final String accountId;
  final String address;

  final bool withElevation;
  final bool isInSelectionMode;

  const ChurchCard({
    Key? key,
    required this.id,
    required this.name,
    required this.serviceDays,
    required this.accountId,
    required this.address,
    this.withElevation = true,
    this.isInSelectionMode = false,
  }) : super(key: key);

  ChurchCard.item({
    Key? key,
    required ChurchCardModel church,
    this.withElevation = true,
    this.isInSelectionMode = false,
  })  : id = church.id,
        name = church.name,
        serviceDays = church.serviceDays,
        accountId = church.accountId,
        address = church.address,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return InkWell(
      borderRadius: Styles.mainCardBorderRadius,
      onTap: () => _goToChurchPage(context),
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
                    flex: 80,
                    child: Padding(
                      padding: const EdgeInsets.all(8),
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
              const SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 75,
                      child: Wrap(
                        runSpacing: 10,
                        spacing: 5,
                        children: getTags(),
                      ),
                    ),
                    Expanded(
                      flex: 15,
                      child: ContainerTag(
                        tagText: 'Active',
                        color: Colors.green.withOpacity(0.7),
                      ),
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

  List<Widget> getTags() {
    return serviceDays.map((e) => ContainerTag(tagText: e.name)).toList();
  }

  Future<void> _goToChurchPage(BuildContext context) async {
    if (isInSelectionMode) {
      Navigator.pop(context, {"id": id, "accountId": accountId});
      return;
    }
  }
}
