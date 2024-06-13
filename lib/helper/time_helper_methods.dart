//return a formatted time string

import 'package:cloud_firestore/cloud_firestore.dart';

String formatDate(Timestamp timestamp) {
  //time stamp is the object we retrieve from the firebase
  //so to display it, lets convevrt it into a string
  DateTime dateTime = timestamp.toDate();

  //get year
  String year = dateTime.year.toString();

  //get month
  String month = dateTime.month.toString();

  //get day
  String day = dateTime.day.toString();

  //final; formatted date
  String formattedData = day + '-' + month + '-' + year;

  return formattedData;
}
