import 'package:flutter/material.dart';

import 'package:todo/widgets/group_form/group_form_widget.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class GroupsWidget extends StatelessWidget {
  static const route = '/groups';

  const GroupsWidget({super.key});

  void showForm(BuildContext context) {
    Navigator.of(context).pushNamed(GroupFormWidget.route);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Groups'),
        centerTitle: true,
      ),
      body: const _GroupListWidget(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showForm(context),
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }
}

class _GroupListWidget extends StatefulWidget {
  const _GroupListWidget({super.key});

  @override
  State<_GroupListWidget> createState() => _GroupListWidgetState();
}

class _GroupListWidgetState extends State<_GroupListWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: 20,
      separatorBuilder: (context, index) {
        return const Divider(
          height: 1,
        );
      },
      itemBuilder: (BuildContext context, int index) {
        return _GroupListRowWidget(
          indexInList: index,
        );
      },
    );
  }
}

class _GroupListRowWidget extends StatelessWidget {
  final int indexInList;
  const _GroupListRowWidget({
    super.key,
    required this.indexInList,
  });

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: const ActionPane(
        extentRatio: 0.25,
        motion: DrawerMotion(),
        children: [
          SlidableAction(
            onPressed: doNothing,
            backgroundColor: Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
          ),
        ],
      ),
      child: ListTile(
        onTap: () {
          print('Tap on ListTile');
        },
        title: const Text('One-line with trailing widget'),
        trailing: const Icon(Icons.chevron_right),
      ),
    );
  }
}

void doNothing(BuildContext context) {
  print('Tap Delete Button');
}
