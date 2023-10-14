import 'package:mobx/mobx.dart';

import '../model/service_data_model.dart';
part 'booking_store.g.dart';

class BookingStore extends _BookingStore with _$BookingStore {}

abstract class _BookingStore with Store {
  @observable
  ObservableList<ObservableMap<String, dynamic>> options =
      ObservableList<ObservableMap<String, dynamic>>();

  @observable
  num approximateArea = 0;

  @observable
  bool customize = false;

  @action
  void initQuantities(List<Option> options, num pricePerSqft) {
    Iterable<Option> quantityOptions =
        options.where((option) => option.typeInt == 1);
    quantityOptions.forEach((option) {
      if (option.unitPrice! > 0) {
        addQuantityOption(ObservableMap.of(
            {'option': option.id, 'quantity': 0, 'price': option.unitPrice}));
      } else {
        addQuantityOption(ObservableMap.of({
          'option': option.id,
          'quantity': 0,
          'price': 0,
          'area': option.area,
          'pricePerArea': pricePerSqft
        }));
      }
    });
  }

  @action
  void toggleCustomize() {
    Iterable<ObservableMap<String, dynamic>> package =
        selectedOptions.where((element) => element['package'] == true);
    if (package.isNotEmpty) {
      removeOptionsById(package.first['option']);
    }
    removeQuantityOptions();
    customize = !customize;
  }

  @action
  void removeQuantityOptions() {
    Iterable<ObservableMap<String, dynamic>> quantityOptions = selectedOptions
        .where((element) => element.containsKey('quantity'))
        .toList();
    if (quantityOptions.isNotEmpty) {
      quantityOptions.forEach((element) {
        element['quantity'] = 0;
        element['price'] = 0;
      });
    }
  }

  @action
  void addRadioOption(Map<String, dynamic> option) {
    removeOptionsById(option['option']);
    if (!optionExists(option)) {
      options.add(ObservableMap.of(option));
    }
  }

  @action
  void addPackageOption(Map<String, dynamic> option) {
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
    }
  }

  @action
  void increment(ObservableMap<String, dynamic> option) {
    option['quantity']++;
    if (option['unitPrice'] != null) {
      option['price'] = option['unitPrice'] * option['quantity'];
    } else {
      option['price'] =
          (option['area'] * option['pricePerArea']) * option['quantity'];
    }
  }

  @action
  void decrement(ObservableMap<String, dynamic> option) {
    if (option['quantity'] != 0) {
      option['quantity']--;
      if (option['unitPrice'] != null) {
        option['price'] = option['unitPrice'] * option['quantity'];
      } else {
        option['price'] =
            (option['area'] * option['pricePerArea']) * option['quantity'];
      }
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

  @action
  ObservableMap<String, dynamic> getOption(int id) =>
      options.firstWhere((option) => option['option'] == id);

  @computed
  List<ObservableMap<String, dynamic>> get selectedOptions => options
      .where((option) =>
          option.containsKey('variant') || option.containsKey('quantity'))
      .toList();

  @computed
  num get subTotal {
    num total = 0;
    selectedOptions.forEach((option) {
      if (option['price'] != null) {
        total += (option['price']);
      }
    });
    return total;
  }

  @computed
  num get getApproximateArea {
    num area = 0;
    selectedOptions.forEach((option) {
      if (option.containsKey('package')) {
        area += option['packageArea'];
      }
      if (option.containsKey('area')) {
        area += (option['area'] * option['quantity']);
      }
    });
    return area;
  }

  @computed
  String get customizeValue => customize.toString();

  @computed
  String get descriptionValue {
    if (!customize) {
      Iterable<ObservableMap<String, dynamic>> options =
          selectedOptions.where((element) => element['package'] == true);
      if (options.isNotEmpty) {
        return options.firstOrNull!['description'];
      }
      return '';
    }
    return '';
  }
}
