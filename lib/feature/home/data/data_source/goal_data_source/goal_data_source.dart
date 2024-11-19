import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:habit_track/feature/home/data/data_source/goal_data_source/goal_data_source_abstract.dart';
import 'package:habit_track/feature/home/data/model/habit_model.dart';
import 'package:habit_track/feature/home/data/repo/habit_repo_impl.dart';
import 'package:habit_track/service/firebase_service.dart';
import 'package:intl/intl.dart';

class GoalDataSourceImpl implements GoalDataSource {
  FirebaseService firebaseService;
  GoalDataSourceImpl({required this.firebaseService});
  String todayDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

  @override
  Future<bool> creeateGoal(
      {required String goalName,
      required int period,
      required String habitId}) async {
    String userId = firebaseService.getFirebaseUserId();
    String todayDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
    bool isCompleted = false;
    try {
      DocumentSnapshot progressSnapshot = await firebaseService
          .getUserDoc()
          .collection('habits')
          .doc(habitId)
          .collection('progress')
          .doc(todayDate) // Directly access the document by its ID (todayDate)
          .get();
      if (progressSnapshot.exists) {
        var habitData = progressSnapshot.data() as Map<String, dynamic>?;
        isCompleted = habitData!['completed'] as bool;
      }
      await FirebaseFirestore.instance
          .collection('user_info')
          .doc(userId)
          .collection('habits')
          .doc(habitId)
          .update({
        'goal': {
          'goal_name': goalName,
          'total_day': period,
          'done_day': isCompleted ? 1 : 0,
          'habit_id': habitId
        }
      });

      return true;
    } on Exception catch (e) {
      return false;
    }
  }

  @override
  Future<bool> deleteGoal({required String habitId}) async {
    try {
      await firebaseService
          .getUserDoc()
          .collection('habits')
          .doc(habitId)
          .update({
        'goal': FieldValue.delete(),
      });
      return true;
    } on Exception catch (e) {
      return false;
    }
  }

  @override
  updateGoal({
    required String habitId,
    required bool isCompleted,
  }) async {
    try {
      if (isCompleted) {
        //update goal if it complet by incrase done day 1
        await firebaseService
            .getUserDoc()
            .collection('habits')
            .doc(habitId)
            .update({
          'goal.done_day': FieldValue.increment(1) // Increment done_day by 1
        });
      } else {
        //update goal if it complet by incrase done day 1
        await firebaseService
            .getUserDoc()
            .collection('habits')
            .doc(habitId)
            .update({
          'goal.done_day': FieldValue.increment(-1) // decrement done_day by 1
        });
      }
    } on Exception catch (e) {
      print(e.toString());
    }
  }

  @override
  Future<List<HabitModel>> getAllGoal() async {
    List<HabitModel> goalList = [];
    String nameDay = DateFormat('EEEE').format(DateTime.now());

    try {
      //!get all habit custom day and evrday
      // First query for customDays containing nameDay
      QuerySnapshot customDaysSnapshot = await firebaseService
          .getUserDoc()
          .collection('habits')
          .where('customDays', arrayContains: nameDay)
          .get();

      // Second query for period equal to 'Everyday'
      QuerySnapshot everydaySnapShot = await firebaseService
          .getUserDoc()
          .collection('habits')
          .where('period', isEqualTo: 'Everyday')
          .get();

      // Combine both queries' results and remove duplicates
      List<QueryDocumentSnapshot> allDocuments = [
        ...customDaysSnapshot.docs,
        ...everydaySnapShot.docs,
      ];

      // Use a Set to remove duplicates by document ID
      var seenIds = <String>{};
      var uniqueDocuments = allDocuments
          .where((doc) => seenIds.add(doc.id))
          .toList(); //list of doc contian data each doc contian own data

//! convert each doc data to habit model(parse) and creat progress if not done (iscoomplet false)

      for (var doc in uniqueDocuments) {
        HabitModel habit =
            HabitModel.fromJson(doc.data() as Map<String, dynamic>);
        goalList.add(habit);
      }
    } catch (e) {
      return [];
    }

    return goalList;
  }
}
