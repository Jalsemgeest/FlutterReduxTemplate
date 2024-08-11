import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'store/storage.dart';

void main() {
  final store = Store<StorageState>(
    reducer,
    initialState: const StorageState(),
    middleware: [appStateMiddleware],
  );
  runApp(MainApp(store: store));
  updateFromStorage(store);
}

class MainApp extends StatelessWidget {
  final Store<StorageState> store;

  const MainApp({super.key, required this.store});

  @override
  Widget build(BuildContext context) {
    return StoreProvider(
        store: store,
        child: const MaterialApp(
          title: "Test app",
          home: Text("Test"),
        ));
  }
}
