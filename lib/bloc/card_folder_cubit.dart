import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/card_folder_state.dart';
import '../model/card_folder.dart';
import '../repository/repository.dart';

class CardFolderCubit extends Cubit<CardFolderState>{

  Repository repository;

  CardFolderCubit(this.repository) : super(const CardFolderState.loading());

  Future<void> getAllFolders() async {
    try{
      List<CardFolder> data = await repository.findAll();
      if(data.isEmpty)
        emit(CardFolderState.empty());
      else
        emit(CardFolderState.loaded(data));
    } on Exception{
      emit(CardFolderState.error("Izgore sve!"));
    }
  }

  Future<void> remove(CardFolder folder) async {
    try{
      List<CardFolder> data = await repository.remove(folder);
      if(data.isEmpty)
        emit(CardFolderState.empty());
      else
        emit(CardFolderState.loaded(data));
    } on Exception{
      emit(CardFolderState.error("Izgore sve!"));
    }
  }

  Future<void> save(CardFolder folder) async {
    try{
      await repository.save(folder);
      var data = await repository.findAll();
      emit(CardFolderState.loaded(data));
    } on Exception{
      emit(CardFolderState.error("Izgore sve!"));
    }
  }

}