import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/services/database.dart';
import 'data/datasources/local_data_sources.dart';
import 'data/repositories/repository_impl.dart';
import 'domain/repositories/repository.dart';
import 'domain/usecases/add_task_usecase.dart';
import 'domain/usecases/add_to_fav_usecase.dart';
import 'domain/usecases/complete_task_usecase.dart';
import 'domain/usecases/delete_task_usecase.dart';
import 'domain/usecases/edit_task_usecase.dart';
import 'domain/usecases/get_all_tasks_usecase.dart';
import 'domain/usecases/get_complete_tasks_usecase.dart';
import 'domain/usecases/get_fav_tasks_usecase.dart';
import 'domain/usecases/get_tasks_by_specific_usecase.dart';
import 'domain/usecases/get_uncompleted_taks_usecase.dart';
import 'domain/usecases/search_in_tasks_usecase.dart';
import 'presentation/cubit/todo_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Features - Todo
  sl.registerFactory(
    () => TodoBloc(
      addTaskUseCase: sl(),
      addToFavUsecase: sl(),
      allTasksUsecase: sl(),
      completeTaskUsecase: sl(),
      completedTasksUsecase: sl(),
      deleteTaskUsecase: sl(),
      editTaskUsecase: sl(),
      favoriteTasksUsecase: sl(),
      getUnCompletedTasksUsecase: sl(),
      searchInTasksUsecase: sl(),
      tasksBySpecificDateUsecase: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => AddTaskUseCase(sl()));
  sl.registerLazySingleton(() => AddToFavUsecase(sl()));
  sl.registerLazySingleton(() => CompleteTaskUsecase(sl()));
  sl.registerLazySingleton(() => DeleteTaskUsecase(sl()));
  sl.registerLazySingleton(() => EditTaskUsecase(sl()));
  sl.registerLazySingleton(() => GetAllTasksUsecase(sl()));
  sl.registerLazySingleton(() => GetCompletedTasksUsecase(sl()));
  sl.registerLazySingleton(() => GetFavoriteTasksUsecase(sl()));
  sl.registerLazySingleton(() => GetTasksBySpecificDateUsecase(sl()));
  sl.registerLazySingleton(() => GetUnCompletedTasksUsecase(sl()));
  sl.registerLazySingleton(() => SearchInTasksUsecase(sl()));

  // Repository
  sl.registerLazySingleton<Repository>(
    () => RepositoryImpl(sl()),
  );

  //Core
  DbHelper dbHelper = DbHelper();
  await dbHelper.createDatabase();

  // Data sources
  sl.registerLazySingleton<LocalDataSources>(
      () => LocalDataSourcesImpl(dbHelper));
  
  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
}
