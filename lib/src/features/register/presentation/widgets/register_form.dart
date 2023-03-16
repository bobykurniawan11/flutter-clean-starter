import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class RegisterForm extends StatelessWidget {
  final GlobalKey<FormBuilderState> formKey;
  const RegisterForm({super.key, required this.formKey});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FormBuilderTextField(
          name: 'email',
          decoration: const InputDecoration(labelText: 'Email'),
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.required(),
            FormBuilderValidators.email(),
          ]),
        ),
        FormBuilderTextField(
          name: 'fullname',
          decoration: const InputDecoration(labelText: 'Full Name'),
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.required(),
          ]),
        ),
        FormBuilderTextField(
          name: 'phone',
          decoration: const InputDecoration(labelText: 'Phone'),
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.required(),
            FormBuilderValidators.numeric(),
          ]),
        ),
        FormBuilderTextField(
          name: 'password',
          decoration: const InputDecoration(labelText: 'Password'),
          obscureText: true,
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.required(),
            FormBuilderValidators.minLength(8),
          ]),
        ),
        FormBuilderTextField(
          name: 'confirmed',
          decoration: const InputDecoration(labelText: 'Password Confirmation'),
          obscureText: true,
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.required(),
            FormBuilderValidators.minLength(8),
            (value) {
              if (value != null &&
                  value != formKey.currentState!.value['password']) {
                return 'Password does not match';
              }
              return null;
            },
          ]),
        ),
      ],
    );
  }
}
