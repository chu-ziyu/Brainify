import 'package:brainify/core/app/theme_provider.dart';
import 'package:brainify/core/config/assets_constants.dart';
import 'package:brainify/core/extension/context.dart';
import 'package:brainify/feature/home/widgets/background_curves_painter.dart';
import 'package:brainify/feature/welcome/widgets/api_key_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WelcomePage extends ConsumerWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Padding(
          // ignore: use_named_constants
          padding: const EdgeInsets.all(0),
          child: Stack(
            children: [
              Positioned(
                left: -300,
                top: -00,
                child: Container(
                  height: 500,
                  width: 600,
                  decoration: BoxDecoration(
                    gradient: RadialGradient(
                      colors: [
                        Theme.of(context)
                            .colorScheme
                            .onSurface
                            .withOpacity(0.3),
                        Theme.of(context)
                            .colorScheme
                            .background
                            .withOpacity(0.5),
                      ],
                    ),
                  ),
                ),
              ),
              CustomPaint(
                painter: BackgroundCurvesPainter(),
                size: Size.infinite,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: context.colorScheme.background,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Keep up with BrainKitty',
                              style: TextStyle(
                                color: context.colorScheme.onSurface,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(width: 4),
                            Image.asset(
                              AssetConstants.aiKittyLogo,
                              scale: 23,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Image.asset(
                      AssetConstants.onboardingLogo,
                    ),
                    Text(
                      'Think Analyze Discover with Brainify',
                      style: context.textTheme.bodyLarge!.copyWith(
                        fontSize: 32,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1.5,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        final TextEditingController apiKeyController =
                            TextEditingController();

                        showModalBottomSheet<void>(
                          context: context,
                          isScrollControlled: true,
                          shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.vertical(top: Radius.circular(20)),
                          ),
                          builder: (context) {
                            return APIKeyBottomSheet(
                              apiKeyController: apiKeyController,
                              isCalledFromHomePage: false,
                            );
                          },
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: context.colorScheme.onSurface,
                        minimumSize: const Size(double.infinity, 56),
                      ),
                      child: Text(
                        'Try BrainKitty!',
                        style: context.textTheme.labelLarge!.copyWith(
                          color: context.colorScheme.surface,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 20,
                right: 20,
                child: FloatingActionButton(
                  onPressed: () => 
                    ref.read(themeProvider.notifier).toggleTheme(),
                  mini: true,
                  child: const Icon(Icons.brightness_6), 
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
