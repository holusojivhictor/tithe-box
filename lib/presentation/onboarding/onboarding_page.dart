import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tithe_box/application/bloc.dart';
import 'package:tithe_box/domain/app_constants.dart';
import 'package:tithe_box/domain/assets.dart';
import 'package:tithe_box/presentation/onboarding/widgets/verse_content.dart';
import 'package:tithe_box/presentation/shared/default_button.dart';
import 'package:tithe_box/presentation/shared/start/bottom_portrait_layout.dart';
import 'package:tithe_box/presentation/shared/utils/size_utils.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({Key? key}) : super(key: key);

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        fit: size.height > 750 ? StackFit.passthrough : StackFit.expand,
        children: [
          SizedBox(
            height: getTopHeightForOnboarding(context),
            child: Image.asset(
              Assets.getImagePath("bible-image.png"),
              fit: BoxFit.cover,
            ),
          ),
          BottomPortraitLayout(
            children: [
              Expanded(
                flex: 50,
                child: PageView.builder(
                  onPageChanged: (value) {
                    setState(() {
                      _currentPage = value;
                    });
                  },
                  itemCount: Data.startVerseData.length,
                  itemBuilder: (context, index) => VerseContent(
                    verse: Data.startVerseData[index].verse,
                    reading: Data.startVerseData[index].reading,
                  ),
                ),
              ),
              Expanded(
                flex: 50,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(Data.startVerseData.length, (index) => buildDot(index: index)),
                    ),
                    const SizedBox(height: 20),
                    DefaultButton(
                      isPrimary: true,
                      text: 'Next',
                      elevation: 0,
                      onPressed: () {
                        context.read<SessionBloc>().add(const SessionEvent.selectAccountType());
                      },
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

  AnimatedContainer buildDot({required int index}) {
    final theme = Theme.of(context);
    return AnimatedContainer(
      duration: kAnimationDuration,
      margin: const EdgeInsets.only(right: kPadding / 2),
      height: 6,
      width: _currentPage == index ? 20 : 6,
      decoration: BoxDecoration(
        color: _currentPage == index ? theme.colorScheme.primary : Colors.grey,
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}
