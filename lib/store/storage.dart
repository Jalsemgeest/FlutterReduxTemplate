import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'helpers.dart';
import "dart:convert";

// Define the AppState which holds the state of the application
@immutable
class StorageState {
  final bool fun;
  final String id;

  const StorageState({this.fun = true, this.id = ""});

  StorageState copyWith({
    bool? fun,
    String? id,
  }) {
    return StorageState(
      fun: fun ?? this.fun,
      id: id ?? this.id,
    );
  }

  static StorageState fromJson(dynamic json) {
    return StorageState(
      fun: json['fun'] || true,
      id: json['id'],
    );
  }

  Map toJson() => {
        "fun": this.fun,
        "id": this.id,
      };
}

// Actions

class LoadStateFromStorage {
  final String storageState;
  const LoadStateFromStorage({required this.storageState});
}

// Reducer
StorageState reducer(StorageState prevState, dynamic action) {
  if (action is LoadStateFromStorage) {
    dynamic storageJson = json.decode(action.storageState);
    return StorageState.fromJson(storageJson);
  }

  return prevState;
}

void updateFromStorage(Store<StorageState> store) async {
  String? storedState = await loadStateFromStorage();
  print("StoredState: $storedState");
  if (storedState != null) {
    store.dispatch(LoadStateFromStorage(storageState: storedState));
  }
}

void appStateMiddleware(
    Store<StorageState> store, action, NextDispatcher next) {
  // This is where you could add logging or other middleware
  next(action);

  print("Action in middleware: $action");

  List<dynamic> saveActions = [];

  if (saveActions.contains(action.runtimeType)) {
    print("Saving state to storage.");
    saveStateToStorage(store.state);
  }
}
