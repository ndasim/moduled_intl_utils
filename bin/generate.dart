library moduled_intl_utils;

import 'package:moduled_intl_utils/intl_utils.dart';
import 'package:moduled_intl_utils/src/generator/generator_exception.dart';
import 'package:moduled_intl_utils/src/utils/utils.dart';

Future<void> main(List<String> args) async {
  try {
    var generator = Generator(args);
    await generator.generateAsync();
  } on GeneratorException catch (e) {
    exitWithError(e.message);
  } catch (e, s) {
    exitWithError('Failed to generate localization files.\n$e\n$s');
  }
}
