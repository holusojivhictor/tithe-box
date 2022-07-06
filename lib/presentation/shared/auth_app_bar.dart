import 'package:flutter/material.dart';

typedef OnTap = void Function();

class AuthAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final OnTap? onTap;
  final bool hasTitle;

  const AuthAppBar({
    Key? key,
    this.title = "",
    this.hasTitle = true,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: hasTitle ? Text(
        title,
        style: theme.textTheme.bodyLarge!.copyWith(color: Colors.grey),
      ) : null,
      leading: InkWell(
        onTap: onTap,
        child: RotatedBox(
          quarterTurns: 2,
          child: Icon(
            Icons.arrow_right_alt_sharp,
            color: theme.indicatorColor,
          ),
        ),
      ),
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);
}
