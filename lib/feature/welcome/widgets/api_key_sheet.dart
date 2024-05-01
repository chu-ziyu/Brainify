// ignore_for_file: use_build_context_synchronously

import 'package:brainify/core/extension/context.dart';
import 'package:brainify/core/navigation/route.dart';
import 'package:brainify/core/ui/input/input_field.dart';
import 'package:brainify/core/util/secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class APIKeyBottomSheet extends StatefulWidget {
  const APIKeyBottomSheet({
    required this.apiKeyController,
    required this.isCalledFromHomePage,
    super.key,
  });

  final TextEditingController apiKeyController;
  final bool isCalledFromHomePage;

  @override
  State<APIKeyBottomSheet> createState() => _APIKeyBottomSheetState();
}

class _APIKeyBottomSheetState extends State<APIKeyBottomSheet> {
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
      },
      child: Center(
        child: AlertDialog(
          contentPadding: const EdgeInsets.all(16),
          content: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    height: 4,
                    width: 50,
                    margin: const EdgeInsets.only(bottom: 8),
                  ),
                  const SizedBox(height: 16),
                  InputField.api(
                    controller: widget.apiKeyController,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () async {
                      if (!_formKey.currentState!.validate()) {
                        return;
                      }
                      context.closeKeyboard();
                      final apiKey = widget.apiKeyController.text;

                      setState(() {
                        _isLoading = true;
                      });
                      await SecureStorage().storeApiKey(apiKey);
                      setState(() {
                        _isLoading = false;
                      });

                      if (widget.isCalledFromHomePage) {
                        Navigator.pop(context); 
                      } else {
                        AppRoute.home.go(context);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: context.colorScheme.onSurface,
                      minimumSize: const Size(double.infinity, 56),
                    ),
                    child: _isLoading
                        ? CircularProgressIndicator(
                            color: context.colorScheme.surface,
                          )
                        : Text(
                            'Submit',
                            style: context.textTheme.labelLarge!.copyWith(
                              color: context.colorScheme.surface,
                            ),
                          ),
                  ),
                  const SizedBox(height: 16),
                  InkWell(
                    onTap: () => launchUrl(
                      Uri.parse(
                        'https://makersuite.google.com/app/apikey',
                      ),
                    ),
                    child: Text(
                      'Get your Gemini API key from here',
                      style: context.textTheme.labelMedium!.copyWith(
                        color: Colors.blue,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context); 
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: context.colorScheme.onBackground,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      side: BorderSide.none,
                    ),
                    child: Text(
                      'Close',
                       style: context.textTheme.labelLarge!.copyWith(
                              color: context.colorScheme.background,
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
