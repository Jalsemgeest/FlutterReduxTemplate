import 'dart:typed_data';
import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:redux/redux.dart';
import '../store/storage.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Store<StorageState> _store;

  @override
  void initState() {
    super.initState();

    _store = StoreProvider.of<StorageState>(context, listen: false);
  }

  @override
  void dispose() {
    print("Disposing home");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // print(widget.hunts);
    return StoreConnector<StorageState, _HomeViewModel>(converter: (store) {
      return _HomeViewModel(storageState: store.state);
    }, builder: (context, vm) {
      return const HomeView();
    });
  }
}

class _HomeViewModel {
  final StorageState storageState;

  const _HomeViewModel({required this.storageState});
}

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final RestorableDateTime _selectedDate =
      RestorableDateTime(DateTime(2021, 7, 25));
  late final RestorableRouteFuture<DateTime?> _restorableDatePickerRouteFuture =
      RestorableRouteFuture<DateTime?>(
    onComplete: _selectDate,
    onPresent: (NavigatorState navigator, Object? arguments) {
      return navigator.restorablePush(
        _datePickerRoute,
        arguments: _selectedDate.value.millisecondsSinceEpoch,
      );
    },
  );

  void _selectDate(DateTime? newSelectedDate) {
    if (newSelectedDate != null) {
      setState(() {
        _selectedDate.value = newSelectedDate;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
              'Selected: ${_selectedDate.value.day}/${_selectedDate.value.month}/${_selectedDate.value.year}'),
        ));
      });
    }
  }

  @pragma('vm:entry-point')
  static Route<DateTime> _datePickerRoute(
    BuildContext context,
    Object? arguments,
  ) {
    return DialogRoute<DateTime>(
      context: context,
      builder: (BuildContext context) {
        return DatePickerDialog(
          restorationId: 'date_picker_dialog',
          initialEntryMode: DatePickerEntryMode.calendarOnly,
          initialDate: DateTime.fromMillisecondsSinceEpoch(arguments! as int),
          firstDate: DateTime(2021),
          lastDate: DateTime(2022),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Date"),
        actions: [
          IconButton(
              onPressed: () => {_restorableDatePickerRouteFuture.present()},
              icon: const Icon(Icons.calendar_month))
        ],
      ),
      body: Text("Cool"),
    );
  }
}
