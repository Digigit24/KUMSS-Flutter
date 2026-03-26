import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../core/routing/app_router.dart';
import '../core/theme/app_theme.dart';
import '../features/auth/presentation/bloc/auth_bloc.dart';
import '../features/auth/presentation/bloc/college_selector_bloc.dart';

/// Root application widget.
class KumssApp extends StatefulWidget {
  const KumssApp({super.key});

  @override
  State<KumssApp> createState() => _KumssAppState();
}

class _KumssAppState extends State<KumssApp> {
  late final AuthBloc _authBloc;
  late final CollegeSelectorBloc _collegeSelectorBloc;
  late final AppRouter _appRouter;

  @override
  void initState() {
    super.initState();
    _authBloc = AuthBloc();
    _collegeSelectorBloc = CollegeSelectorBloc()
      ..add(CollegeSelectorLoadRequested());
    _appRouter = AppRouter(authBloc: _authBloc);

    // Check auth status on startup
    _authBloc.add(const AuthCheckRequested());
  }

  @override
  void dispose() {
    _authBloc.close();
    _collegeSelectorBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: _authBloc),
        BlocProvider.value(value: _collegeSelectorBloc),
      ],
      child: MaterialApp.router(
        title: 'KUMSS ERP',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light,
        routerConfig: _appRouter.router,
      ),
    );
  }
}
