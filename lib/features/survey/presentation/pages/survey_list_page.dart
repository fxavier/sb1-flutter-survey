import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:survey_app/features/survey/presentation/bloc/survey_bloc.dart';
import 'package:survey_app/features/survey/presentation/widgets/survey_card.dart';
import 'package:survey_app/features/survey/presentation/pages/create_survey_page.dart';

class SurveyListPage extends StatelessWidget {
  const SurveyListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SurveyBloc(
        repository: context.read(),
      )..add(LoadSurveys()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Surveys'),
        ),
        body: BlocBuilder<SurveyBloc, SurveyState>(
          builder: (context, state) {
            if (state is SurveyLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is SurveyLoaded) {
              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: state.surveys.length,
                itemBuilder: (context, index) {
                  return SurveyCard(survey: state.surveys[index]);
                },
              );
            } else if (state is SurveyError) {
              return Center(child: Text(state.message));
            }
            return const SizedBox();
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const CreateSurveyPage(),
              ),
            );
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}