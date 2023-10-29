// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$BookingStore on _BookingStore, Store {
  Computed<List<ObservableMap<String, dynamic>>>? _$selectedOptionsComputed;

  @override
  List<ObservableMap<String, dynamic>> get selectedOptions =>
      (_$selectedOptionsComputed ??=
              Computed<List<ObservableMap<String, dynamic>>>(
                  () => super.selectedOptions,
                  name: '_BookingStore.selectedOptions'))
          .value;
  Computed<num>? _$subTotalComputed;

  @override
  num get subTotal => (_$subTotalComputed ??=
          Computed<num>(() => super.subTotal, name: '_BookingStore.subTotal'))
      .value;
  Computed<num>? _$getApproximateAreaComputed;

  @override
  num get getApproximateArea => (_$getApproximateAreaComputed ??= Computed<num>(
          () => super.getApproximateArea,
          name: '_BookingStore.getApproximateArea'))
      .value;
  Computed<String>? _$customizeValueComputed;

  @override
  String get customizeValue =>
      (_$customizeValueComputed ??= Computed<String>(() => super.customizeValue,
              name: '_BookingStore.customizeValue'))
          .value;
  Computed<String>? _$descriptionValueComputed;

  @override
  String get descriptionValue => (_$descriptionValueComputed ??=
          Computed<String>(() => super.descriptionValue,
              name: '_BookingStore.descriptionValue'))
      .value;

  late final _$optionsAtom =
      Atom(name: '_BookingStore.options', context: context);

  @override
  ObservableList<ObservableMap<String, dynamic>> get options {
    _$optionsAtom.reportRead();
    return super.options;
  }

  @override
  set options(ObservableList<ObservableMap<String, dynamic>> value) {
    _$optionsAtom.reportWrite(value, super.options, () {
      super.options = value;
    });
  }

  late final _$approximateAreaAtom =
      Atom(name: '_BookingStore.approximateArea', context: context);

  @override
  num get approximateArea {
    _$approximateAreaAtom.reportRead();
    return super.approximateArea;
  }

  @override
  set approximateArea(num value) {
    _$approximateAreaAtom.reportWrite(value, super.approximateArea, () {
      super.approximateArea = value;
    });
  }

  late final _$providerIdAtom =
      Atom(name: '_BookingStore.providerId', context: context);

  @override
  int get providerId {
    _$providerIdAtom.reportRead();
    return super.providerId;
  }

  @override
  set providerId(int value) {
    _$providerIdAtom.reportWrite(value, super.providerId, () {
      super.providerId = value;
    });
  }

  late final _$customizeAtom =
      Atom(name: '_BookingStore.customize', context: context);

  @override
  bool get customize {
    _$customizeAtom.reportRead();
    return super.customize;
  }

  @override
  set customize(bool value) {
    _$customizeAtom.reportWrite(value, super.customize, () {
      super.customize = value;
    });
  }

  late final _$_BookingStoreActionController =
      ActionController(name: '_BookingStore', context: context);

  @override
  void initQuantities(List<Option> options, num pricePerSqft) {
    final _$actionInfo = _$_BookingStoreActionController.startAction(
        name: '_BookingStore.initQuantities');
    try {
      return super.initQuantities(options, pricePerSqft);
    } finally {
      _$_BookingStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void toggleCustomize() {
    final _$actionInfo = _$_BookingStoreActionController.startAction(
        name: '_BookingStore.toggleCustomize');
    try {
      return super.toggleCustomize();
    } finally {
      _$_BookingStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void removeQuantityOptions() {
    final _$actionInfo = _$_BookingStoreActionController.startAction(
        name: '_BookingStore.removeQuantityOptions');
    try {
      return super.removeQuantityOptions();
    } finally {
      _$_BookingStoreActionController.endAction(_$actionInfo);
    }
  }

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
  void addPackageOption(Map<String, dynamic> option) {
    final _$actionInfo = _$_BookingStoreActionController.startAction(
        name: '_BookingStore.addPackageOption');
    try {
      return super.addPackageOption(option);
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
  void addQuantityOption(Map<String, dynamic> option) {
    final _$actionInfo = _$_BookingStoreActionController.startAction(
        name: '_BookingStore.addQuantityOption');
    try {
      return super.addQuantityOption(option);
    } finally {
      _$_BookingStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void increment(ObservableMap<String, dynamic> option) {
    final _$actionInfo = _$_BookingStoreActionController.startAction(
        name: '_BookingStore.increment');
    try {
      return super.increment(option);
    } finally {
      _$_BookingStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void decrement(ObservableMap<String, dynamic> option) {
    final _$actionInfo = _$_BookingStoreActionController.startAction(
        name: '_BookingStore.decrement');
    try {
      return super.decrement(option);
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
  ObservableMap<String, dynamic> getOption(int id) {
    final _$actionInfo = _$_BookingStoreActionController.startAction(
        name: '_BookingStore.getOption');
    try {
      return super.getOption(id);
    } finally {
      _$_BookingStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
options: ${options},
approximateArea: ${approximateArea},
providerId: ${providerId},
customize: ${customize},
selectedOptions: ${selectedOptions},
subTotal: ${subTotal},
getApproximateArea: ${getApproximateArea},
customizeValue: ${customizeValue},
descriptionValue: ${descriptionValue}
    ''';
  }
}
