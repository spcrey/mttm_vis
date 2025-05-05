import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mttm_vis/creating_new_task.dart';
import 'package:mttm_vis/data.dart';

import 'package:mttm_vis/param.dart';
import 'package:mttm_vis/task_list.dart';

enum TrainingTaskSelectableItem {
  taskList('训练列表'),
  creatingNewTask('创建新任务');

  final String text;
  const TrainingTaskSelectableItem(this.text);
}

class TrainingTask extends StatefulWidget {
  const TrainingTask({
    super.key,
  });

  @override
  State<TrainingTask> createState() => _TrainingTaskState();
}

class _TrainingTaskState extends State<TrainingTask> {
  TrainingTaskSelectableItem _selectedItem = TrainingTaskSelectableItem.taskList;

  List<String> datasetNames = [];

  void _setSelecedItemFun(TrainingTaskSelectableItem selecedItem) {
    setState(() {
      _selectedItem = selecedItem;
    });
  }

  void _toCreateNewTaskFun() {
    trainTaskListItems.insert(0, TrainTaskItem(
      name: "CT5Y",
      createDateTime: DateTime(2025, 2, 26),
      status: TaskListItemStatus.inProgress
    ));
    Timer(const Duration(seconds: 2), () {
      setState(() {
        _selectedItem = TrainingTaskSelectableItem.taskList;
      });
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Container(
      color: BackgroundColors.body,
      padding: const EdgeInsets.all(12 * scaleFactor),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TrainingTaskItem(
                selecedItem: TrainingTaskSelectableItem.taskList,
                isSelect: _selectedItem == TrainingTaskSelectableItem.taskList,
                setSelecedItemFun: _setSelecedItemFun
              ),
              const SizedBox(
                width: 12 * scaleFactor,
              ),
              TrainingTaskItem(
                selecedItem: TrainingTaskSelectableItem.creatingNewTask,
                isSelect: _selectedItem == TrainingTaskSelectableItem.creatingNewTask,
                setSelecedItemFun: _setSelecedItemFun
              ),
            ],
          ),
          const SizedBox(
            height: 12 * scaleFactor,
          ),
          switch(_selectedItem) {
            TrainingTaskSelectableItem.taskList => const TaskList(),
            TrainingTaskSelectableItem.creatingNewTask => CreatingNewTask(
              toCreateNewTaskFun: _toCreateNewTaskFun
            ),
          }
        ],
      ),
    );
  }
}


class TrainingTaskItem extends StatefulWidget {
  final TrainingTaskSelectableItem selecedItem;
  final bool isSelect;
  final Function(TrainingTaskSelectableItem) setSelecedItemFun;

  const TrainingTaskItem({
    super.key, required this.selecedItem, required this.isSelect, required this.setSelecedItemFun,
  });

  @override
  State<TrainingTaskItem> createState() => _TrainingTaskItemState();
}

class _TrainingTaskItemState extends State<TrainingTaskItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.isSelect == false) {
          widget.setSelecedItemFun(widget.selecedItem);
          logger.d('${widget.selecedItem.text} is clicked');
        }
        
      },
      child: MouseRegion(
        cursor: widget.isSelect ? MouseCursor.defer : SystemMouseCursors.click,
        child: Container(
          decoration: BoxDecoration(
            border: widget.isSelect ? const Border(
              bottom: BorderSide(color: ThemeColors.blue, width: 1 * scaleFactor),
            ) : null,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10 * scaleFactor,
                child: Center(
                  child: Text(
                    widget.selecedItem.text,
                    style: TextStyle(
                      fontSize: 8 * scaleFactor,
                      color: widget.isSelect ? ThemeColors.blue : ThemeColors.lightWhite,
                      fontFamily: 'Microsoft YaHei',
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 3 * scaleFactor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}



