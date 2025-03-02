import 'package:flutter/material.dart';

import 'package:mttm_vis/param.dart';
import 'package:mttm_vis/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Model Training Task Management and Visualization Interactive System',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Padding(
            padding: EdgeInsets.only(left: 9 * scaleFactor),
            child: Text(
              '模型训练任务管理与可视化交互系统',
              style: TextStyle(
                fontSize: 8 * scaleFactor,
                color: ThemeColors.white, 
                fontFamily: 'Microsoft YaHei',
              ),
            ),
          ),
          titleSpacing: 0,
          elevation: 0,
          toolbarHeight: 24 * scaleFactor,
          backgroundColor: BackgroundColors.navigationBar,
        ),
        body: const Home(),
      )
    );
  }
}
