import 'dart:convert';
import 'package:collection/collection.dart';
import 'package:charts_example/dafult_client.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'consts.dart';

class CategoryBalanceProvider {

  static bool dataTaken = false;
  static List categories = [];

  static Future<List<PieChartSectionData>> getCategoriesBalance(int touchedIndex) async {
    if (!dataTaken) {
      dataTaken = true;
      var response = await CustomClient.client.get(DevelopmentRoutes.categoryBalance);
      if (response.statusCode != Http.OK_200) {
        throw Error();
      }
      dataTaken = true;
      var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
      categories = decodedResponse['categories'] as List;
    }
    return getSections(categories, touchedIndex);
  }

  static List<PieChartSectionData> getSections(List categories, int touchedIndex) {
    List<PieChartSectionData> pieData = <PieChartSectionData>[];

    categories.forEachIndexed((idx, element) {
      final isTouched = idx == touchedIndex;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 60.0 : 50.0;
      pieData.add(
          PieChartSectionData(
              color: COLORS[idx],
              value: element['percentage'] as double,
              title: element['name'] as String,
              radius: radius,
              titleStyle: TextStyle(
                  fontSize: fontSize,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
              )
          )
      );
    });
    return pieData;
  }
}