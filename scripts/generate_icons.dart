import 'package:flutter_launcher_icons/android.dart';
import 'package:flutter_launcher_icons/constants.dart';
import 'package:flutter_launcher_icons/custom_exceptions.dart';
import 'package:flutter_launcher_icons/ios.dart';
import 'package:flutter_launcher_icons/main.dart' as launcher_icons;
import 'package:flutter_launcher_icons/web.dart';
import 'package:flutter_launcher_icons/windows.dart';
import 'package:flutter_launcher_icons/macos.dart';

void main(List<String> arguments) async {
  try {
    await launcher_icons.createIconsFromConfig();
    print('✅ Icônes générées avec succès !');
  } catch (e) {
    print('❌ Erreur lors de la génération des icônes: $e');
  }
}
