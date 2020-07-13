// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars

class S {
  S();
  
  static S current;
  
  static const AppLocalizationDelegate delegate =
    AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false) ? locale.languageCode : locale.toString();
    final localeName = Intl.canonicalizedLocale(name); 
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      S.current = S();
      
      return S.current;
    });
  } 

  static S of(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Boring Remover`
  String get app_name {
    return Intl.message(
      'Boring Remover',
      name: 'app_name',
      desc: '',
      args: [],
    );
  }

  /// `Activity`
  String get activity {
    return Intl.message(
      'Activity',
      name: 'activity',
      desc: '',
      args: [],
    );
  }

  /// `Loading`
  String get loading {
    return Intl.message(
      'Loading',
      name: 'loading',
      desc: '',
      args: [],
    );
  }

  /// `accessibility:`
  String get accessibility {
    return Intl.message(
      'accessibility:',
      name: 'accessibility',
      desc: '',
      args: [],
    );
  }

  /// `price:`
  String get price {
    return Intl.message(
      'price:',
      name: 'price',
      desc: '',
      args: [],
    );
  }

  /// `participants:`
  String get participants {
    return Intl.message(
      'participants:',
      name: 'participants',
      desc: '',
      args: [],
    );
  }

  /// `TODO List`
  String get todoList {
    return Intl.message(
      'TODO List',
      name: 'todoList',
      desc: '',
      args: [],
    );
  }

  /// `{p1} {p2} {p3} {p4}`
  String format_date(Object p1, Object p2, Object p3, Object p4) {
    return Intl.message(
      '$p1 $p2 $p3 $p4',
      name: 'format_date',
      desc: '',
      args: [p1, p2, p3, p4],
    );
  }

  /// `Monday`
  String get monday {
    return Intl.message(
      'Monday',
      name: 'monday',
      desc: '',
      args: [],
    );
  }

  /// `Tuesday`
  String get tuesday {
    return Intl.message(
      'Tuesday',
      name: 'tuesday',
      desc: '',
      args: [],
    );
  }

  /// `Wednesday`
  String get wednesday {
    return Intl.message(
      'Wednesday',
      name: 'wednesday',
      desc: '',
      args: [],
    );
  }

  /// `Thursday`
  String get thursday {
    return Intl.message(
      'Thursday',
      name: 'thursday',
      desc: '',
      args: [],
    );
  }

  /// `Friday`
  String get friday {
    return Intl.message(
      'Friday',
      name: 'friday',
      desc: '',
      args: [],
    );
  }

  /// `Saturday`
  String get saturday {
    return Intl.message(
      'Saturday',
      name: 'saturday',
      desc: '',
      args: [],
    );
  }

  /// `Sunday`
  String get sunday {
    return Intl.message(
      'Sunday',
      name: 'sunday',
      desc: '',
      args: [],
    );
  }

  /// `january`
  String get january {
    return Intl.message(
      'january',
      name: 'january',
      desc: '',
      args: [],
    );
  }

  /// `february`
  String get february {
    return Intl.message(
      'february',
      name: 'february',
      desc: '',
      args: [],
    );
  }

  /// `march`
  String get march {
    return Intl.message(
      'march',
      name: 'march',
      desc: '',
      args: [],
    );
  }

  /// `april`
  String get april {
    return Intl.message(
      'april',
      name: 'april',
      desc: '',
      args: [],
    );
  }

  /// `may`
  String get may {
    return Intl.message(
      'may',
      name: 'may',
      desc: '',
      args: [],
    );
  }

  /// `june`
  String get june {
    return Intl.message(
      'june',
      name: 'june',
      desc: '',
      args: [],
    );
  }

  /// `july`
  String get july {
    return Intl.message(
      'july',
      name: 'july',
      desc: '',
      args: [],
    );
  }

  /// `august`
  String get august {
    return Intl.message(
      'august',
      name: 'august',
      desc: '',
      args: [],
    );
  }

  /// `september`
  String get september {
    return Intl.message(
      'september',
      name: 'september',
      desc: '',
      args: [],
    );
  }

  /// `october`
  String get october {
    return Intl.message(
      'october',
      name: 'october',
      desc: '',
      args: [],
    );
  }

  /// `november`
  String get november {
    return Intl.message(
      'november',
      name: 'november',
      desc: '',
      args: [],
    );
  }

  /// `december`
  String get december {
    return Intl.message(
      'december',
      name: 'december',
      desc: '',
      args: [],
    );
  }

  /// `Unknown`
  String get unknown {
    return Intl.message(
      'Unknown',
      name: 'unknown',
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
      Locale.fromSubtags(languageCode: 'zh'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    if (locale != null) {
      for (var supportedLocale in supportedLocales) {
        if (supportedLocale.languageCode == locale.languageCode) {
          return true;
        }
      }
    }
    return false;
  }
}