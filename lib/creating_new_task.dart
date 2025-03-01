import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mttm_vis/param.dart';

import 'package:file_picker/file_picker.dart';

class CreatingNewTask extends StatefulWidget {
  const CreatingNewTask({
    super.key,
  });


  @override
  State<CreatingNewTask> createState() => _CreatingNewTaskState();
}

String getFileNameWithoutExtension(String fileName) {
  if (fileName.contains('.')) {
    return fileName.split('.').sublist(0, fileName.split('.').length - 1).join('.');
  } else {
    return fileName;
  }
}

Future<void> pickFile(Function(String) setFileFun) async {
  FilePickerResult? result = await FilePicker.platform.pickFiles();
  if (result != null) {
    PlatformFile file = result.files.first;
    String fileName = getFileNameWithoutExtension(file.name);
    setFileFun(fileName);
  } 
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

  void _setPointdModelFun(String fileName) {
    setState(() {
      _pointModelName = fileName;
    });
  }

  void _setEageSampleStatusFun(bool isUse) {
    setState(() {
      _useEageSample = isUse;
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
          setPointdModelFun: _setPointdModelFun,
        ),
        const SizedBox(
          height: 12 * scaleFactor,
        ),
        EageSampleSetting(
          useEageSample: _useEageSample,
          eagePointWeight: _eagePointWeight,
          adaptiveWeight: _adaptiveWeight,
          setEageSampleStatusFun: _setEageSampleStatusFun,
        ),
      ],
    );
  }
}

class EageSampleSetting extends StatefulWidget {

  final bool useEageSample;
  final double adaptiveWeight;
  final double eagePointWeight;
  final Function(bool) setEageSampleStatusFun;

  const EageSampleSetting({
    super.key, 
    required this.useEageSample, 
    required this.adaptiveWeight, 
    required this.eagePointWeight, 
    required this.setEageSampleStatusFun,
  });

  @override
  State<EageSampleSetting> createState() => _EageSampleSettingState();
}

class _EageSampleSettingState extends State<EageSampleSetting> {
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
          GestureDetector(
            onTap: () {
              // pickFile(widget.setPointdModelFun);
            },
            child: const MouseRegion(
              cursor: SystemMouseCursors.click,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
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
                  SizedBox(
                    height: 2 * scaleFactor,
                  ),
                  SizedBox(
                    height: 6 * scaleFactor,
                    child: Center(
                      child: Text(
                        '1',
                        style: TextStyle(
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
    required this.setPointdModelFun,
  });

  final String gridModelName;
  
  final String pointModelName;
  
  final Function(String fileName)  setGridModelFun;
  
  final Function(String fileName)  setPointdModelFun;

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
              pickFile(widget.setPointdModelFun);
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
