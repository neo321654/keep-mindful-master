import 'dart:async';

import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../../features/features.dart';
import '../../../generated/assets.gen.dart';
import '../../../generated/fonts.gen.dart';
import '../../../l10n/app_loc_extension.dart';
import '../../router/router.dart';

const _logoSize = 146.0;
const _duration = Duration(milliseconds: 2000);
const _delayDuration = Duration(milliseconds: 1000);

@RoutePage()
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<double> _curvedAnimation;
  late final Animation<double> _scaleAnimation;

  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: _duration);
    _curvedAnimation = CurvedAnimation(
        parent: _animationController, curve: Curves.easeOutCirc);
    _scaleAnimation = Tween(begin: 1.5, end: 1.0).animate(_curvedAnimation);

    _animationController.addListener(() {
      if (_animationController.isCompleted) {
        _startTimer();
      }
    });

    _animationController.forward();
  }

  void _startTimer() {
    _timer = Timer(_delayDuration, _makeInit);
  }

  Future<void> _makeInit() async {
    GetIt.instance<TimerNotifier>().init();
    GetIt.instance<DurationNotifier>().init();
    GetIt.instance<WakeUpModeNotifier>().init();
    GetIt.instance<AwakeningNotifier>().init();
    GetIt.instance<BluetoothDeviceStateNotifier>().reconnect();
    await GetIt.instance<AlarmDisableQrCodeService>().generateQrIfNotExists();
    GetIt.instance<AppRouter>().replace(IndexTimerScreenRoute());
  }

  @override
  void dispose() {
    _timer?.cancel();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final loc = context.loc;

    return Scaffold(
      body: Center(
        child: AnimatedBuilder(
            animation: _animationController,
            builder: (_, __) {
              return Opacity(
                opacity: _curvedAnimation.value,
                child: Transform.scale(
                  scale: _scaleAnimation.value,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Assets.images.logoSquare
                          .image(height: _logoSize, width: _logoSize),
                      Text(
                        loc.appName.toUpperCase(),
                        style: theme.textTheme.headlineMedium?.copyWith(
                            fontFamily: FontFamily.spinnaker,
                            color: theme.colorScheme.primary),
                      )
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }
}
