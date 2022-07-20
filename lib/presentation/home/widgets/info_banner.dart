import 'package:flutter/material.dart';
import 'package:tithe_box/domain/assets.dart';
import 'package:tithe_box/presentation/shared/custom_card.dart';
import 'package:tithe_box/presentation/shared/svg_image.dart';
import 'package:tithe_box/theme.dart';

class InfoBanner extends StatelessWidget {
  const InfoBanner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      elevation: 0,
      shape: Styles.mainCardShape,
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: SvgImage(
              label: 'Info banner svg',
              image: Assets.getSvgPath('mask-vector.svg'),
              fit: BoxFit.cover,
              height: 140,
            ),
          ),
          Row(
            children: [
              Expanded(
                flex: 25,
                child: Icon(Icons.monetization_on_outlined, color: kWhite, size: 30),
              ),
              Expanded(
                flex: 75,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text.rich(
                      TextSpan(
                        text: "Total Income\n\n",
                        style: TextStyle(color: kWhite, fontSize: 18),
                        children: const [
                          TextSpan(
                            text: "N1000.00",
                            style: TextStyle(fontSize: 30, fontWeight: FontWeight.w800),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
