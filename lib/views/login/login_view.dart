import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wenku8x/http/api.dart';
import 'package:wenku8x/utils/log.dart';

class Loginview extends HookConsumerWidget {
  const Loginview({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final usernameController = useTextEditingController();
    final passwordController = useTextEditingController();
    final configBox = Hive.box("config");
    usernameController.text = configBox.get("username") ?? "";
    passwordController.text = configBox.get("password") ?? "";
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: EdgeInsets.only(
          left: MediaQuery.of(context).size.width / 14,
          right: MediaQuery.of(context).size.width / 14,
          top: MediaQuery.of(context).size.height / 5,
        ),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                alignment: Alignment.bottomLeft,
                padding: const EdgeInsets.only(bottom: 48),
                child: Text(
                  "账户登录",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 32),
                child: TextField(
                  controller: usernameController,
                  decoration: const InputDecoration(
                      label: Text("用户名"), contentPadding: EdgeInsets.zero),
                  // controller: controller.usernameController,
                ),
              ),
              Padding(
                  padding: const EdgeInsets.only(bottom: 32),
                  child: TextField(
                    controller: passwordController,
                    decoration: const InputDecoration(
                        label: Text("密码"), contentPadding: EdgeInsets.zero),
                  )),
              Container(
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(top: 64),
                  child: TextButton(
                      style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        minimumSize: const Size(148, 44),
                      ),
                      onPressed: () async {
                        var res = await API.login(
                            usernameController.text, passwordController.text);
                        Log.d(res);
                        configBox.put("username", usernameController.text);
                        configBox.put("password", passwordController.text);
                        if (res) {
                          // ignore: use_build_context_synchronously
                          GoRouter.of(context).go("/");
                        }
                      },
                      child: Text(
                        "登陆",
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.onPrimary),
                      ))),
            ]),
      ),
    );
  }
}
