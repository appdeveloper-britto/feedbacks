import 'package:feedbacks/feedbacks/feedbacks_bloc.dart';
import 'package:feedbacks/feedbacks/feedbacks_event.dart';
import 'package:feedbacks/feedbacks/feedbacks_page.dart';
import 'package:feedbacks/feedbacks/feedbacks_repository.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<FeedbacksBloc>(
          create: (_) =>
              FeedbacksBloc(feedbacksRepository: FeedbacksRepository())
                ..add(LoadFeedbacks()),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: FeedbacksPage(),
      ),
    );
  }
}
