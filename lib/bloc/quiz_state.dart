import '../model/quiz.dart';

enum QuizStatus { loading, loaded, empty, error }

class QuizState {
  final QuizStatus status;
  final List<Quiz> data;
  final String errorMessage;

  const QuizState._(
      {this.status = QuizStatus.loading,
      this.data = const <Quiz>[],
      this.errorMessage = ""});

  const QuizState.loading() : this._();

  const QuizState.loaded(List<Quiz> data)
      : this._(status: QuizStatus.loaded, data: data);

  const QuizState.empty()
      : this._(status: QuizStatus.empty);

  const QuizState.error(String message)
      : this._(status: QuizStatus.error, errorMessage: message);
}
