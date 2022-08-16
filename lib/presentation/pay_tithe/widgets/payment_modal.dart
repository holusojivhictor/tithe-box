import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tithe_box/application/bloc.dart';
import 'package:tithe_box/presentation/shared/custom_alert_dialog.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentModal extends StatefulWidget {
  final String link;
  const PaymentModal({Key? key, required this.link}) : super(key: key);

  @override
  State<PaymentModal> createState() => _PaymentModalState();
}

class _PaymentModalState extends State<PaymentModal> {
  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) {
      WebView.platform = AndroidWebView();
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => handleWillPop(context),
      child: Scaffold(
        appBar: const _AppBar(),
        body: WebView(
          javascriptMode: JavascriptMode.unrestricted,
          initialUrl: widget.link,
          onPageStarted: (String url) async {
            if (url.startsWith('https://tithebox.herokuapp.com/api/v1/redirect/payment/')) {
              Timer(const Duration(seconds: 1), () async {
                await handleClose(context);
              });
            }
          },
        ),
      ),
    );
  }

  Future<bool> handleWillPop(BuildContext context) async {
    final bloc = context.read<IncomesBloc>();
    showDialog(
      context: context,
      builder: (ctx) => CommonAlertDialog(
        titleText: 'Close Modal',
        contentText: 'Are you sure you want to close the payment modal?',
        cancelText: 'No thanks',
        actionText: 'Close',
        actionOnPressed: () {
          Navigator.of(context).pop();
          Navigator.of(context).pop();
          bloc.add(const IncomesEvent.refresh());
        },
      ),
    );
    return false;
  }

  Future<void> handleClose(BuildContext context) async {
    final bloc = context.read<IncomesBloc>();
    await showDialog(
      context: context,
      builder: (ctx) => CommonAlertDialog(
        titleText: 'Close Modal',
        contentText: 'This transaction has been completed, close modal now.',
        cancelText: 'No thanks',
        actionText: 'Close',
        actionOnPressed: () {
          Navigator.of(context).pop();
          Navigator.of(context).pop();
          bloc.add(const IncomesEvent.refresh());
        },
      ),
    );
  }
}

class _AppBar extends StatelessWidget implements PreferredSizeWidget{
  const _AppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AppBar(
      elevation: 0,
      iconTheme: IconThemeData(color: theme.indicatorColor),
      backgroundColor: Colors.transparent,
      centerTitle: true,
      title: Text(
        "Payment Modal",
        style: theme.textTheme.displayMedium!.copyWith(fontSize: 20),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);
}
