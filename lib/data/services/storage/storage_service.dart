import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:getx_learn/core/utils/keys.dart';

class StorageService extends GetxService {
  late GetStorage _box;

  Future<StorageService> init() async {
    _box = GetStorage();
    await _box.writeIfNull(taskKey, []);
    return this;
  }

  // T is generic type. For eg, if you store in List it will return List, if you store String it will return String.
  T read<T>(String key) {
    return _box.read(key);
  }

  void write(String key, dynamic value) async {
    await _box.write(key, value);
  }
}
