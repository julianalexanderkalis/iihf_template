// ignore_for_file: slash_for_doc_comments

import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';
import 'package:file_picker/file_picker.dart';
import 'package:csv/csv.dart';
import 'dart:convert' show utf8;
import 'package:flutter/services.dart' show rootBundle;

 List<List<dynamic>> data = [];
  loadAsset() async {
    final myData = await rootBundle.loadString("assets/csv/final.csv");
    List<List<dynamic>> csvTable = CsvToListConverter().convert(myData);

    var data_raw = csvTable;
    var data = data_raw.getRange(1,3);
    return data.toList();
  }


  defineUser() async {
    var plyrs = await loadAsset();
    List<dynamic> result = plyrs[0][0].split(';');
    // var player_name = result[4] + ' ' + result[3] + ' ' +  result[2];
    var p_name = result.sublist(2,5).reversed.join(' ');
    var p_height = result[5];
    var p_weight = result[6];
    var p_team = result[7];
    var p_position = result[8];
    var p_sac = result[9];
    var p_gwg = result[10];
    var p_goal = result[11];
    var p_assist = result[12];
    var p_score = result[13];
    return ([p_name, p_height, p_weight, p_weight, p_team, p_position, p_sac, p_gwg, p_goal, p_assist, p_score]);
  }
  