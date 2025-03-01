enum TaskListItemStatus {
  inProgress('进行中'), 
  completed('已完成');

  final String text;
  const TaskListItemStatus(this.text);
}

class TrainTaskItem {
  late String name;
  late DateTime createDateTime;
  late TaskListItemStatus status;

  TrainTaskItem({
    required this.name,
    required this.createDateTime,
    required this.status,
  });
}

List<TrainTaskItem> trainTaskListItems = [
  TrainTaskItem(
    name: "BC4R",
    createDateTime: DateTime(2025, 2, 24),
    status: TaskListItemStatus.inProgress
  ),
  TrainTaskItem(
    name: "3THY",
    createDateTime: DateTime(2025, 2, 22),
    status: TaskListItemStatus.inProgress
  ),
  TrainTaskItem(
    name: "VF6Y",
    createDateTime: DateTime(2025, 2, 18),
    status: TaskListItemStatus.completed
  ),
  TrainTaskItem(
    name: "CER2",
    createDateTime: DateTime(2025, 2, 14),
    status: TaskListItemStatus.completed
  ),
];
