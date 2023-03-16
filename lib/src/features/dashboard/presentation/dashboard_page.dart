import 'package:app/src/core/domain/repositories/authentication_repository.dart';
import 'package:app/src/core/domain/usecases/delete_token_usecase.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';

import '../../../core/domain/usecases/usecase.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              DeleteTokenUseCase deleteTokenUseCase =
                  GetIt.I<DeleteTokenUseCase>();
              deleteTokenUseCase.call(NoParams()).then((value) {
                Get.offAllNamed('/login');
              });
            },
          ),
        ],
      ),
      body: const Placeholder(),
    );
  }
}
