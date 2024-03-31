import 'package:booking_system_flutter/model/service_detail_response.dart';
import 'package:booking_system_flutter/model/tax_detail_model.dart';
import 'package:booking_system_flutter/network/rest_apis.dart';
import 'package:mobx/mobx.dart';
import 'package:nb_utils/nb_utils.dart';

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
  int providerId = 0;

  @observable
  String providerName = '';

  @observable
  bool customize = false;

  @observable
  num pricePerSqft = 0;

  @observable
  List<TaxData> taxes = List.empty();

  @observable
  String addressType = '';

  @observable
  String home = '';

  @observable
  String apartment = '';

  @observable
  String building = '';

  @action
  void initQuantities(List<Option> options, num pricePerSqft) {
    Iterable<Option> quantityOptions =
        options.where((option) => option.typeInt == 1);
    Iterable<Option> multiplyOptions =
        options.where((option) => option.typeInt == 3);

    quantityOptions.forEach((option) {
      if (option.unitPrice! > 0) {
        addQuantityOption(ObservableMap.of({
          'option': option.id,
          'quantity': 0,
          'type': 'quantity',
          'unitPrice': option.unitPrice,
          'price': 0
        }));
      } else {
        addQuantityOption(ObservableMap.of({
          'option': option.id,
          'quantity': 0,
          'price': 0,
          'type': 'quantity',
          'area': option.area,
          'pricePerArea': pricePerSqft
        }));
      }
    });

    multiplyOptions.forEach((option) {
      addQuantityOption(ObservableMap.of({
        'option': option.id,
        'quantity': 0,
        'type': 'multiply',
        'multiplyOption': option.multiplyOption
      }));
    });

    Option? packageOption =
        options.where((option) => option.typeInt == 2).firstOrNull;
    if (packageOption != null) {
      Variant variant = packageOption.variants![0];
      addPackageOption({
        'option': packageOption.id,
        'variant': variant.id,
        'description': variant.description,
        'package': true,
        'type': 'package',
        'packageArea': variant.packageArea ?? 0,
        'optionVariants': variant.optionVariants,
        'price': (variant.price != null && variant.price! > 0)
            ? variant.price
            : (variant.packageArea != null)
                ? variant.packageArea! * pricePerSqft
                : null
      });
    }
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
      options.forEach((e) {
        if (option['optionVariants'].length != 0) {
          if (e['quantity'] != null) {
            if (option['optionVariants']
                    .firstWhere((element) => element.optionId == e['option'])
                    .quantity !=
                null) {
              e['quantity'] = option['optionVariants']
                  .firstWhere((element) => element.optionId == e['option'])
                  .quantity;
              calculate(e);
            }
          }
        }
      });
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
    calculate(option);
  }

  @action
  void decrement(ObservableMap<String, dynamic> option) {
    if (option['quantity'] != 0) {
      option['quantity']--;
      calculate(option);
    }
  }

  @action
  void removeOption(Map<String, dynamic> option) {
    options.remove(option);
  }

  @action
  Future<void> getTaxes(int providerId) async {
    if (providerId < 1) {
      return;
    }
    List<TaxData> taxData = await getTaxDetails(providerId: providerId);
    taxes = taxData;
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
  void calculate(Map<String, dynamic> option) {
    if (option['multiplyOption'] != null) {
    } else {
      if (option['unitPrice'] != null) {
        option['price'] = option['unitPrice'] * option['quantity'];
      } else {
        option['price'] =
            (option['area'] * option['pricePerArea']) * option['quantity'];
      }
    }
    Iterable<ObservableMap<String, dynamic>> multiplyOptions =
        options.where((option) => option['type'] == 'multiply');
    multiplyOptions.forEach((multiplyOption) {
      multiplyOption['price'] =
          getOption(multiplyOption['multiplyOption'])['price'] *
              multiplyOption['quantity'];
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
      if (option['type'] == 'multiply') {
        ObservableMap<String, dynamic> multiplyOption =
            getOption(option['multiplyOption']);
        if (option['price'] == (multiplyOption['price'] * option['quantity']))
          total -= multiplyOption['price'];
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

  @computed
  bool get providerSelected => providerName != '';
}
