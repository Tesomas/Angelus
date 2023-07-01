import 'package:angelus/logic/blocs/settings_bloc/settings_bloc.dart';
import 'package:angelus/logic/blocs/statistics_bloc/statistics_bloc.dart';
import 'package:angelus/services/notification_service.dart';
import 'package:angelus/widgets/AutoCloseDrawer.dart';
import 'package:angelus/widgets/angelus_app.dart';
import 'package:angelus/widgets/pages/angelus_screen/angelus_screen.dart';
import 'package:angelus/widgets/pages/angelus_screen/statistics_screen/statistics_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(storageDirectory:
    await getTemporaryDirectory()
  );
  await NotificationService().init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MultiBlocProvider(
      providers: [
        BlocProvider<StatisticsBloc>(create: (context)=> StatisticsBloc()),
        BlocProvider<SettingsBloc>(create: (context) => SettingsBloc())
      ],
      child: MaterialApp(
        title: 'Angelus',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: const ColorScheme.dark()
        ),
        home: const AngelusApp(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {


    return MultiBlocProvider(

      providers: [
        BlocProvider<StatisticsBloc>(create: (context) => StatisticsBloc()),

      ],
      child: AngelusApp(),
    );
  }
}
