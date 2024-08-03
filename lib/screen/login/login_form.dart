import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wenku8x/http/api.dart';
import 'package:wenku8x/main.dart';
import 'package:wenku8x/service/navigation.dart';
import 'package:wenku8x/utils/flash.dart';
import 'package:wenku8x/utils/log.dart';

class LoginForm extends StatefulHookConsumerWidget {
  const LoginForm({super.key});

  @override
  ConsumerState<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends ConsumerState<LoginForm> {
  @override
  Widget build(BuildContext context) {
    final colorScheme = getColorScheme(context);
    final usernameController = useTextEditingController();
    final passwordController = useTextEditingController();
    final canLogin = useState(false);

    checkEmpty() {
      if (usernameController.text.isNotEmpty &&
          passwordController.text.isNotEmpty) {
        canLogin.value = true;
      } else {
        canLogin.value = false;
      }
    }

    useEffect(() {
      usernameController.addListener(checkEmpty);
      passwordController.addListener(checkEmpty);
      return () {
        usernameController.removeListener(checkEmpty);
        passwordController.removeListener(checkEmpty);
      };
    }, [usernameController, passwordController]);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
      child: ListView(
        // mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          RichText(
              text: TextSpan(children: [
            TextSpan(
                text: "轻小说文库",
                style: TextStyle(
                    color: colorScheme.secondary,
                    fontSize: 23,
                    fontWeight: FontWeight.bold)),
            const TextSpan(
                text: "\n \n", style: TextStyle(fontSize: 1, height: 6)),
            TextSpan(
                text: "www.wenku8.net",
                style: TextStyle(
                    color: colorScheme.secondary.withOpacity(0.5),
                    fontSize: 15,
                    fontWeight: FontWeight.normal))
          ])),
          Padding(
            padding: const EdgeInsets.only(top: 42),
            child: TextField(
              controller: usernameController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text("用户名"),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 12,
                  )),
              // controller: controller.usernameController,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 32),
            child: TextField(
              obscureText: true,
              controller: passwordController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text("密码"),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 12,
                  )),
              // controller: controller.usernameController,
            ),
          ),
          Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.only(top: 64),
              child: TextButton(
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    backgroundColor: canLogin.value
                        ? colorScheme.primary
                        : Colors.grey.withOpacity(0.5),
                    minimumSize: const Size(148, 44),
                  ),
                  onPressed: () async {
                    final completer = Completer();
                    Show.loading(completer, context: context);
                    var res = await API.login(
                        usernameController.text, passwordController.text);
                    Log.d(res);
                    Future.delayed(const Duration(milliseconds: 500)).then((_) {
                      completer.complete();
                      if (res) {
                        sp.setString("username", usernameController.text);
                        sp.setString("password", passwordController.text);
                        GoRouter.of(context).go("/");
                      } else {
                        // ignore: use_build_context_synchronously
                        Show.error("登录失败，用户名或密码错误");
                      }
                    });
                  },
                  child: Text(
                    "登陆",
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary),
                  ))),
        ],
      ),
    );
  }
}
