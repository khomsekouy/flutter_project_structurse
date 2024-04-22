/// [Json] is a type alias for Map<String, dynamic>, which is the type of
/// the decoded JSON object. This is used to improve readability.
typedef Json = Map<String, dynamic>;

/// Base response model for all response models.
abstract class BaseResModel {
  BaseResModel.fromJson(Json json) {
    message = json.getString('message');
    success = json.getBool('success');
  }
  late String message;
  late bool success;
}

// type safety: type casting (int, String, double, bool, List, Map)
extension MapTypeCasting on Json {
  int getInt(String key) {
    // check if key exists and validate type
    if (containsKey(key) && this[key] is int) {
      return this[key] as int;
    } else {
      // return 0 if key does not exist or type is not int
      return 0;
    }
  }

  String getString(String key) {
    if (containsKey(key) && this[key] is String) {
      return this[key] as String;
    } else {
      return '';
    }
  }

  double getDouble(String key) {
    if (containsKey(key) && this[key] is double) {
      return this[key] as double;
    } else {
      return 0;
    }
  }

  bool getBool(String key) {
    if (containsKey(key) && this[key] is bool) {
      return this[key] as bool;
    } else {
      return false;
    }
  }

  // List<dynamic> getList(String key) {
  //   if (containsKey(key) && this[key] is List<dynamic>) {
  //     return this[key] as List<dynamic>;
  //   } else {
  //     // return empty list if key does not exist or type is not List
  //     return <dynamic>[];
  //   }
  // }
  List<Map<String, dynamic>> getList(
      String key, {
        List<Map<String, dynamic>> defaultValue = const [],
      }) {
    if (this[key] is List) {
      if (this[key] is List<dynamic>) {
        return (this[key] as List<dynamic>)
            .map((e) => e as Map<String, dynamic>)
            .toList();
      } else {
        return this[key] as List<Map<String, dynamic>>;
      }
    } else {
      return defaultValue;
    }
  }

  Map<String, dynamic> getMap(String key) {
    if (containsKey(key) && this[key] is Map<String, dynamic>) {
      return this[key] as Map<String, dynamic>;
    } else {
      return <String, dynamic>{};
    }
  }
}
