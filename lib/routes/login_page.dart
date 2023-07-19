import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:git_client_app/common/git.dart';
import 'package:git_client_app/common/loading/loading_manager.dart';
import 'package:git_client_app/l10n/gm_localizations.dart';

import '../common/global.dart';
import '../models/user.dart';

class LoginRoute extends StatefulWidget {
  const LoginRoute({super.key});

  @override
  State<LoginRoute> createState() => _LoginRouteState();
}

class _LoginRouteState extends State<LoginRoute> {
  final TextEditingController _uNameController = TextEditingController();
  final TextEditingController _uPwdController = TextEditingController();
  bool pwsShow = false;
  final GlobalKey _formKey = GlobalKey<FormState>();
  bool _nameAutoFocus = true;

  @override
  void initState() {
    //自动填充上次登录的用户名，填充后将焦点定位到密码框
    _uNameController.text = Global.profile.lastLogin ?? '';
    if (_uNameController.text.isNotEmpty) {
      _nameAutoFocus = false;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var gm = GmLocalization.of(context);
    LoadingManager.initialize(context: context);
    return Scaffold(
      appBar: AppBar(
        title: Text(gm.login),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              TextFormField(
                autofocus: _nameAutoFocus,
                controller: _uNameController,
                decoration: InputDecoration(
                    labelText: gm.userName,
                    hintText: gm.userName,
                    prefixIcon: const Icon(Icons.person)),
                validator: (value) {
                  return value == null || value.trim().isNotEmpty
                      ? null
                      : gm.userNameRequired;
                },
              ),
              TextFormField(
                controller: _uPwdController,
                autofocus: !_nameAutoFocus,
                decoration: InputDecoration(
                    labelText: gm.password,
                    prefixIcon: const Icon(Icons.lock),
                    suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            pwsShow = !pwsShow;
                          });
                        },
                        icon: Icon(
                            pwsShow ? Icons.visibility_off : Icons.visibility)),
                    hintText: gm.password),
                obscureText: !pwsShow,
                validator: (value) {
                  return value == null || value.trim().isNotEmpty
                      ? null
                      : gm.passwordRequired;
                },
              ),
              Padding(
                  padding: const EdgeInsets.only(top: 25),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints.expand(height: 55),
                    child: ElevatedButton(
                        onPressed: _onLogin, child: Text(gm.login)),
                  ))
            ],
          ),
        ),
      ),
    );
  }

  void _onLogin() async {
    //先验证各个表单字段是否合法

    if ((_formKey.currentState as FormState).validate()) {
      LoadingManager.instance.show();
      User? user;
      try {
        user = await Git(context)
            .login(_uNameController.text, _uPwdController.text);
      } on DioException catch (e) {
        if (e.response?.statusCode == 401) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content:
                  Text(GmLocalization.of(context).userNameOrPasswordWrong)));
        } else {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(e.toString())));
        }
      } finally {
        LoadingManager.instance.hide();
      }
    }
  }
}
