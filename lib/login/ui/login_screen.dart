import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:path/path.dart';
import 'package:ubuntu_logger/ubuntu_logger.dart';
import 'package:wenku8x/app/libs/request/apis.dart';
import 'package:wenku8x/app/services/path.dart';
import 'package:wenku8x/app/ui/components/top_bar.dart';
import 'package:wenku8x/app/utils/flash.dart';

class LoginScreen extends StatefulHookConsumerWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final logger = Logger("LoginScreen");
  File get loginFile =>
      File(join(PathService().applicationSupportDirectory, "login.json"));
  @override
  Widget build(BuildContext context) {
    final usernameController = useTextEditingController();
    final passwordController = useTextEditingController();
    final canLogin = useState(false);
    final showPassword = useState(false);
    final savePassword = useState(loginFile.existsSync());

    useEffect(() {
      if (savePassword.value) {
        final loginInfo = jsonDecode(loginFile.readAsStringSync());
        usernameController.text = loginInfo['username'];
        passwordController.text = loginInfo['password'];
      }
      return null;
    }, [usernameController, passwordController]);

    void updateCanLogin() {
      canLogin.value =
          usernameController.text.isNotEmpty &&
          passwordController.text.isNotEmpty;
    }

    useEffect(() {
      usernameController.addListener(updateCanLogin);
      passwordController.addListener(updateCanLogin);
      return () {
        usernameController.removeListener(updateCanLogin);
        passwordController.removeListener(updateCanLogin);
      };
    }, [usernameController, passwordController]);
    return Scaffold(
      appBar: AppTopBar(title: ""),
      resizeToAvoidBottomInset: false,
      body: ConstrainedBox(
        constraints: BoxConstraints.expand(),
        child: Stack(
          children: [
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: SvgPicture.asset(
                "assets/svg/bg_flying.svg",
                colorFilter: ColorFilter.mode(
                  Theme.of(context).colorScheme.onSurface,
                  BlendMode.srcIn,
                ),
                alignment: Alignment.bottomLeft,
              ),
            ),
            Positioned(
              child: Padding(
                padding: EdgeInsets.only(left: 20, right: 20, top: 16),
                child: Column(
                  spacing: 4,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "轻小说文库",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "www.wenku8.net",
                      style: TextStyle(
                        fontSize: 14,
                        color: Theme.of(
                          context,
                        ).colorScheme.onSurface.withAlpha(140),
                      ),
                    ),
                    SizedBox(height: 32),
                    TextField(
                      controller: usernameController,
                      decoration: InputDecoration(
                        labelText: '请输入用户名',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: BorderSide.none,
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        floatingLabelAlignment: FloatingLabelAlignment.start,
                        contentPadding: EdgeInsets.only(
                          left: 24,
                          right: 24,
                          top: 14,
                          bottom: 14,
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    TextField(
                      controller: passwordController,
                      obscureText: showPassword.value,
                      decoration: InputDecoration(
                        labelText: '请输入密码',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: BorderSide.none,
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        floatingLabelAlignment: FloatingLabelAlignment.start,
                        contentPadding: EdgeInsets.only(
                          left: 24,
                          right: 24,
                          top: 14,
                          bottom: 14,
                        ),
                        suffixIcon: Padding(
                          padding: EdgeInsets.only(right: 4),
                          child: IconButton(
                            icon: Icon(
                              showPassword.value
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              size: 20,
                            ),
                            onPressed: () {
                              showPassword.value = !showPassword.value;
                            },
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 32, bottom: 28),
                      child: Divider(indent: 16, endIndent: 16),
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          child: Row(
                            children: [
                              Checkbox.adaptive(
                                tristate: true,
                                value: savePassword.value,
                                onChanged: (value) {
                                  savePassword.value = value ?? false;
                                },
                                materialTapTargetSize:
                                    MaterialTapTargetSize.shrinkWrap,
                              ),
                              Text("记住密码"),
                            ],
                          ),
                          onTap: () {
                            savePassword.value = !savePassword.value;
                          },
                        ),
                        SizedBox(width: 56),
                        Expanded(
                          child: SizedBox(
                            width: double.infinity,
                            child: FilledButton(
                              onPressed: canLogin.value
                                  ? () async {
                                      FlashHelper.showLoading();
                                      var res = await Api.login(
                                        usernameController.text,
                                        passwordController.text,
                                      );
                                      logger.debug(res);
                                      Future.delayed(
                                        const Duration(milliseconds: 500),
                                      ).then((_) {
                                        if (context.mounted) {
                                          context.pop();
                                          if (res) {
                                            // sp.setString(
                                            //   "username",
                                            //   usernameController.text,
                                            // );
                                            // sp.setString(
                                            //   "password",
                                            //   passwordController.text,
                                            // );

                                            loginFile.createSync(
                                              recursive: true,
                                            );
                                            if (savePassword.value) {
                                              loginFile.writeAsStringSync(
                                                '{"username": "${usernameController.text}", "password": "${passwordController.text}"}',
                                              );
                                            } else {
                                              loginFile.deleteSync();
                                            }
                                            context.go("/shelf");
                                          } else {
                                            FlashHelper.showError(
                                              "登录失败，用户名或密码错误",
                                            );
                                          }
                                        }
                                      });
                                    }
                                  : null,
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                                padding: EdgeInsets.symmetric(vertical: 12),
                              ),
                              child: Text("登录", style: TextStyle(fontSize: 16)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
