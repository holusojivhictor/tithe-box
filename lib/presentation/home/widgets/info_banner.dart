import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tithe_box/application/bloc.dart';
import 'package:tithe_box/domain/assets.dart';
import 'package:tithe_box/presentation/shared/custom_card.dart';
import 'package:tithe_box/presentation/shared/loading.dart';
import 'package:tithe_box/presentation/shared/svg_image.dart';
import 'package:tithe_box/theme.dart';

class InfoBanner extends StatelessWidget {
  final String header;
  final String info;
  const InfoBanner({
    Key? key,
    required this.header,
    required this.info,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      elevation: 0,
      shape: Styles.mainCardShape,
      margin: EdgeInsets.zero,
      clipBehavior: Clip.antiAlias,
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          BlocBuilder<SettingsBloc, SettingsState>(
            builder: (ctx, state) => state.map(
              loading: (_) => const Loading(useScaffold: false),
              loaded: (state) => ClipRRect(
                borderRadius: Styles.mainCardBorderRadius,
                child: SvgImage(
                  label: 'Info banner svg',
                  image: Assets.getBannerSvgPath(state.currentAccentColor),
                  fit: BoxFit.cover,
                  height: 135,
                ),
              ),
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text.rich(
                      TextSpan(
                        text: header,
                        style: TextStyle(color: kWhite, fontSize: 18),
                        children: [
                          TextSpan(
                            text: info,
                            style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w800),
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
