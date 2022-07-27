import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:up_template/models/Content/Content.dart';

String? latitudeAuto;
String? longitudeAuto;
late StreamSubscription getStreamSubscription;
Position? currentPosition;
// ignore: prefer_typing_uninitialized_variables
var update;
late GenericContent content;
int? idGeral;
