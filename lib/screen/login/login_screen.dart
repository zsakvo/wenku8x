import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wenku8x/screen/login/login_form.dart';
import 'package:wenku8x/utils/util.dart';

class LoginScreen extends StatefulHookConsumerWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Util.isDesktop()
          ? Stack(
              children: [
                buildBackground(context),
                BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: const Padding(
                      padding: EdgeInsets.only(top: 50, left: 100, right: 100),
                      child: LoginForm()),
                ),
              ],
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildBackground(context),
                const Expanded(child: LoginForm())
              ],
            ),
    );
  }

  Widget buildBackground(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      child: SvgPicture.asset(
        "assets/svg/il_page_login.svg",
        width: MediaQuery.of(context).size.width,
      ),
    );
  }
}
