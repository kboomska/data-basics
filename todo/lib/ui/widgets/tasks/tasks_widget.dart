import 'package:flutter/material.dart';

import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:todo/ui/widgets/tasks/tasks_widget_model.dart';

class TasksWidget extends StatefulWidget {
  final int groupKey;

  const TasksWidget({
    super.key,
    required this.groupKey,
  });

  @override
  State<TasksWidget> createState() => _TasksWidgetState();
}

class _TasksWidgetState extends State<TasksWidget> {
  late final TasksWidgetModel _model;

  @override
  void initState() {
    super.initState();
    _model = TasksWidgetModel(groupKey: widget.groupKey);
  }

  @override
  Widget build(BuildContext context) {
    return TasksWidgetModelProvider(
      model: _model,
      child: const _TasksWidgetBody(),
    );
  }
}

class _TasksWidgetBody extends StatelessWidget {
  const _TasksWidgetBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = TasksWidgetModelProvider.noticeOf(context)?.model;
    final title = model?.group?.name ?? 'Tasks';

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
      ),
      body: const _TaskListWidget(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => model?.showForm(context),
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }
}

class _TaskListWidget extends StatelessWidget {
  const _TaskListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final taskCount =
        TasksWidgetModelProvider.noticeOf(context)?.model.tasks.length ?? 0;

    return ListView.separated(
      itemCount: taskCount,
      separatorBuilder: (context, index) {
        return const Divider(
          height: 1,
        );
      },
      itemBuilder: (BuildContext context, int index) {
        return _TaskListRowWidget(
          indexInList: index,
        );
      },
    );
  }
}

class _TaskListRowWidget extends StatelessWidget {
  final int indexInList;
  const _TaskListRowWidget({
    Key? key,
    required this.indexInList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = TasksWidgetModelProvider.readOnly(context)!.model;
    final task = model.tasks[indexInList];

    final icon = task.isDone ? Icons.done : null;
    final style = task.isDone
        ? const TextStyle(
            decoration: TextDecoration.lineThrough,
          )
        : null;

    return Slidable(
      endActionPane: ActionPane(
        extentRatio: 0.25,
        motion: const DrawerMotion(),
        children: [
          SlidableAction(
            onPressed: (_) => model.deleteTask(indexInList),
            backgroundColor: const Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
          ),
        ],
      ),
      child: ListTile(
        onTap: () => model.doneToggle(indexInList),
        title: Text(
          task.text,
          style: style,
        ),
        trailing: Icon(icon),
      ),
    );
  }
}
