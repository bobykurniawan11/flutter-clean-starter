import 'package:app/src/features/login/data/models/login_post_data.dart';
import 'package:app/src/features/login/presentation/widgets/login_button.dart';
import 'package:app/src/features/login/presentation/widgets/login_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';

import '../controller/login_controller.dart';
import 'widgets/error_message.dart';

final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  LoginController loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: FormBuilder(
            key: _formKey,
            autoFocusOnValidationFailure: true,
            child: GetBuilder<LoginController>(
              init: LoginController(),
              builder: (ctrl) {
                return ListView(
                  shrinkWrap: true,
                  children: <Widget>[
                    if (ctrl.isError.isTrue &&
                        ctrl.loginResponse.value.statusCode != 200 &&
                        ctrl.isLoading.isFalse)
                      const ErrorMessage(message: "Invalid email or password"),
                    const SizedBox(height: 20.0),
                    const LoginForm(),
                    const SizedBox(height: 20.0),
                    LoginButton(
                      onPressed: () {
                        if (_formKey.currentState!.saveAndValidate()) {
                          loginController.login(LoginPostData(
                              email: _formKey.currentState!.value['email'],
                              password:
                                  _formKey.currentState!.value['password']));
                        }
                      },
                    ),
                    const SizedBox(height: 20.0),
                    //register
                    TextButton(
                      onPressed: () {
                        Get.toNamed('/register');
                      },
                      child: const Text('Register'),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
