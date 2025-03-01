import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:mttm_vis/param.dart';

enum SlidebarSelectableItem { 
  trainingTask('训练任务'),
  visualization('可视化');

  final String text;
  const SlidebarSelectableItem(this.text);
}

class Slidebar extends StatefulWidget {
  final SlidebarSelectableItem selecedItem;
  final Function(SlidebarSelectableItem) setSelecedItemFun;

  const Slidebar({
    super.key, required this.selecedItem, required this.setSelecedItemFun,
  });

  @override
  State<Slidebar> createState() => _SlidebarState();
}

class _SlidebarState extends State<Slidebar> {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SlidebarItem(
          iconAssetName: 'assets/icons/training_task.svg',
          selecedItem: SlidebarSelectableItem.trainingTask,
          isSelect: widget.selecedItem == SlidebarSelectableItem.trainingTask,
          setSelecedtItem: widget.setSelecedItemFun,
        ),
        SlidebarItem(
          iconAssetName: 'assets/icons/visualization.svg',
          selecedItem: SlidebarSelectableItem.visualization,
          isSelect: widget.selecedItem == SlidebarSelectableItem.visualization,
          setSelecedtItem: widget.setSelecedItemFun,
        ),
      ],
    );
  }
}

class SlidebarItem extends StatefulWidget {
  final String iconAssetName;
  final SlidebarSelectableItem selecedItem;
  final bool isSelect;
  final Function(SlidebarSelectableItem) setSelecedtItem;

  const SlidebarItem({
    super.key, required this.iconAssetName, required this.selecedItem, required this.isSelect, 
    required this.setSelecedtItem, 
  });

  @override
  State<SlidebarItem> createState() => _SlidebarItemState();
}

class _SlidebarItemState extends State<SlidebarItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if(widget.isSelect == false) {
          logger.d('${widget.selecedItem.text} is clicked');
          widget.setSelecedtItem(widget.selecedItem);
        }

      },
      child: MouseRegion(
        cursor: widget.isSelect ? MouseCursor.defer : SystemMouseCursors.click,
        child: Container(
          padding: const EdgeInsets.all(6 * scaleFactor),
          color: widget.isSelect ? BackgroundColors.slidebarItem : null,
          child: Column(
            children: [
              SvgPicture.asset(
                widget.iconAssetName,
                width: 24 * scaleFactor,
                height: 24 * scaleFactor,
                colorFilter: widget.isSelect ? const ColorFilter.mode(
                  ThemeColors.blue,
                  BlendMode.srcIn,
                ) : null,
              ),
              SizedBox(
                width: 48 * scaleFactor,
                height: 12 * scaleFactor,
                child: Center(
                  child: Text(
                    widget.selecedItem.text,
                    style: TextStyle(
                      fontSize: 8 * scaleFactor,
                      color: widget.isSelect ? ThemeColors.blue : ThemeColors.white,
                      fontFamily: 'Microsoft YaHei',
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
