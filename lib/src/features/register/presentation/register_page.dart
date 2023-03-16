import 'package:app/src/features/register/data/models/register_post_data.dart';
import 'package:app/src/features/register/presentation/controller/register_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';

import '../data/models/register_response.dart';
import 'widgets/error_message.dart';
import 'widgets/register_button.dart';
import 'widgets/register_form.dart';

final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  RegisterController registerController = Get.put(RegisterController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: FormBuilder(
            key: _formKey,
            autoFocusOnValidationFailure: true,
            child: GetBuilder<RegisterController>(
              builder: (ctrl) {
                return ListView(
                  shrinkWrap: true,
                  children: <Widget>[
                    if (ctrl.isError.isTrue &&
                        ctrl.registerResponse.value.statusCode != 200 &&
                        ctrl.isLoading.isFalse &&
                        ctrl.registerResponse.value.errors != null &&
                        ctrl.registerResponse.value.errors!.length > 0)
                      ErrorMessage(
                        message: ctrl.registerResponse.value.errors!,
                      ),
                    if (ctrl.isError.isTrue &&
                        ctrl.registerResponse.value.statusCode != 200 &&
                        ctrl.isLoading.isFalse &&
                        ctrl.registerResponse.value.errors == null)
                      ErrorMessage(
                        message: [
                          ErrorItem(key: 'message', messages: [
                            ctrl.registerResponse.value.message!,
                          ])
                        ],
                      ),
                    RegisterForm(
                      formKey: _formKey,
                    ),
                    const SizedBox(height: 20),
                    RegisterButton(
                      onPressed: () {
                        if (_formKey.currentState!.saveAndValidate()) {
                          registerController.call(
                            RegisterPostData(
                              email: _formKey.currentState!.value['email'],
                              password:
                                  _formKey.currentState!.value['password'],
                              password_confirmation:
                                  _formKey.currentState!.value['confirmed'],
                              fullname:
                                  _formKey.currentState!.value['fullname'],
                              phone: _formKey.currentState!.value['phone'],
                            ),
                          );
                        }
                      },
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
