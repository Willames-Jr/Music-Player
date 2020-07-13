// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AppController on _AppBase, Store {
  final _$audioManagerAtom = Atom(name: '_AppBase.audioManager');

  @override
  AudioManager get audioManager {
    _$audioManagerAtom.reportRead();
    return super.audioManager;
  }

  @override
  set audioManager(AudioManager value) {
    _$audioManagerAtom.reportWrite(value, super.audioManager, () {
      super.audioManager = value;
    });
  }

  @override
  String toString() {
    return '''
audioManager: ${audioManager}
    ''';
  }
}
