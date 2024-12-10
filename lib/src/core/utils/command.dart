import 'dart:async';

import 'package:get/get.dart';

import 'result.dart';

typedef CommandAction0<T> = Future<Result<T>> Function();
typedef CommandAction1<T, A> = Future<Result<T>> Function(A);

class Command<T> extends GetxController {
  Command();

  final running = false.obs;
  final result = Rx<Result<T>?>(null);

  bool get error => result.value is Error;

  bool get completed => result.value is Ok;

  void clearResult() {
    result.value = null;
  }

  Future<void> _execute(CommandAction0<T> action) async {
    if (running.value) return;

    running.value = true;
    result.value = null;

    try {
      result.value = await action();
    } finally {
      running.value = false;
    }
  }
}

class Command0<T> extends Command<T> {
  Command0(this._action);

  final CommandAction0<T> _action;

  Future<void> execute() async {
    await _execute(() => _action());
  }
}

class Command1<T, A> extends Command<T> {
  Command1(this._action);

  final CommandAction1<T, A> _action;

  Future<void> execute(A argument) async {
    await _execute(() => _action(argument));
  }
}
