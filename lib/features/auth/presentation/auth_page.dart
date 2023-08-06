import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:test_app/common/theme/app_colors.dart';
import 'package:test_app/common/theme/app_fonts.dart';
import 'package:test_app/common/theme/assets.dart';
import 'package:test_app/common/theme/text_form_field_decoration.dart';
import 'package:test_app/common/utils/toast.dart';
import 'package:test_app/common/widgets/custom_loader_overlay.dart';
import 'package:test_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:test_app/routes/router.gr.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  late bool _passwordVisible;

  @override
  void initState() {
    super.initState();
    _passwordVisible = true;
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthLoading) {
          context.loaderOverlay.show();
        } else if (state is AuthLoaded) {
          context.loaderOverlay.hide();
          AutoRouter.of(context).replace(const HomePageRoute());
        } else if (state is AuthError) {
          context.loaderOverlay.hide();
          Toast.show(context, 'Ошибка авторизации', ToastStatus.error);
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: CustomLoaderOverlay(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Вход',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w500,
                      color: AppColors.lightBlack,
                      fontFamily: AppFontFamily.ubuntu,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Введите данные для входа',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: AppColors.grey,
                      fontFamily: AppFontFamily.roboto,
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      enabledBorder: TFFDecoration.enabledBorder,
                      focusedBorder: TFFDecoration.focusedBorder,
                      floatingLabelStyle: TFFDecoration.floatingLabelStyle,
                      labelStyle: TFFDecoration.labelStyle,
                    ),
                    style: TFFDecoration.textStyle,
                    cursorColor: AppColors.red,
                    onTapOutside: (_) => FocusScope.of(context).requestFocus(FocusNode()),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: !_passwordVisible,
                    decoration: InputDecoration(
                      labelText: 'Пароль',
                      enabledBorder: TFFDecoration.enabledBorder,
                      focusedBorder: TFFDecoration.focusedBorder,
                      floatingLabelStyle: TFFDecoration.floatingLabelStyle,
                      labelStyle: TFFDecoration.labelStyle,
                      suffixIcon: IconButton(
                        icon: SvgPicture.asset(
                          _passwordVisible ? AssetIcons.icEye : AssetIcons.icEyeOff,
                        ),
                        onPressed: () {
                          setState(() {
                            _passwordVisible = !_passwordVisible;
                          });
                        },
                      ),
                    ),
                    style: TFFDecoration.textStyle,
                    cursorColor: AppColors.red,
                    onTapOutside: (_) => FocusScope.of(context).requestFocus(FocusNode()),
                  ),
                  const SizedBox(height: 32),
                  SizedBox(
                    height: 48,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => BlocProvider.of<AuthBloc>(context).add(
                        AuthorizeEvent(
                          email: _emailController.text,
                          password: _passwordController.text,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(backgroundColor: AppColors.blue),
                      child: const Text(
                        'Войти',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                          color: AppColors.white,
                          fontFamily: AppFontFamily.roboto,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
