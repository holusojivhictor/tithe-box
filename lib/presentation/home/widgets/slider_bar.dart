import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tithe_box/application/bloc.dart';

class SliderBar extends StatelessWidget {
  final double sliderValue;
  final bool isActive;

  const SliderBar({
    Key? key,
    required this.sliderValue,
    this.isActive = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Slider(
      min: 0,
      max: 100,
      divisions: 10,
      label: '${sliderValue.round()}%',
      value: sliderValue,
      onChanged: isActive ? (value) {
        context.read<SettingsBloc>().add(SettingsEvent.tithePercentageChanged(newValue: value));
      } : (value) {},
    );
  }
}
