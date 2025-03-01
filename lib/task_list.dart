import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:mttm_vis/data.dart';
import 'package:mttm_vis/param.dart';

class TaskList extends StatelessWidget {
  const TaskList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (int i = 0; i < trainTaskListItems.length; i++) 
          Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: BackgroundColors.information,
                  border: Border.all(
                    color: BackgroundColors.line, 
                    width: 0.8 * scaleFactor,  
                  ),
                  borderRadius: BorderRadius.circular(2 * scaleFactor),
                ),
                padding: const EdgeInsets.fromLTRB(
                  12 * scaleFactor, 
                  6 * scaleFactor, 
                  12 * scaleFactor, 
                  6 * scaleFactor, 
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset(
                          'assets/icons/item_task.svg',
                          width: 12 * scaleFactor,
                          height: 12 * scaleFactor,
                        ),
                        const SizedBox(
                          width: 3 * scaleFactor,
                        ),
                        SizedBox(
                          width: 54 * scaleFactor,
                          height: 12 * scaleFactor,
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              '任务${trainTaskListItems[i].name}',
                              style: const TextStyle(
                                fontSize: 10 * scaleFactor,
                                color: ThemeColors.white,
                                fontFamily: 'Microsoft YaHei',
                                height: 1,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 12 * scaleFactor,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: BackgroundColors.line,
                        borderRadius: BorderRadius.circular(0.5 * scaleFactor),
                      ),
                      width: scaleFactor,
                      height: 12 * scaleFactor,
                    ),
                    const SizedBox(
                      width: 12 * scaleFactor,
                    ),
                    Row(
                      children: [
                        SvgPicture.asset(
                          'assets/icons/item_time.svg',
                          width: 12 * scaleFactor,
                          height: 12 * scaleFactor,
                        ),
                        const SizedBox(
                          width: 3 * scaleFactor,
                        ),
                        SizedBox(
                          width: 60 * scaleFactor,
                          height: 12 * scaleFactor,
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              DateFormat('yyyy-MM-dd').format(trainTaskListItems[i].createDateTime),
                              style: const TextStyle(
                                fontSize: 10 * scaleFactor,
                                color: ThemeColors.white,
                                fontFamily: 'Microsoft YaHei',
                                height: 1,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 12 * scaleFactor,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 12 * scaleFactor,
                          child: CircleAvatar(
                            radius: 3 * scaleFactor,
                            backgroundColor: switch(trainTaskListItems[i].status) {
                              TaskListItemStatus.inProgress => ThemeColors.yellow,
                              TaskListItemStatus.completed => ThemeColors.green,
                            },
                          ),
                        ),
                        SizedBox(
                          width: 36 * scaleFactor,
                          height: 12 * scaleFactor,
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              trainTaskListItems[i].status.text,
                              style: const TextStyle(
                                fontSize: 10 * scaleFactor,
                                color: ThemeColors.white,
                                fontFamily: 'Microsoft YaHei',
                                height: 1,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 12 * scaleFactor,
                    ),
                    GestureDetector(
                      onTap: () {
                        logger.d('${trainTaskListItems[i].name}\'s detail is clicked');
                      },
                      child: MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              'assets/icons/item_detail.svg',
                              width: 12 * scaleFactor,
                              height: 12 * scaleFactor,
                            ),
                            const SizedBox(
                              width: 3 * scaleFactor,
                            ),
                            const SizedBox(
                              width: 24 * scaleFactor,
                              height: 12 * scaleFactor,
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  '详情',
                                  style: TextStyle(
                                    fontSize: 10 * scaleFactor,
                                    color: ThemeColors.white,
                                    fontFamily: 'Microsoft YaHei',
                                    height: 1,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              if (i != trainTaskListItems.length - 1) 
                const SizedBox(height: 12 * scaleFactor), 
            ]
          )
      ],
    );
  }
}
