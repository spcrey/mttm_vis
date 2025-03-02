import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:mttm_vis/param.dart';

class CreatingNewTask extends StatefulWidget {
  const CreatingNewTask({
    super.key,
  });

  @override
  State<CreatingNewTask> createState() => _CreatingNewTaskState();
}

class _CreatingNewTaskState extends State<CreatingNewTask> {
  
  final List<String> _datasetNames = [];
  String _gridModelName = 'NONE';
  String _pointModelName = 'NONE';
  bool _useEageSample = false;
  double _eagePointWeight = 0.0;
  double _adaptiveWeight = 0.0;
  bool _useTopographyPreProgress = false;
  bool _usePdeConstrainst = false;
  String _equationName = 'NONE';
  double _pdeWeight = 0.0;

  void _addToDatasetListFun(String fileName) {
    setState(() {
      _datasetNames.add(fileName);
    });
  }

  void _setGridModelFun(String fileName) {
    setState(() {
      _gridModelName = fileName;
    });
  }

  void _setPointModelFun(String fileName) {
    setState(() {
      _pointModelName = fileName;
    });
  }

  void _setEageSampleStatusFun(bool isUse) {
    setState(() {
      _useEageSample = isUse;
    });
  }

  void _setEagePointWeightFun(double value) {
    setState(() {
      _eagePointWeight = value;
    });
  }

  void _setAdaptiveWeightFun(double value) {
    setState(() {
      _adaptiveWeight = value;
    });
  }

  void _setTopographyPreProgressFun(bool isUse) {
    setState(() {
      _useTopographyPreProgress = isUse;
    });
  }

  void _setPdeConstrainstStatusFun(bool isUse) {
    setState(() {
      _usePdeConstrainst = isUse;
    });
  }

  void _setEquationFun(String fileName) {
    setState(() {
      _equationName = fileName;
    });
  }

  void _setPdeWeightFun(double value) {
    setState(() {
      _pdeWeight = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment : CrossAxisAlignment.start,
      children: [
        DatasetListSetting(
          datasetNames: _datasetNames, 
          setDatasetListFun: _addToDatasetListFun
        ),
        const SizedBox(
          height: 12 * scaleFactor,
        ),
        ModelSetting(
          gridModelName: _gridModelName,
          pointModelName: _pointModelName,
          setGridModelFun: _setGridModelFun,
          setPointModelFun: _setPointModelFun,
        ),
        const SizedBox(
          height: 12 * scaleFactor,
        ),
        EageSampleSetting(
          useEageSample: _useEageSample,
          eagePointWeight: _eagePointWeight,
          adaptiveWeight: _adaptiveWeight,
          setEageSampleStatusFun: _setEageSampleStatusFun,
          setEagePointWeightFun: _setEagePointWeightFun,
          setAdaptiveWeightFun: _setAdaptiveWeightFun,
        ),
        const SizedBox(
          height: 12 * scaleFactor,
        ),
        TopographyPreProgressSetting(
          useTopographyPreProgress: _useTopographyPreProgress,
          setTopographyPreProgressFun: _setTopographyPreProgressFun,
        ),
        const SizedBox(
          height: 12 * scaleFactor,
        ),
        PdeConstraintSetting(
          usePdeConstrainst: _usePdeConstrainst,
          equationName: _equationName,
          pdeWeight: _pdeWeight,
          setPdeConstrainstStatusFun: _setPdeConstrainstStatusFun,
          setEquationFun: _setEquationFun,
          setPdeWeightFun: _setPdeWeightFun,
        ),
        const SizedBox(
          height: 12 * scaleFactor,
        ),
        Row(
          children: [
            GestureDetector(
              onTap: () {
                logger.d('创建任务');
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
                      '创建任务',
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
        )
      ],
    );
  }
}

class PdeConstraintSetting extends StatefulWidget {
  final bool usePdeConstrainst;
  final String equationName;
  final double pdeWeight;
  final Function(bool) setPdeConstrainstStatusFun; 
  final Function(String) setEquationFun;
  final Function(double) setPdeWeightFun;

  const PdeConstraintSetting({
    super.key, 
    required this.usePdeConstrainst, 
    required this.equationName, 
    required this.pdeWeight, 
    required this.setPdeConstrainstStatusFun, 
    required this.setEquationFun, 
    required this.setPdeWeightFun,
  });

  @override
  State<PdeConstraintSetting> createState() => _PdeConstraintSettingState();
}

class _PdeConstraintSettingState extends State<PdeConstraintSetting> {

  final TextEditingController _pdeWeightController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _pdeWeightController.text = '${widget.pdeWeight}';
  }

  @override
  void dispose() {
    _pdeWeightController.dispose();
    super.dispose();
  }

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
            'assets/icons/pde_constraint.svg',
            width: 18 * scaleFactor,
            height: 18 * scaleFactor,
          ),
          const SizedBox(
            width: 6 * scaleFactor,
          ),
          GestureDetector(
            onTap: () {
              widget.setPdeConstrainstStatusFun(
                widget.usePdeConstrainst ? false : true
              );
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
                      'PDE约束',
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
                  Container(
                    width: 12 * scaleFactor,
                    height: 6 * scaleFactor,
                    decoration: BoxDecoration(
                      color: ThemeColors.white,
                      borderRadius: BorderRadius.circular(3 * scaleFactor),
                    ),
                    child: Align(
                      alignment: widget.usePdeConstrainst ? Alignment.centerRight : Alignment.centerLeft,
                      child: Container(
                        width: 6 * scaleFactor,
                        height: 6 * scaleFactor,
                        decoration: BoxDecoration(
                          color: widget.usePdeConstrainst ? ThemeColors.green : ThemeColors.red,
                          borderRadius: BorderRadius.circular(3 * scaleFactor),
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
              pickFile(widget.setEquationFun);
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
                      '方程文件',
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
                    child: Text(
                      widget.equationName,
                      style: const TextStyle(
                        fontSize: 5 * scaleFactor,
                        color: ThemeColors.lightWhite,
                        fontFamily: 'Microsoft YaHei',
                        height: 1,
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
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10 * scaleFactor,
                child: Text(
                  '自适应权重',
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
                width: 40 * scaleFactor,
                child: TextField(
                  decoration: const InputDecoration(
                    isDense: true,
                    border: InputBorder.none,
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent),
                    ),
                  ),
                  controller: _pdeWeightController,
                  style: const TextStyle(
                    fontSize: 5 * scaleFactor,
                    color: ThemeColors.lightWhite,
                    fontFamily: 'Microsoft YaHei',
                    height: 1,
                  ),
                  onChanged: (value) {
                    final double? doubleValue = double.tryParse(value);
                    if (doubleValue != null) {
                      widget.setPdeWeightFun(doubleValue);
                    }
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class TopographyPreProgressSetting extends StatefulWidget {
  final bool useTopographyPreProgress;
  final Function(bool) setTopographyPreProgressFun;

  const TopographyPreProgressSetting({
    super.key, required this.useTopographyPreProgress, required this.setTopographyPreProgressFun,
  });

  @override
  State<TopographyPreProgressSetting> createState() => _TopographyPreProgressSettingState();
}

class _TopographyPreProgressSettingState extends State<TopographyPreProgressSetting> {
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
            'assets/icons/topography_pre_progress.svg',
            width: 18 * scaleFactor,
            height: 18 * scaleFactor,
          ),
          const SizedBox(
            width: 6 * scaleFactor,
          ),
          GestureDetector(
            onTap: () {
              widget.setTopographyPreProgressFun(
                widget.useTopographyPreProgress ? false : true
              );
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
                      '地形区域数值预处理',
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
                  Container(
                    width: 12 * scaleFactor,
                    height: 6 * scaleFactor,
                    decoration: BoxDecoration(
                      color: ThemeColors.white,
                      borderRadius: BorderRadius.circular(3 * scaleFactor),
                    ),
                    child: Align(
                      alignment: widget.useTopographyPreProgress ? Alignment.centerRight : Alignment.centerLeft,
                      child: Container(
                        width: 6 * scaleFactor,
                        height: 6 * scaleFactor,
                        decoration: BoxDecoration(
                          color: widget.useTopographyPreProgress ? ThemeColors.green : ThemeColors.red,
                          borderRadius: BorderRadius.circular(3 * scaleFactor),
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

class EageSampleSetting extends StatefulWidget {

  final bool useEageSample;
  final double adaptiveWeight;
  final double eagePointWeight;
  final Function(bool) setEageSampleStatusFun;
  final Function(double) setEagePointWeightFun;
  final Function(double) setAdaptiveWeightFun;

  const EageSampleSetting({
    super.key, 
    required this.useEageSample, 
    required this.adaptiveWeight, 
    required this.eagePointWeight, 
    required this.setEageSampleStatusFun, 
    required this.setEagePointWeightFun, 
    required this.setAdaptiveWeightFun, 
  });

  @override
  State<EageSampleSetting> createState() => _EageSampleSettingState();
}

class _EageSampleSettingState extends State<EageSampleSetting> {
  final TextEditingController _eagePointWeightController = TextEditingController();
  final TextEditingController _adaptiveWeightController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _eagePointWeightController.text = '${widget.eagePointWeight}';
    _adaptiveWeightController.text = '${widget.adaptiveWeight}';
  }

  @override
  void dispose() {
    _eagePointWeightController.dispose();
    _adaptiveWeightController.dispose();
    super.dispose();
  }

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
            'assets/icons/eage_sample.svg',
            width: 18 * scaleFactor,
            height: 18 * scaleFactor,
          ),
          const SizedBox(
            width: 6 * scaleFactor,
          ),
          GestureDetector(
            onTap: () {
              widget.setEageSampleStatusFun(
                widget.useEageSample ? false : true
              );
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
                      '边缘采样',
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
                  Container(
                    width: 12 * scaleFactor,
                    height: 6 * scaleFactor,
                    decoration: BoxDecoration(
                      color: ThemeColors.white,
                      borderRadius: BorderRadius.circular(3 * scaleFactor),
                    ),
                    child: Align(
                      alignment: widget.useEageSample ? Alignment.centerRight : Alignment.centerLeft,
                      child: Container(
                        width: 6 * scaleFactor,
                        height: 6 * scaleFactor,
                        decoration: BoxDecoration(
                          color: widget.useEageSample ? ThemeColors.green : ThemeColors.red,
                          borderRadius: BorderRadius.circular(3 * scaleFactor),
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
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10 * scaleFactor,
                child: Text(
                  '边缘点权重',
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
                width: 40 * scaleFactor,
                child: TextField(
                  decoration: const InputDecoration(
                    isDense: true,
                    border: InputBorder.none,
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent),
                    ),
                  ),
                  controller: _eagePointWeightController,
                  style: const TextStyle(
                    fontSize: 5 * scaleFactor,
                    color: ThemeColors.lightWhite,
                    fontFamily: 'Microsoft YaHei',
                    height: 1,
                  ),
                  onChanged: (value) {
                    final double? doubleValue = double.tryParse(value);
                    if (doubleValue != null) {
                      widget.setEagePointWeightFun(doubleValue);
                    }
                  },
                ),
              ),
            ],
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
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10 * scaleFactor,
                child: Text(
                  '自适应权重',
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
                width: 40 * scaleFactor,
                child: TextField(
                  decoration: const InputDecoration(
                    isDense: true,
                    border: InputBorder.none,
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent),
                    ),
                  ),
                  controller: _adaptiveWeightController,
                  style: const TextStyle(
                    fontSize: 5 * scaleFactor,
                    color: ThemeColors.lightWhite,
                    fontFamily: 'Microsoft YaHei',
                    height: 1,
                  ),
                  onChanged: (value) {
                    final double? doubleValue = double.tryParse(value);
                    if (doubleValue != null) {
                      widget.setAdaptiveWeightFun(doubleValue);
                    }
                  },
                ),
              ),
            ],
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

class DatasetListSetting extends StatefulWidget {
  const DatasetListSetting({
    super.key,
    required this.datasetNames, required this.setDatasetListFun,
  });

  final List<String> datasetNames;
  final Function(String fileName) setDatasetListFun;

  @override
  State<DatasetListSetting> createState() => _DatasetListSettingState();
}

class _DatasetListSettingState extends State<DatasetListSetting> {

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
              pickFile(widget.setDatasetListFun);
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
                      '数据集列表',
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
                        widget.datasetNames.isEmpty ? 'NONE' : '${widget.datasetNames.join(', ')}.',
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
