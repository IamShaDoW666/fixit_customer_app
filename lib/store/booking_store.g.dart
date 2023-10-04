// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$BookingStore on _BookingStore, Store {
  Computed<List<Map<String, dynamic>>>? _$selectedOptionsComputed;

  @override
  List<Map<String, dynamic>> get selectedOptions =>
      (_$selectedOptionsComputed ??= Computed<List<Map<String, dynamic>>>(
              () => super.selectedOptions,
              name: '_BookingStore.selectedOptions'))
          .value;

  late final _$optionsAtom =
      Atom(name: '_BookingStore.options', context: context);

  @override
  ObservableList<Map<String, dynamic>> get options {
    _$optionsAtom.reportRead();
    return super.options;
  }

  @override
  set options(ObservableList<Map<String, dynamic>> value) {
    _$optionsAtom.reportWrite(value, super.options, () {
      super.options = value;
    });
  }

  late final _$_BookingStoreActionController =
      ActionController(name: '_BookingStore', context: context);

  @override
  void addRadioOption(Map<String, dynamic> option) {
    final _$actionInfo = _$_BookingStoreActionController.startAction(
        name: '_BookingStore.addRadioOption');
    try {
      return super.addRadioOption(option);
    } finally {
      _$_BookingStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addMultiOption(Map<String, dynamic> option) {
    final _$actionInfo = _$_BookingStoreActionController.startAction(
        name: '_BookingStore.addMultiOption');
    try {
      return super.addMultiOption(option);
    } finally {
      _$_BookingStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void removeOption(Map<String, dynamic> option) {
    final _$actionInfo = _$_BookingStoreActionController.startAction(
        name: '_BookingStore.removeOption');
    try {
      return super.removeOption(option);
    } finally {
      _$_BookingStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void removeOptionByValues(Map<String, dynamic> targetOption) {
    final _$actionInfo = _$_BookingStoreActionController.startAction(
        name: '_BookingStore.removeOptionByValues');
    try {
      return super.removeOptionByValues(targetOption);
    } finally {
      _$_BookingStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void removeOptionsById(int optionId) {
    final _$actionInfo = _$_BookingStoreActionController.startAction(
        name: '_BookingStore.removeOptionsById');
    try {
      return super.removeOptionsById(optionId);
    } finally {
      _$_BookingStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  bool optionExists(Map<String, dynamic> targetOption) {
    final _$actionInfo = _$_BookingStoreActionController.startAction(
        name: '_BookingStore.optionExists');
    try {
      return super.optionExists(targetOption);
    } finally {
      _$_BookingStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
options: ${options},
selectedOptions: ${selectedOptions}
    ''';
  }
}
