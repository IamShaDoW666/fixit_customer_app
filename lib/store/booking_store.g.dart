// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$BookingStore on _BookingStore, Store {
  late final _$selectedOptionsAtom =
      Atom(name: '_BookingStore.selectedOptions', context: context);

  @override
  List<OptionVariant> get selectedOptions {
    _$selectedOptionsAtom.reportRead();
    return super.selectedOptions;
  }

  @override
  set selectedOptions(List<OptionVariant> value) {
    _$selectedOptionsAtom.reportWrite(value, super.selectedOptions, () {
      super.selectedOptions = value;
    });
  }

  late final _$_BookingStoreActionController =
      ActionController(name: '_BookingStore', context: context);

  @override
  dynamic selectVariant(int optionId, int? variantId, int? quantity) {
    final _$actionInfo = _$_BookingStoreActionController.startAction(
        name: '_BookingStore.selectVariant');
    try {
      return super.selectVariant(optionId, variantId, quantity);
    } finally {
      _$_BookingStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
selectedOptions: ${selectedOptions}
    ''';
  }
}
