import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:sqlite_note/src/data/data_sources/note_data_source.dart';
import 'package:sqlite_note/src/data/repositories/note_repo_impl.dart';
import 'package:sqlite_note/src/domain/repositories/note_repository.dart';
import 'package:sqlite_note/src/domain/usecases/note_usecase.dart';
import 'package:sqlite_note/src/presentation/note_provider.dart';
import 'package:sqlite_note/src/presentation/views/note_view.dart';

void main() {
  setup();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => getIt<NoteProvider>()),
      ],
      child: MyApp(),
    ),
  );
}

final getIt = GetIt.instance;

void setup() {
  getIt.registerLazySingleton(() => NoteDataSource());
  getIt.registerLazySingleton<NoteRepository>(
      () => NoteRepositoryImpl(getIt<NoteDataSource>()));
  getIt.registerLazySingleton(() => NoteUseCase(getIt<NoteRepository>()));
  getIt.registerFactory(() => NoteProvider(noteUseCase: getIt<NoteUseCase>()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: NotesView(),
    );
  }
}
