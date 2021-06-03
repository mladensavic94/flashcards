import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/quiz_state.dart';
import '../model/quiz.dart';
import '../repository/repository.dart';

class CardFolderCubit extends Cubit<QuizState>{

  Repository repository;

  CardFolderCubit(this.repository) : super(const QuizState.loading());

  Future<void> getAllFolders() async {
    try{
      List<Quiz> data = await repository.findAll();
      if(data.isEmpty)
        emit(QuizState.empty());
      else
        emit(QuizState.loaded(data));
    } on Exception{
      emit(QuizState.error("Izgore sve!"));
    }
  }

  Future<void> remove(Quiz folder) async {
    try{
      List<Quiz> data = await repository.remove(folder);
      if(data.isEmpty)
        emit(QuizState.empty());
      else
        emit(QuizState.loaded(data));
    } on Exception{
      emit(QuizState.error("Izgore sve!"));
    }
  }

  Future<void> save(Quiz folder) async {
    try{
      await repository.save(folder);
      var data = await repository.findAll();
      emit(QuizState.loaded(data));
    } on Exception{
      emit(QuizState.error("Izgore sve!"));
    }
  }

  Future<void> search(String searchWord) async {
    try{
      List<Quiz> data = await repository.search(searchWord);
        emit(QuizState.loaded(data));
    } on Exception{
      emit(QuizState.error("Izgore sve!"));

  }

}}