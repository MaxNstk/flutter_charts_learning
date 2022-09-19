
import 'package:charts_example/app_controller.dart';
import 'package:charts_example/category_balance_provider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Title!'),
        actions: [
          Switch(
              value: true,
              onChanged: (value){
                AppController.instance.changeTheme;
              }
          ),
        ],
      ),
      body: FutureBuilder(
          future: CategoryBalanceProvider.getCategoriesBalance(touchedIndex),
          builder: (context, snapshot){
        if (snapshot.connectionState == ConnectionState.done){
          if (snapshot.hasData){
            final data = snapshot.data as List<PieChartSectionData>;
            return Center(
                child: PieChart(
                  swapAnimationDuration: const Duration(milliseconds: 150),
                  swapAnimationCurve: Curves.linear,
                  PieChartData(
                      sections: data,
                      centerSpaceRadius: 40,
                      pieTouchData: PieTouchData(
                          touchCallback: (FlTouchEvent  event, pieTouchResponse){
                            setState(() {
                              if (!event.isInterestedForInteractions ||
                                  pieTouchResponse == null ||
                                  pieTouchResponse.touchedSection == null){
                                touchedIndex = -1;
                                return;
                              }
                              touchedIndex = pieTouchResponse.touchedSection!.touchedSectionIndex;
                            });
                          }
                      )
                  ),
                )
            );
          }
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
    )
    );
  }

  List<PieChartSectionData> showingSections(){
    return List.generate(4, (i){
      final isTouched = i == touchedIndex;
      final fontSize = isTouched? 25.0 : 16.0;
      final radius = isTouched? 60.0 : 50.0;
      switch (i){
        case 0:
          return  PieChartSectionData(
              color: Colors.yellow,
              value : 60,
              title: 'Nina',
              radius: radius,
              titleStyle: TextStyle(
                  fontSize: fontSize,
                  fontWeight: FontWeight.bold,
                  color: Colors.black
              )
          );
        case 1:
          return  PieChartSectionData(
              color: Colors.blue,
              value : 40,
              title: 'Adrian',
              radius: radius,
              titleStyle: TextStyle(
                  fontSize: fontSize,
                  fontWeight: FontWeight.bold,
                  color: Colors.black
              )
          );
        case 2:
          return  PieChartSectionData(
              color: Colors.red,
              value : 30,
              title: 'Lucas',
              radius: radius,
              titleStyle: TextStyle(
                  fontSize: fontSize,
                  fontWeight: FontWeight.bold,
                  color: Colors.black
              )
          );
        case 3:
          return  PieChartSectionData(
              color: Colors.green,
              value : 200,
              title: 'Max',
              radius: radius,
              titleStyle: TextStyle(
                  fontSize: fontSize,
                  fontWeight: FontWeight.bold,
                  color: Colors.black
              )
          );
        default:
          throw Error();
      }
    });
  }
}
