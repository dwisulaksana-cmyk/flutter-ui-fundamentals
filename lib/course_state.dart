import 'package:flutter/foundation.dart';

import 'models/course.dart';
import 'repositories/course_repository.dart';
import 'services/course_service.dart';

class CourseState extends ChangeNotifier {
  final CourseRepository repository;

  CourseState({CourseRepository? repository})
    : repository = repository ?? CourseRepository(CourseService());

  List<Course> courses = [];
  final Set<String> favorites = <String>{};

  bool isLoading = false;
  String? errorMessage;

  int get favoriteCount => favorites.length;

  bool isFavorite(String code) {
    return favorites.contains(code);
  }

  Future<void> loadCourses() async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      courses = await repository.getCourses();
    } catch (error) {
      errorMessage = error.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void toggleFavorite(String code) {
    if (favorites.contains(code)) {
      favorites.remove(code);
    } else {
      favorites.add(code);
    }

    notifyListeners();
  }
}
