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
  var gwg = {"Simon Knak": 0, "Kasper SIMONTAIVAL": 0};

  for (var i = 0; i < data_raw.length; i++) {
    if (data_raw.elementAt(i)[4] == "Simon" &&
        data_raw.elementAt(i)[2] == "KNAK") {
      print(data_raw.elementAt(i));
      gwg["Simon Knak"] = data_raw.elementAt(i)[11];
    }
    if (data_raw.elementAt(i)[4] == "Kasper" &&
        data_raw.elementAt(i)[2] == "SIMONTAIVAL") {
      print(data_raw.elementAt(i));
      gwg["Kasper SIMONTAIVAL"] = data_raw.elementAt(i)[11];
    }
  }
  print(gwg);
  var data = data_raw.getRange(1, 3);
  //return data.toList();
  return gwg;
}

class Athlete {
  var name;
  var height;
  var weight;
  var team;
  var position;
  var sac;
  var gwg;
  var goal;
  var assist;
  var score;

  Athlete(this.name, this.height, this.weight, this.team, this.position,
      this.sac, this.gwg, this.goal, this.assist, this.score);

  void record() {
    print('$name asa $height asa $weight');
  }
}

// defineUser() async {
//   var plyrs = await loadAsset();
//   List<dynamic> result_1 = plyrs[0];
//   List<dynamic> result_2 = plyrs[1];

//   Athlete a1 = new Athlete(
//       result_1.sublist(2, 5).reversed.join(' '),
//       result_1[5],
//       result_1[6],
//       result_1[7],
//       result_1[8],
//       result_1[9],
//       result_1[10],
//       result_1[11],
//       result_1[12],
//       result_1[13]);

//   Athlete a2 = new Athlete(
//       result_2.sublist(2, 5).reversed.join(' '),
//       result_2[5],
//       result_2[6],
//       result_2[7],
//       result_2[8],
//       result_2[9],
//       result_2[10],
//       result_2[11],
//       result_2[12],
//       result_2[13]);

//   // return ([p_name, p_height, p_weight, p_team, p_position, p_sac, p_gwg, p_goal, p_assist, p_score]);
//   a1.record();
//   a2.record();
//   // return();
// }
