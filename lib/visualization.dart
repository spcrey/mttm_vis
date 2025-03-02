import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:mttm_vis/param.dart';

enum PhysicalChannel {
  temperature('温度T'),
  salinity('盐度S'),
  velocityU('速度u'),
  velocityW('速度w'),
  pressure('压强p');

  final String text;
  const PhysicalChannel(this.text);
}

enum VisualizationWay {
  heatmap('热力图'),
  contour('等高线图');

  final String text;
  const VisualizationWay(this.text);
}

enum VisualizationMode {
  imageFrame,
  videoPlay,
  videoPause;
}

enum VisualizationStatus {
  pending,
  completed,
}

class Visualization extends StatefulWidget {
  const Visualization({
    super.key,
  });

  @override
  State<Visualization> createState() => _VisualizationState();
}

class _VisualizationState extends State<Visualization> {

  String _datasetName = 'NONE';
  String _gridModelName = 'NONE';
  String _pointModelName = 'NONE';
  PhysicalChannel? _physicalChannel;
  VisualizationWay? _visualizationWay;
  VisualizationStatus status = VisualizationStatus.pending;

  void _setDatasetFun(String datasetName) {
    setState(() {
      _datasetName = datasetName;
    });
  }

  void _setGridModelFun(String gridModelName) {
    setState(() {
      _gridModelName = gridModelName;
    });
  }

  void _setPointModelFun(String pointModelName) {
    setState(() {
      _pointModelName = pointModelName;
    });
  }

  void _setPhysicalChannelFun(PhysicalChannel physicalChannel) {
    setState(() {
      _physicalChannel = physicalChannel;
    });
  }

  void _setVisualizationWayFun(VisualizationWay visualizationWay) {
    setState(() {
      _visualizationWay = visualizationWay;
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
          Container(
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: ThemeColors.blue, 
                  width: 1 * scaleFactor
                ),
              ),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: 10 * scaleFactor,
                      child: Center(
                        child: Text(
                          '参数设定',
                          style: TextStyle(
                            fontSize: 8 * scaleFactor,
                            color: ThemeColors.blue,
                            fontFamily: 'Microsoft YaHei',
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 3 * scaleFactor,
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 12 * scaleFactor,
          ),
          Row(
            children: [
              Datasetsetting(
                datasetName: _datasetName,
                setDatasetFun: _setDatasetFun,
              ),
              const SizedBox(
                width: 12 * scaleFactor,
              ),
              ModelSetting(
                gridModelName: _gridModelName,
                pointModelName: _pointModelName,
                setGridModelFun: _setGridModelFun,
                setPointModelFun: _setPointModelFun,
              ),
              const SizedBox(
                width: 12 * scaleFactor,
              ),
              PhysicalChannelSetting(
                physicalChannel:  _physicalChannel,
                setPhysicalChannelFun: _setPhysicalChannelFun,
              ),
              const SizedBox(
                width: 12 * scaleFactor,
              ),
              VisualizationWaySetting(
                visualizationWay: _visualizationWay,
                setVisualizationWayFun: _setVisualizationWayFun,
              ),
            ],
          ),
          const SizedBox(
            height: 12 * scaleFactor,
          ),
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  logger.d('可视化评估');
                  setState(() {
                    status = VisualizationStatus.completed;
                  });
                },
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: Container(
                    decoration: BoxDecoration(
                      color: ThemeColors.green,
                      borderRadius: BorderRadius.circular(2 * scaleFactor),
                    ),
                    padding: const EdgeInsets.all(6 * scaleFactor),
                    child: const SizedBox(
                      height: 8 * scaleFactor,
                      child: Text(
                        '可视化评估',
                        style: TextStyle(
                          fontSize: 8 * scaleFactor,
                          color: ThemeColors.white,
                          fontFamily: 'Microsoft YaHei',
                          height: 1,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 12 * scaleFactor,
              ),
              GestureDetector(
                onTap: () {
                  logger.d('取消');
                  setState(() {
                    status = VisualizationStatus.pending;
                  });
                },
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: Container(
                    decoration: BoxDecoration(
                      color: ThemeColors.red,
                      borderRadius: BorderRadius.circular(2 * scaleFactor),
                    ),
                    padding: const EdgeInsets.all(6 * scaleFactor),
                    child: const SizedBox(
                      height: 8 * scaleFactor,
                      child: Text(
                        '取消',
                        style: TextStyle(
                          fontSize: 8 * scaleFactor,
                          color: ThemeColors.white,
                          fontFamily: 'Microsoft YaHei',
                          height: 1,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ]
          ),
          const SizedBox(
            height: 12 * scaleFactor,
          ),
          switch(status) {
            VisualizationStatus.pending => const Text(
              '暂无结果',
              style: TextStyle(
                fontSize: 5 * scaleFactor,
                color: ThemeColors.lightWhite,
                fontFamily: 'Microsoft YaHei',
              ),
            ),
            VisualizationStatus.completed => const VisualizationResult(),
          }
        ],
      ),
    );
  }
}

class VisualizationResult extends StatefulWidget {
  const VisualizationResult({
    super.key,
  });

  @override
  State<VisualizationResult> createState() => _VisualizationResultState();
}

class _VisualizationResultState extends State<VisualizationResult> {
  VisualizationMode _mode = VisualizationMode.imageFrame;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: ThemeColors.blue, 
                width: 1 * scaleFactor
              ),
            ),
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 10 * scaleFactor,
                    child: Center(
                      child: Text(
                        '可视化对比结果',
                        style: TextStyle(
                          fontSize: 8 * scaleFactor,
                          color: ThemeColors.blue,
                          fontFamily: 'Microsoft YaHei',
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 3 * scaleFactor,
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 12 * scaleFactor,
        ),
        Row(
          children: [
            Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: ThemeColors.white,
                    borderRadius: BorderRadius.circular(2 * scaleFactor),
                  ),
                  width: 240 * scaleFactor,
                  height: 60 * scaleFactor,
                ),
                const SizedBox(
                  height: 3 * scaleFactor,
                ),
                const SizedBox(
                  height: 10 * scaleFactor,
                  child: Text(
                    'GT',
                    style: TextStyle(
                      fontSize: 8 * scaleFactor,
                      color: ThemeColors.white,
                      fontFamily: 'Microsoft YaHei',
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              width: 12 * scaleFactor,
            ),
            Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: ThemeColors.white,
                    borderRadius: BorderRadius.circular(2 * scaleFactor),
                  ),
                  width: 240 * scaleFactor,
                  height: 60 * scaleFactor,
                ),
                const SizedBox(
                  height: 3 * scaleFactor,
                ),
                const SizedBox(
                  height: 10 * scaleFactor,
                  child: Text(
                    'MODEL',
                    style: TextStyle(
                      fontSize: 8 * scaleFactor,
                      color: ThemeColors.white,
                      fontFamily: 'Microsoft YaHei',
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(
          height: 12 * scaleFactor,
        ),
        Row(
          children: [
            GestureDetector(
              onTap: () {
                switch(_mode) {
                  case VisualizationMode.imageFrame:
                    logger.d('切换为视频模式');
                    setState(() {
                      _mode = VisualizationMode.videoPause;
                    });
                    break;
                  case VisualizationMode.videoPlay:
                  case VisualizationMode.videoPause:
                    logger.d('切换为图片帧模式');
                    setState(() {
                      _mode = VisualizationMode.imageFrame;
                    });
                }
              },
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: Container(
                  decoration: BoxDecoration(
                    color: ThemeColors.green,
                    borderRadius: BorderRadius.circular(2 * scaleFactor),
                  ),
                  padding: const EdgeInsets.all(6 * scaleFactor),
                  child: SizedBox(
                    height: 8 * scaleFactor,
                    child: Text(
                      switch(_mode) {
                        VisualizationMode.imageFrame => '切换为视频模式',
                        VisualizationMode.videoPlay => '切换为图片帧模式',
                        VisualizationMode.videoPause => '切换为图片帧模式',
                      },
                      style: const TextStyle(
                        fontSize: 8 * scaleFactor,
                        color: ThemeColors.white,
                        fontFamily: 'Microsoft YaHei',
                        height: 1,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 12 * scaleFactor,
            ),
            GestureDetector(
              onTap: () {
                switch(_mode) {
                  case VisualizationMode.imageFrame:
                    logger.d('上一帧');
                    break;
                  case VisualizationMode.videoPlay:
                    logger.d('切换为暂停模式');
                    setState(() {
                      _mode = VisualizationMode.videoPause;
                    });
                    break;
                  case VisualizationMode.videoPause:
                    logger.d('切换为播放模式');
                    setState(() {
                      _mode = VisualizationMode.videoPlay;
                    });
                }
              },
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: Container(
                  decoration: BoxDecoration(
                    color: ThemeColors.yellow,
                    borderRadius: BorderRadius.circular(2 * scaleFactor),
                  ),
                  padding: const EdgeInsets.all(6 * scaleFactor),
                  child: SizedBox(
                    height: 8 * scaleFactor,
                    child: Text(
                      switch(_mode) {
                        VisualizationMode.imageFrame => '上一帧',
                        VisualizationMode.videoPlay => '暂停',
                        VisualizationMode.videoPause => '播放',
                      },
                      style: const TextStyle(
                        fontSize: 8 * scaleFactor,
                        color: ThemeColors.white,
                        fontFamily: 'Microsoft YaHei',
                        height: 1,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
          width: 12 * scaleFactor,
        ),
        if(_mode == VisualizationMode.imageFrame)
          GestureDetector(
              onTap: () {
                logger.d('下一帧');
              },
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: Container(
                  decoration: BoxDecoration(
                    color: ThemeColors.yellow,
                    borderRadius: BorderRadius.circular(2 * scaleFactor),
                  ),
                  padding: const EdgeInsets.all(6 * scaleFactor),
                  child: const SizedBox(
                    height: 8 * scaleFactor,
                    child: Text(
                      '下一帧',
                      style: TextStyle(
                        fontSize: 8 * scaleFactor,
                        color: ThemeColors.white,
                        fontFamily: 'Microsoft YaHei',
                        height: 1,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        
      ],
    );
  }
}

class VisualizationWaySetting extends StatefulWidget {
  final VisualizationWay? visualizationWay;
  final Function(VisualizationWay) setVisualizationWayFun;

  const VisualizationWaySetting({
    super.key, 
    required this.visualizationWay, 
    required this.setVisualizationWayFun,
  });

  @override
  State<VisualizationWaySetting> createState() => _VisualizationWaySettingState();
}

class _VisualizationWaySettingState extends State<VisualizationWaySetting> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: BackgroundColors.information,
        border: Border.all(
          color: BackgroundColors.line, 
          width: 0.8 * scaleFactor,  
        ),
        borderRadius: BorderRadius.circular(2 * scaleFactor),
      ),
      padding: const EdgeInsets.all(6 * scaleFactor),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            'assets/icons/visualization_way.svg',
            width: 18 * scaleFactor,
            height: 18 * scaleFactor,
          ),
          const SizedBox(
            width: 12,
          ),
          GestureDetector(
            onTapUp: (detail) {
              showMenu<VisualizationWay>(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(2 * scaleFactor),
                  side: const BorderSide(
                    color: BackgroundColors.line, 
                    width: 0.8 * scaleFactor, 
                  ),
                ),
                color: BackgroundColors.body,
                context: context,
                position: RelativeRect.fromLTRB(
                  detail.globalPosition.dx,
                  detail.globalPosition.dy,
                  detail.globalPosition.dx,
                  detail.globalPosition.dy,
                ),
                items: [
                  PopupMenuItem(
                    height: 12 * scaleFactor,
                    value: VisualizationWay.heatmap,
                    child: SizedBox(
                      child: Text(
                        VisualizationWay.heatmap.text,
                        style: const TextStyle(
                          fontSize: 5 * scaleFactor,
                          color: ThemeColors.white,
                          fontFamily: 'Microsoft YaHei',
                        ),
                      ),
                    ),
                  ),
                  PopupMenuItem(
                    height: 12 * scaleFactor,
                    value: VisualizationWay.contour,
                    child: Text(
                      VisualizationWay.contour.text,
                      style: const TextStyle(
                        fontSize: 5 * scaleFactor,
                        color: ThemeColors.white,
                        fontFamily: 'Microsoft YaHei',
                      ),
                    ),
                  ),
                ],
              ).then((visualizationWay) {
                if(visualizationWay!=null) {
                  widget.setVisualizationWayFun(visualizationWay);
                }                
              });
            },
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 10 * scaleFactor,
                    child: Text(
                      '可视化方式',
                      style: TextStyle(
                        fontSize: 8 * scaleFactor,
                        color: ThemeColors.white,
                        fontFamily: 'Microsoft YaHei',
                        height: 1,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 2 * scaleFactor,
                  ),
                  SizedBox(
                    height: 6 * scaleFactor,   
                    child: Center(  
                      child: Text(
                        widget.visualizationWay?.text ?? 'NONE',
                        style: const TextStyle(
                          fontSize: 5 * scaleFactor,
                          color: ThemeColors.lightWhite,
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

    );
  }
}

class PhysicalChannelSetting extends StatefulWidget {
  final PhysicalChannel? physicalChannel;
  final Function(PhysicalChannel) setPhysicalChannelFun;

  const PhysicalChannelSetting({
    super.key, 
    required this.physicalChannel, 
    required this.setPhysicalChannelFun,
  });

  @override
  State<PhysicalChannelSetting> createState() => _PhysicalChannelSettingState();
}

class _PhysicalChannelSettingState extends State<PhysicalChannelSetting> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: BackgroundColors.information,
        border: Border.all(
          color: BackgroundColors.line, 
          width: 0.8 * scaleFactor,  
        ),
        borderRadius: BorderRadius.circular(2 * scaleFactor),
      ),
      padding: const EdgeInsets.all(6 * scaleFactor),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            'assets/icons/physical_channel.svg',
            width: 18 * scaleFactor,
            height: 18 * scaleFactor,
          ),
          const SizedBox(
            width: 12,
          ),
          GestureDetector(
            onTapUp: (detail) {
              showMenu<PhysicalChannel>(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(2 * scaleFactor),
                  side: const BorderSide(
                    color: BackgroundColors.line, 
                    width: 0.8 * scaleFactor, 
                  ),
                ),
                color: BackgroundColors.body,
                context: context,
                position: RelativeRect.fromLTRB(
                  detail.globalPosition.dx,
                  detail.globalPosition.dy,
                  detail.globalPosition.dx,
                  detail.globalPosition.dy,
                ),
                items: [
                  PopupMenuItem(
                    height: 12 * scaleFactor,
                    value: PhysicalChannel.temperature,
                    child: SizedBox(
                      child: Text(
                        PhysicalChannel.temperature.text,
                        style: const TextStyle(
                          fontSize: 5 * scaleFactor,
                          color: ThemeColors.white,
                          fontFamily: 'Microsoft YaHei',
                        ),
                      ),
                    ),
                  ),
                  PopupMenuItem(
                    height: 12 * scaleFactor,
                    value: PhysicalChannel.salinity,
                    child: Text(
                      PhysicalChannel.salinity.text,
                      style: const TextStyle(
                        fontSize: 5 * scaleFactor,
                        color: ThemeColors.white,
                        fontFamily: 'Microsoft YaHei',
                      ),
                    ),
                  ),
                  PopupMenuItem(
                    height: 12 * scaleFactor,
                    value: PhysicalChannel.velocityU,
                    child: Text(
                      PhysicalChannel.velocityU.text,
                      style: const TextStyle(
                        fontSize: 5 * scaleFactor,
                        color: ThemeColors.white,
                        fontFamily: 'Microsoft YaHei',
                      ),
                    ),
                  ),
                  PopupMenuItem(
                    height: 12 * scaleFactor,
                    value: PhysicalChannel.velocityW,
                    child: Text(
                      PhysicalChannel.velocityW.text,
                      style: const TextStyle(
                        fontSize: 5 * scaleFactor,
                        color: ThemeColors.white,
                        fontFamily: 'Microsoft YaHei',
                      ),
                    ),
                  ),
                  PopupMenuItem(
                    height: 12 * scaleFactor,
                    value: PhysicalChannel.pressure,
                    child: Text(
                      PhysicalChannel.pressure.text,
                      style: const TextStyle(
                        fontSize: 5 * scaleFactor,
                        color: ThemeColors.white,
                        fontFamily: 'Microsoft YaHei',
                      ),
                    ),
                  ),
                ],
              ).then((physicalChannel) {
                if(physicalChannel!=null) {
                  widget.setPhysicalChannelFun(physicalChannel);
                }                
              });
            },
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 10 * scaleFactor,
                    child: Text(
                      '物理通道',
                      style: TextStyle(
                        fontSize: 8 * scaleFactor,
                        color: ThemeColors.white,
                        fontFamily: 'Microsoft YaHei',
                        height: 1,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 2 * scaleFactor,
                  ),
                  SizedBox(
                    height: 6 * scaleFactor,   
                    child: Center(  
                      child: Text(
                        widget.physicalChannel?.text ?? 'NONE',
                        style: const TextStyle(
                          fontSize: 5 * scaleFactor,
                          color: ThemeColors.lightWhite,
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
    );
  }
}

class Datasetsetting extends StatefulWidget {
  final String datasetName;
  final Function(String) setDatasetFun;

  const Datasetsetting({
    super.key, required this.datasetName, required this.setDatasetFun, 
  });

  @override
  State<Datasetsetting> createState() => _DatasetsettingState();
}

class _DatasetsettingState extends State<Datasetsetting> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: BackgroundColors.information,
        border: Border.all(
          color: BackgroundColors.line, 
          width: 0.8 * scaleFactor,  
        ),
        borderRadius: BorderRadius.circular(2 * scaleFactor),
      ),
      padding: const EdgeInsets.all(6 * scaleFactor),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            'assets/icons/dataset.svg',
            width: 18 * scaleFactor,
            height: 18 * scaleFactor,
          ),
          const SizedBox(
            width: 12,
          ),
          GestureDetector(
            onTap: () {
              pickFile(widget.setDatasetFun);
            },
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 10 * scaleFactor,
                    child: Text(
                      '数据集',
                      style: TextStyle(
                        fontSize: 8 * scaleFactor,
                        color: ThemeColors.white,
                        fontFamily: 'Microsoft YaHei',
                        height: 1,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 2 * scaleFactor,
                  ),
                  SizedBox(
                    height: 6 * scaleFactor,
                    child: Center(
                      child: Text(
                        widget.datasetName,
                        style: const TextStyle(
                          fontSize: 5 * scaleFactor,
                          color: ThemeColors.lightWhite,
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
    );
  }
}

class ModelSetting extends StatefulWidget {
  const ModelSetting({
    super.key,
    required this.gridModelName,
    required this.pointModelName,
    required this.setGridModelFun,
    required this.setPointModelFun,
  });

  final String gridModelName;
  
  final String pointModelName;
  
  final Function(String fileName)  setGridModelFun;
  
  final Function(String fileName)  setPointModelFun;

  @override
  State<ModelSetting> createState() => _ModelSettingState();
}

class _ModelSettingState extends State<ModelSetting> {

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: BackgroundColors.information,
        border: Border.all(
          color: BackgroundColors.line, 
          width: 0.8 * scaleFactor,  
        ),
        borderRadius: BorderRadius.circular(2 * scaleFactor),
      ),
      padding: const EdgeInsets.all(6 * scaleFactor),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            'assets/icons/model.svg',
            width: 18 * scaleFactor,
            height: 18 * scaleFactor,
          ),
          const SizedBox(
            width: 6 * scaleFactor,
          ),
          GestureDetector(
            onTap: () {
              pickFile(widget.setGridModelFun);
            },
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 10 * scaleFactor,
                    child: Text(
                      '网格模型',
                      style: TextStyle(
                        fontSize: 8 * scaleFactor,
                        color: ThemeColors.white,
                        fontFamily: 'Microsoft YaHei',
                        height: 1,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 2 * scaleFactor,
                  ),
                  SizedBox(
                    height: 6 * scaleFactor,
                    child: Center(
                      child: Text(
                        widget.gridModelName,
                        style: const TextStyle(
                          fontSize: 5 * scaleFactor,
                          color: ThemeColors.lightWhite,
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
          const SizedBox(
            width: 6 * scaleFactor,
          ),
          Container(
            decoration: BoxDecoration(
              color: BackgroundColors.line,
              borderRadius: BorderRadius.circular(0.5 * scaleFactor),
            ),
            width: scaleFactor,
            height: 18 * scaleFactor,
          ),
          const SizedBox(
            width: 6 * scaleFactor,
          ),
          GestureDetector(
            onTap: () {
              pickFile(widget.setPointModelFun);
            },
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 10 * scaleFactor,
                    child: Text(
                      '点云模型',
                      style: TextStyle(
                        fontSize: 8 * scaleFactor,
                        color: ThemeColors.white,
                        fontFamily: 'Microsoft YaHei',
                        height: 1,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 2 * scaleFactor,
                  ),
                  SizedBox(
                    height: 6 * scaleFactor,
                    child: Center(
                      child: Text(
                        widget.pointModelName,
                        style: const TextStyle(
                          fontSize: 5 * scaleFactor,
                          color: ThemeColors.lightWhite,
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
    );
  }
}
