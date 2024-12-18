import 'package:flutter/material.dart';
import 'package:survey_app/features/survey/data/models/survey_model.dart';

class SurveyCard extends StatelessWidget {
  final SurveyModel survey;

  const SurveyCard({
    super.key,
    required this.survey,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              survey.title,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            if (survey.description.isNotEmpty) ...[
              const SizedBox(height: 8),
              Text(
                survey.description,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
            const SizedBox(height: 16),
            Text(
              '${survey.questions.length} questions',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}