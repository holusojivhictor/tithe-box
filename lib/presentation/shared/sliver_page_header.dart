import 'package:flutter/material.dart';
import 'package:tithe_box/presentation/shared/page_header.dart';

class SliverPageHeader extends StatelessWidget {
  final String header;
  final String subHeader;
  final bool hasSpace;

  const SliverPageHeader({
    Key? key,
    this.header = '',
    required this.subHeader,
    this.hasSpace = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: PageHeader(header: header, subHeader: subHeader, hasSpace: hasSpace),
    );
  }
}
