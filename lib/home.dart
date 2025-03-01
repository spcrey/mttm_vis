import 'package:flutter/material.dart';

import 'package:mttm_vis/param.dart';
import 'package:mttm_vis/slidebar.dart';
import 'package:mttm_vis/training_task.dart';

class Home extends StatefulWidget {
  const Home({
    super.key,
  });

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  SlidebarSelectableItem _selecedItem = SlidebarSelectableItem.trainingTask;

  void _setSelecedItem(SlidebarSelectableItem selecedItem) {
    setState(() {
      _selecedItem = selecedItem;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
        children: [
          Container(
            color: BackgroundColors.slidebar,
            child: Slidebar(
              selecedItem: _selecedItem,
              setSelecedItemFun: _setSelecedItem,
            ),
          ),
          Expanded(
            child: switch(_selecedItem) {
              SlidebarSelectableItem.trainingTask => const TrainingTask(),
              SlidebarSelectableItem.visualization => Container(
                color: ThemeColors.blue
              ),
            },
          ),
        ],
    );
  }
}
