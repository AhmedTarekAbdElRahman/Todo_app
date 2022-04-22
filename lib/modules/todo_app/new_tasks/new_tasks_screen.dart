import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/shared/components/components.dart';
import 'package:todo_app/shared/cubit/cubit.dart';
import 'package:todo_app/shared/cubit/states.dart';

class NewTasksScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return BlocConsumer<AppCubit,AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var tasks=AppCubit.get(context).newTasks;
        return tasks.length>0
            ? ListView.separated(
          itemBuilder: (context,index)=>buildTaskItem(tasks[index],context),
          separatorBuilder: (context,index)=>Container(
            width: double.infinity,
            color: Colors.grey[300],
            height: 1.0,
          ),
          itemCount: tasks.length,
        )
            :Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
          children: [
              Icon(
                  Icons.menu_sharp,
                  color: Colors.grey,
                  size: 100.0,
              ),
              Text(
                  'no yet tasks , please add some tasks',style: TextStyle(
                color: Colors.grey,
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
              )
          ],
        ),
            );

      },
    );
  }
}
