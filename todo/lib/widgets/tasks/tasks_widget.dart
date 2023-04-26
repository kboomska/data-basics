import 'package:flutter/material.dart';

import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:todo/widgets/tasks/tasks_widget_model.dart';

class TasksWidget extends StatefulWidget {
  static const route = '/groups/tasks';

  const TasksWidget({super.key});

  @override
  State<TasksWidget> createState() => _TasksWidgetState();
}

class _TasksWidgetState extends State<TasksWidget> {
  TasksWidgetModel? _model;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_model == null) {
      final groupKey = ModalRoute.of(context)!.settings.arguments as int;
      _model = TasksWidgetModel(groupKey: groupKey);
    }
  }

  @override
  Widget build(BuildContext context) {
    return TasksWidgetModelProvider(
      model: _model!,
      child: const _TasksWidgetBody(),
    );
  }
}

class _TasksWidgetBody extends StatelessWidget {
  const _TasksWidgetBody({super.key});

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
  const _TaskListWidget({super.key});

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
    super.key,
    required this.indexInList,
  });

  @override
  Widget build(BuildContext context) {
    final model = TasksWidgetModelProvider.readOnly(context)!.model;
    final task = model.tasks[indexInList];

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
        onTap: () {},
        title: Text(task.text),
        trailing: const Icon(Icons.chevron_right),
      ),
    );
  }
}
