import 'package:mobx/mobx.dart';
part 'booking_store.g.dart';

class BookingStore extends _BookingStore with _$BookingStore {}

abstract class _BookingStore with Store {
  @observable
  ObservableList<Map<String, dynamic>> options =
      ObservableList<Map<String, dynamic>>();

  @action
  void addRadioOption(Map<String, dynamic> option) {
    removeOptionsById(option['option']);
    if (!optionExists(option)) {
      options.add(option);
    }
  }

  @action
  void addMultiOption(Map<String, dynamic> option) {
    if (!optionExists(option)) {
      options.add(option);
    } else {
      removeOptionByValues(option);
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
  List<Map<String, dynamic>> get selectedOptions => options
      .where((option) =>
          option.containsKey('variant') || option.containsKey('quantity'))
      .toList();
}
