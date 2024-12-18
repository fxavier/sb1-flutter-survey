import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:survey_app/features/survey/data/models/survey_model.dart';
import 'package:survey_app/features/survey/data/repositories/survey_repository.dart';

// Events
abstract class SurveyEvent extends Equatable {
  const SurveyEvent();

  @override
  List<Object> get props => [];
}

class LoadSurveys extends SurveyEvent {}

class CreateSurvey extends SurveyEvent {
  final String title;
  final String description;
  final List<String> questions;

  const CreateSurvey({
    required this.title,
    required this.description,
    required this.questions,
  });

  @override
  List<Object> get props => [title, description, questions];
}

// States
abstract class SurveyState extends Equatable {
  const SurveyState();

  @override
  List<Object> get props => [];
}

class SurveyInitial extends SurveyState {}

class SurveyLoading extends SurveyState {}

class SurveyLoaded extends SurveyState {
  final List<SurveyModel> surveys;

  const SurveyLoaded(this.surveys);

  @override
  List<Object> get props => [surveys];
}

class SurveyError extends SurveyState {
  final String message;

  const SurveyError(this.message);

  @override
  List<Object> get props => [message];
}

// Bloc
class SurveyBloc extends Bloc<SurveyEvent, SurveyState> {
  final SurveyRepository _repository;

  SurveyBloc({required SurveyRepository repository})
      : _repository = repository,
        super(SurveyInitial()) {
    on<LoadSurveys>(_onLoadSurveys);
    on<CreateSurvey>(_onCreateSurvey);
  }

  Future<void> _onLoadSurveys(LoadSurveys event, Emitter<SurveyState> emit) async {
    emit(SurveyLoading());
    try {
      final surveys = await _repository.getSurveys();
      emit(SurveyLoaded(surveys));
    } catch (e) {
      emit(SurveyError(e.toString()));
    }
  }

  Future<void> _onCreateSurvey(CreateSurvey event, Emitter<SurveyState> emit) async {
    emit(SurveyLoading());
    try {
      await _repository.createSurvey(
        event.title,
        event.description,
        event.questions,
      );
      final surveys = await _repository.getSurveys();
      emit(SurveyLoaded(surveys));
    } catch (e) {
      emit(SurveyError(e.toString()));
    }
  }
}