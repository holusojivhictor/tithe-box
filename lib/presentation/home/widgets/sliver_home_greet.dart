import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tithe_box/application/bloc.dart';
import 'package:tithe_box/presentation/shared/loading.dart';

class SliverHomeGreet extends StatelessWidget {
  const SliverHomeGreet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      sliver: SliverToBoxAdapter(
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (ctx, state) => state.map(
            loading: (_) => const Loading(useScaffold: false),
            loaded: (state) {
              final firstName = state.firstName;
              return RichText(
                text: TextSpan(
                  text: 'Welcome, ',
                  style: theme.textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold, fontSize: 20),
                  children: <TextSpan> [
                    TextSpan(
                      text: firstName,
                      style: TextStyle(color: theme.primaryColor),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
