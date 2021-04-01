import 'package:flashcards/model/card_folder.dart';

enum CardFolderStatus { loading, loaded, empty, error }

class CardFolderState {
  final CardFolderStatus status;
  final List<CardFolder> data;
  final String errorMessage;

  const CardFolderState._(
      {this.status = CardFolderStatus.loading,
      this.data = const <CardFolder>[],
      this.errorMessage = ""});

  const CardFolderState.loading() : this._();

  const CardFolderState.loaded(List<CardFolder> data)
      : this._(status: CardFolderStatus.loaded, data: data);

  const CardFolderState.empty()
      : this._(status: CardFolderStatus.empty);

  const CardFolderState.error(String message)
      : this._(status: CardFolderStatus.error, errorMessage: message);
}
