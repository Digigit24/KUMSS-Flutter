import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/theme_exports.dart';
import '../bloc/auth_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;
  late AnimationController _animController;
  late Animation<double> _fadeIn;
  late Animation<Offset> _slideUp;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(vsync: this, duration: const Duration(milliseconds: 800));
    _fadeIn = CurvedAnimation(parent: _animController, curve: Curves.easeOut);
    _slideUp = Tween<Offset>(begin: const Offset(0, 0.1), end: Offset.zero)
        .animate(CurvedAnimation(parent: _animController, curve: Curves.easeOut));
    _animController.forward();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _animController.dispose();
    super.dispose();
  }

  void _onLogin() {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<AuthBloc>().add(AuthLoginRequested(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > AppSpacing.tabletBreakpoint;

    return Scaffold(
      body: isDesktop
          ? Row(children: [
              Expanded(flex: 5, child: _buildBrandPanel()),
              Expanded(flex: 4, child: _buildLoginForm(context)),
            ])
          : _buildLoginForm(context),
    );
  }

  Widget _buildBrandPanel() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft, end: Alignment.bottomRight,
          colors: [Color(0xFF0F172A), Color(0xFF1B2A4A), Color(0xFF1E3A5F)],
        ),
      ),
      child: Stack(children: [
        Positioned.fill(child: CustomPaint(painter: _GridPatternPainter())),
        Padding(
          padding: const EdgeInsets.all(48),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(children: [
              Container(
                width: 48, height: 48,
                decoration: BoxDecoration(color: AppColors.accent, borderRadius: AppSpacing.borderRadiusMd),
                child: const Icon(Icons.school_rounded, color: Colors.white, size: 28),
              ),
              const SizedBox(width: 14),
              Text('KUMSS ERP', style: AppTypography.displaySmall.copyWith(color: Colors.white, letterSpacing: 1)),
            ]),
            const Spacer(),
            Text('Enterprise\nResource\nPlanning', style: AppTypography.displayLarge.copyWith(color: Colors.white, fontSize: 48, height: 1.15)),
            const SizedBox(height: 20),
            Text(
              'Unified management system for multi-college\ninstitutions.',
              style: AppTypography.bodyLarge.copyWith(color: Colors.white.withValues(alpha: 0.6), height: 1.7),
            ),
            const Spacer(),
            Text('© 2026 KUMSS. All rights reserved.', style: AppTypography.caption.copyWith(color: Colors.white.withValues(alpha: 0.3))),
          ]),
        ),
      ]),
    );
  }

  Widget _buildLoginForm(BuildContext context) {
    return Container(
      color: AppColors.background,
      child: SafeArea(
        child: Center(
          child: FadeTransition(
            opacity: _fadeIn,
            child: SlideTransition(
              position: _slideUp,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 400),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Mobile logo
                        if (MediaQuery.of(context).size.width <= AppSpacing.tabletBreakpoint) ...[
                          Center(
                            child: Container(
                              width: 56, height: 56,
                              decoration: BoxDecoration(color: AppColors.primary, borderRadius: AppSpacing.borderRadiusMd),
                              child: const Icon(Icons.school_rounded, color: Colors.white, size: 32),
                            ),
                          ),
                          const SizedBox(height: 24),
                        ],
                        Text('Welcome back', style: AppTypography.displaySmall),
                        const SizedBox(height: 8),
                        Text('Sign in to access your admin panel', style: AppTypography.bodyMedium.copyWith(color: AppColors.textSecondary)),
                        const SizedBox(height: 32),
                        Text('Email address', style: AppTypography.labelLarge),
                        const SizedBox(height: 6),
                        TextFormField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          validator: (v) {
                            if (v == null || v.trim().isEmpty) {
                              return 'Username is required';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(hintText: 'Enter your username', prefixIcon: Icon(Icons.email_outlined, size: 20)),
                        ),
                        const SizedBox(height: 20),
                        Text('Password', style: AppTypography.labelLarge),
                        const SizedBox(height: 6),
                        TextFormField(
                          controller: _passwordController,
                          obscureText: _obscurePassword,
                          validator: (v) => (v == null || v.isEmpty) ? 'Password is required' : null,
                          onFieldSubmitted: (_) => _onLogin(),
                          decoration: InputDecoration(
                            hintText: 'Enter your password',
                            prefixIcon: const Icon(Icons.lock_outline_rounded, size: 20),
                            suffixIcon: IconButton(
                              icon: Icon(_obscurePassword ? Icons.visibility_off_outlined : Icons.visibility_outlined, size: 20),
                              onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {},
                            child: Text('Forgot password?', style: AppTypography.bodySmall.copyWith(color: AppColors.accent, fontWeight: FontWeight.w500)),
                          ),
                        ),
                        const SizedBox(height: 20),
                        BlocConsumer<AuthBloc, AuthState>(
                          listener: (context, state) {
                            if (state is AuthError) {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message), backgroundColor: AppColors.error));
                            }
                          },
                          builder: (context, state) {
                            return SizedBox(
                              width: double.infinity,
                              height: 48,
                              child: ElevatedButton(
                                onPressed: state is AuthLoading ? null : _onLogin,
                                child: state is AuthLoading
                                    ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2, valueColor: AlwaysStoppedAnimation(Colors.white)))
                                    : Text('Sign In', style: AppTypography.buttonLarge.copyWith(color: Colors.white)),
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 20),
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: AppColors.infoSurface,
                            borderRadius: AppSpacing.borderRadiusMd,
                            border: Border.all(color: AppColors.info.withValues(alpha: 0.2)),
                          ),
                          child: Row(children: [
                            const Icon(Icons.info_outline_rounded, size: 18, color: AppColors.info),
                            const SizedBox(width: 10),
                            Expanded(child: Text('Demo: admin@kumss.edu.et / admin123', style: AppTypography.caption.copyWith(color: AppColors.infoDark))),
                          ]),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _GridPatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.white.withValues(alpha: 0.03)..strokeWidth = 1;
    const spacing = 40.0;
    for (double x = 0; x < size.width; x += spacing) canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    for (double y = 0; y < size.height; y += spacing) canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
