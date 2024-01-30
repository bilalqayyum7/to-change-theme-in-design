import 'dart:html';

import 'package:get/get.dart';
import 'package:theme_change_project/Models/task.dart';
import 'package:theme_change_project/db/db_helper.dart';

class TaskController extends GetxController{
  @override
  void onReady(){
    super.onReady();
  }
  var taskList = <Task>[].obs;

  Future<int> addTask({Task? task}) async{
    return await DbHelper.insert(task);
  }
  // get all data from table
 void getTasks() async {
    List<Map<String, dynamic>> tasks = await DbHelper.query();
    taskList.assignAll(tasks.map((data) => new Task.fromson(data)).toList());
 }
  void delete(Task task){
    DbHelper.delete(task);
    getTasks();
  }
  void markTaskCompleted (int id) async{
    await DbHelper.update(id);
    getTasks();
  }
}