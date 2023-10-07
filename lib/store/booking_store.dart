import 'package:mobx/mobx.dart';

import '../model/service_data_model.dart';
part 'booking_store.g.dart';

class BookingStore extends _BookingStore with _$BookingStore {}

abstract class _BookingStore with Store {
  @observable
  ObservableList<ObservableMap<String, dynamic>> options =
      ObservableList<ObservableMap<String, dynamic>>();

  @action
  void initQuantities(List<Option> options) {
    Iterable<Option> quantityOptions =
        options.where((option) => option.typeInt == 1);
    quantityOptions.forEach((option) {
      addQuantityOption(ObservableMap.of({'option': option.id, 'quantity': 1}));
    });
  }

  @action
  void addRadioOption(Map<String, dynamic> option) {
    removeOptionsById(option['option']);
    if (!optionExists(option)) {
      options.add(ObservableMap.of(option));
    }
  }

  @action
  void addMultiOption(Map<String, dynamic> option) {
    if (!optionExists(option)) {
      options.add(ObservableMap.of(option));
    } else {
      removeOptionByValues(option);
    }
  }

  @action
  void addQuantityOption(Map<String, dynamic> option) {
    if (!optionExists(option)) {
      options.add(ObservableMap.of(option));
    } else {
      increment(option);
    }
  }

  @action
  void increment(Map<String, dynamic> option) {
    option['quantity']++;
  }

  @action
  void decrement(Map<String, dynamic> option) {
    if (option['quantity'] != 1) {
      option['quantity']--;
    }
  }

  @action
  void removeOption(Map<String, dynamic> option) {
    options.remove(option);
  }

  @action
  void removeOptionByValues(Map<String, dynamic> targetOption) {
    final indexToRemove = options.indexWhere((option) {
      if (targetOption.containsKey('variant')) {
        return option['option'] == targetOption['option'] &&
            option['variant'] == targetOption['variant'];
      } else if (targetOption.containsKey('quantity')) {
        return option['option'] == targetOption['option'] &&
            option['quantity'] == targetOption['quantity'];
      }
      return false;
    });

    if (indexToRemove != -1) {
      options.removeAt(indexToRemove);
    }
  }

  @action
  void removeOptionsById(int optionId) {
    options.removeWhere((option) => option['option'] == optionId);
  }

  @action
  bool optionExists(Map<String, dynamic> targetOption) {
    return options.any((option) {
      if (targetOption.containsKey('variant')) {
        return option['option'] == targetOption['option'] &&
            option['variant'] == targetOption['variant'];
      } else if (targetOption.containsKey('quantity')) {
        return option['option'] == targetOption['option'] &&
            option['quantity'] == targetOption['quantity'];
      }
      return false;
    });
  }

  @computed
  List<ObservableMap<String, dynamic>> get selectedOptions => options
      .where((option) =>
          option.containsKey('variant') || option.containsKey('quantity'))
      .toList();

  @action
  ObservableMap<String, dynamic> getOption(int id) =>
      options.firstWhere((option) => option['option'] == id);
}
