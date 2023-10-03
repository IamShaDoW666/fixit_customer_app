import 'package:mobx/mobx.dart';
part 'booking_store.g.dart';

class OptionVariant {
  int optionId;
  int? variantId;
  int? quantity;

  OptionVariant({required this.optionId, this.variantId, this.quantity});
}

class BookingStore extends _BookingStore with _$BookingStore {}

abstract class _BookingStore with Store {
  @observable
  List<OptionVariant> selectedOptions = [];

  @action
  selectVariant(int optionId, int? variantId, int? quantity) {
    if (1 == 1) {
      if (variantId != null) {
        selectedOptions.add(OptionVariant(
            optionId: optionId, variantId: variantId, quantity: null));
      } else {
        selectedOptions.add(OptionVariant(
            optionId: optionId, quantity: quantity, variantId: null));
      }
    }
  }
}
