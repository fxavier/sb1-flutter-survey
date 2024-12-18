import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:survey_app/config/back4app_config.dart';
import 'package:survey_app/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await Parse().initialize(
    Back4appConfig.applicationId,
    Back4appConfig.serverUrl,
    clientKey: Back4appConfig.clientKey,
    debug: true,
  );
  
  runApp(const SurveyApp());
}