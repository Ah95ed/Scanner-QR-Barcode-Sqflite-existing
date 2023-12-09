// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Name :`
  String get name {
    return Intl.message(
      'Name :',
      name: 'name',
      desc: '',
      args: [],
    );
  }

  /// `Main Screen`
  String get mainScreen {
    return Intl.message(
      'Main Screen',
      name: 'mainScreen',
      desc: '',
      args: [],
    );
  }

  /// `IsEmpty`
  String get isempty {
    return Intl.message(
      'IsEmpty',
      name: 'isempty',
      desc: '',
      args: [],
    );
  }

  /// `Add Data`
  String get addData {
    return Intl.message(
      'Add Data',
      name: 'addData',
      desc: '',
      args: [],
    );
  }

  /// `Barcode :`
  String get barcode {
    return Intl.message(
      'Barcode :',
      name: 'barcode',
      desc: '',
      args: [],
    );
  }

  /// `Cost :`
  String get cost {
    return Intl.message(
      'Cost :',
      name: 'cost',
      desc: '',
      args: [],
    );
  }

  /// `Sell : `
  String get sell {
    return Intl.message(
      'Sell : ',
      name: 'sell',
      desc: '',
      args: [],
    );
  }

  /// `Done`
  String get done {
    return Intl.message(
      'Done',
      name: 'done',
      desc: '',
      args: [],
    );
  }

  /// `Error`
  String get error {
    return Intl.message(
      'Error',
      name: 'error',
      desc: '',
      args: [],
    );
  }

  /// `Waiting ... `
  String get wait {
    return Intl.message(
      'Waiting ... ',
      name: 'wait',
      desc: '',
      args: [],
    );
  }

  /// `Edit`
  String get edit {
    return Intl.message(
      'Edit',
      name: 'edit',
      desc: '',
      args: [],
    );
  }

  /// `Close`
  String get close {
    return Intl.message(
      'Close',
      name: 'close',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure to delete`
  String get confirmeDelete {
    return Intl.message(
      'Are you sure to delete',
      name: 'confirmeDelete',
      desc: '',
      args: [],
    );
  }

  /// `Yes`
  String get yes {
    return Intl.message(
      'Yes',
      name: 'yes',
      desc: '',
      args: [],
    );
  }

  /// `No`
  String get no {
    return Intl.message(
      'No',
      name: 'no',
      desc: '',
      args: [],
    );
  }

  /// `Edit Data`
  String get editData {
    return Intl.message(
      'Edit Data',
      name: 'editData',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get home {
    return Intl.message(
      'Home',
      name: 'home',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get setting {
    return Intl.message(
      'Settings',
      name: 'setting',
      desc: '',
      args: [],
    );
  }

  /// `Orders Account`
  String get orders_account {
    return Intl.message(
      'Orders Account',
      name: 'orders_account',
      desc: '',
      args: [],
    );
  }

  /// `Export`
  String get export {
    return Intl.message(
      'Export',
      name: 'export',
      desc: '',
      args: [],
    );
  }

  /// `Import`
  String get import {
    return Intl.message(
      'Import',
      name: 'import',
      desc: '',
      args: [],
    );
  }

  /// `Exported Is Done`
  String get ExportedisDone {
    return Intl.message(
      'Exported Is Done',
      name: 'ExportedisDone',
      desc: '',
      args: [],
    );
  }

  /// `Terms of Service | Privacy Policy`
  String get team_policy {
    return Intl.message(
      'Terms of Service | Privacy Policy',
      name: 'team_policy',
      desc: '',
      args: [],
    );
  }

  /// `Update Prices`
  String get update_prices {
    return Intl.message(
      'Update Prices',
      name: 'update_prices',
      desc: '',
      args: [],
    );
  }

  /// `Delete All Data`
  String get delete_all {
    return Intl.message(
      'Delete All Data',
      name: 'delete_all',
      desc: '',
      args: [],
    );
  }

  /// `Update Cost`
  String get update_cost {
    return Intl.message(
      'Update Cost',
      name: 'update_cost',
      desc: '',
      args: [],
    );
  }

  /// `Update Sell`
  String get update_sell {
    return Intl.message(
      'Update Sell',
      name: 'update_sell',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get delete {
    return Intl.message(
      'Delete',
      name: 'delete',
      desc: '',
      args: [],
    );
  }

  /// `Select`
  String get select {
    return Intl.message(
      'Select',
      name: 'select',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
