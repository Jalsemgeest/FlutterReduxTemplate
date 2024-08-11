import 'package:redux/redux.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'storage.dart';
import "dart:convert";

const storageState = "storageState";

void saveStateToStorage(StorageState state) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString(storageState, json.encode(state.toJson()));
}

Future<String?> loadStateFromStorage() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString(storageState);
}
