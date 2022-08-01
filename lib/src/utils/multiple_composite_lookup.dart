import 'package:intl/message_lookup_by_library.dart';
import 'package:intl/src/intl_helpers.dart';

String lookingForModule = "";

class MultipleCompositeMessageLookup implements MessageLookup {
  Map<Function, CompositeMessageLookup> lookups = {};

  /// Look up the message with the given [name] and [locale] and return the
  /// translated version with the values in [args] interpolated.  If nothing is
  /// found, return the result of [ifAbsent] or [messageText].
  String? lookupMessage(String? messageText, String? locale, String? name, List<Object>? args, String? meaning, {MessageIfAbsent? ifAbsent}) {
    for (final lookup in lookups.values) {
      var isAbsent = false;
      final res = lookup.lookupMessage(messageText, locale, name, args, meaning, ifAbsent: (s, a) {
        isAbsent = true;
        return '';
      });

      if (!isAbsent) return res;
    }

    return messageText;
  }

  /// If we do not already have a locale for [localeName] then
  /// [findLocale] will be called and the result stored as the lookup
  /// mechanism for that locale.
  void addLocale(String localeName, Function findLocale) {
    final lookup = lookups.putIfAbsent(
      findLocale,
      () => CompositeMessageLookup(),
    );

    lookup.addLocale(localeName, findLocale);
  }
}
