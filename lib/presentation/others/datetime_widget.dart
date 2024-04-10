import 'package:datetime_picker_formfield_new/datetime_picker_formfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// For changing the language
import 'package:flutter_localizations/flutter_localizations.dart';
// import 'package:flutter_cupertino_localizations/flutter_cupertino_localizations.dart';

const appName = 'DateTimeField Example';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appName,
      home: const MyHomePage(),
      theme: ThemeData.light().copyWith(
          inputDecorationTheme:
              const InputDecorationTheme(border: OutlineInputBorder())),
      localizationsDelegates: const [
        // ... app-specific localization delegate[s] here
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'), // English
        Locale('es'), // Spanish
        Locale('fr'), // French
        Locale('zh'), // Chinese
      ],
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            surfaceTintColor: Colors.transparent, title: const Text(appName)),
        body: SingleChildScrollView(
          child: Center(
              child: Container(
                  constraints: const BoxConstraints(maxWidth: 600),
                  child: const DateTimeForm())),
        ));
  }
}

class DateTimeForm extends StatefulWidget {
  const DateTimeForm({super.key});

  @override
  _DateTimeFormState createState() => _DateTimeFormState();
}

class _DateTimeFormState extends State<DateTimeForm> {
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          BasicDateField(),
          const SizedBox(height: 24),
          BasicTimeField(),
          const SizedBox(height: 24),
          Clock24Example(),
          const SizedBox(height: 24),
          LocaleExample(),
          const SizedBox(height: 24),
          BasicDateTimeField(),
          const SizedBox(height: 24),
          const IosStylePickers(),
          const SizedBox(height: 24),
          const ComplexDateTimeField(),
          const SizedBox(height: 24),
          ElevatedButton(
            child: const Text('Save'),
            onPressed: () => formKey.currentState?.save(),
          ),
          ElevatedButton(
            child: const Text('Reset'),
            onPressed: () => formKey.currentState?.reset(),
          ),
          ElevatedButton(
            child: const Text('Validate'),
            onPressed: () => formKey.currentState?.validate(),
          ),
        ],
      ),
    );
  }
}

class BasicDateField extends StatelessWidget {
  final format = DateFormat("yyyy-MM-dd");

  BasicDateField({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Text('Basic date field (${format.pattern})'),
      DateTimeField(
        format: format,
        onShowPicker: (context, currentValue) {
          return showDatePicker(
              context: context,
              firstDate: DateTime(1900),
              initialDate: currentValue ?? DateTime.now(),
              lastDate: DateTime(2100));
        },
      ),
    ]);
  }
}

class BasicTimeField extends StatelessWidget {
  final format = DateFormat("hh:mm a");

  BasicTimeField({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Text('Basic time field (${format.pattern})'),
      DateTimeField(
        format: format,
        onShowPicker: (context, currentValue) async {
          final TimeOfDay? time = await showTimePicker(
            context: context,
            initialTime: TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
          );
          return time == null ? null : DateTimeField.convert(time);
        },
      ),
    ]);
  }
}

class BasicDateTimeField extends StatelessWidget {
  final format = DateFormat("yyyy-MM-dd HH:mm");

  BasicDateTimeField({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Text('Basic date & time field (${format.pattern})'),
      DateTimeField(
        format: format,
        onShowPicker: (context, currentValue) async {
          return await showDatePicker(
            context: context,
            firstDate: DateTime(1900),
            initialDate: currentValue ?? DateTime.now(),
            lastDate: DateTime(2100),
          ).then((DateTime? date) async {
            if (date != null) {
              final time = await showTimePicker(
                context: context,
                initialTime:
                    TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
              );
              return DateTimeField.combine(date, time);
            } else {
              return currentValue;
            }
          });
        },
      ),
    ]);
  }
}

class IosStylePickers extends StatefulWidget {
  const IosStylePickers({super.key});

  @override
  _IosStylePickersState createState() => _IosStylePickersState();
}

class _IosStylePickersState extends State<IosStylePickers> {
  final format = DateFormat("yyyy-MM-dd HH:mm");
  DateTime? value;

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Text('iOS style pickers (${format.pattern})'),
      DateTimeField(
        initialValue: value,
        format: format,
        onShowPicker: (context, currentValue) async {
          await showCupertinoModalPopup(
              context: context,
              builder: (context) {
                return BottomSheet(
                  builder: (context) => Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        constraints: const BoxConstraints(maxHeight: 200),
                        child: CupertinoDatePicker(
                          onDateTimeChanged: (DateTime date) {
                            value = date;
                          },
                        ),
                      ),
                      TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Ok')),
                    ],
                  ),
                  onClosing: () {},
                );
              });
          setState(() {});
          return value;
        },
      ),
    ]);
  }
}

class ComplexDateTimeField extends StatefulWidget {
  const ComplexDateTimeField({super.key});

  @override
  _ComplexDateTimeFieldState createState() => _ComplexDateTimeFieldState();
}

class _ComplexDateTimeFieldState extends State<ComplexDateTimeField> {
  final format = DateFormat("yyyy-MM-dd HH:mm");
  final initialValue = DateTime.now();

  AutovalidateMode autoValidateMode = AutovalidateMode.onUserInteraction;
  bool? readOnly = true;
  bool? showResetIcon = true;
  DateTime? value = DateTime.now();
  int changedCount = 0;
  int savedCount = 0;

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Text('Complex date & time field (${format.pattern})'),
      DateTimeField(
        format: format,
        onShowPicker: (context, currentValue) async {
          return await showDatePicker(
            context: context,
            firstDate: DateTime(1900),
            initialDate: currentValue ?? DateTime.now(),
            lastDate: DateTime(2100),
          ).then((DateTime? date) async {
            if (date != null) {
              final time = await showTimePicker(
                context: context,
                initialTime:
                    TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
              );
              return DateTimeField.combine(date, time);
            } else {
              return currentValue;
            }
          });
        },
        autovalidateMode: autoValidateMode,
        validator: (date) => date == null ? 'Invalid date' : null,
        initialValue: initialValue,
        onChanged: (date) => setState(() {
          value = date;
          changedCount++;
        }),
        onSaved: (date) => setState(() {
          value = date;
          savedCount++;
        }),
        resetIcon: showResetIcon! ? const Icon(Icons.delete) : null,
        readOnly: readOnly!,
        decoration: InputDecoration(
            helperText: 'Changed: $changedCount, Saved: $savedCount, $value'),
      ),
      CheckboxListTile(
        title: const Text('autoValidate'),
        value: autoValidateMode != AutovalidateMode.disabled,
        onChanged: (value) =>
            setState(() => autoValidateMode = AutovalidateMode.always),
      ),
      CheckboxListTile(
        title: const Text('readOnly'),
        value: readOnly,
        onChanged: (value) => setState(() => readOnly = value),
      ),
      CheckboxListTile(
        title: const Text('showResetIcon'),
        value: showResetIcon,
        onChanged: (value) => setState(() => showResetIcon = value),
      ),
    ]);
  }
}

class Clock24Example extends StatelessWidget {
  final format = DateFormat("HH:mm");

  Clock24Example({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      const Text('24 hour clock'),
      DateTimeField(
        format: format,
        onShowPicker: (context, currentValue) async {
          final time = await showTimePicker(
            context: context,
            initialTime: TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
            builder: (context, child) => MediaQuery(
                data: MediaQuery.of(context)
                    .copyWith(alwaysUse24HourFormat: true),
                child: child!),
          );
          return DateTimeField.convert(time);
        },
      ),
    ]);
  }
}

class LocaleExample extends StatelessWidget {
  final format = DateFormat("yyyy-MM-dd HH:mm");

  LocaleExample({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      const Text('Changing the pickers\' language'),
      DateTimeField(
        format: format,
        onShowPicker: (context, currentValue) async {
          return await showDatePicker(
            context: context,
            firstDate: DateTime(1900),
            initialDate: DateTime.now(),
            lastDate: DateTime(2100),
            builder: (context, child) => Localizations.override(
              context: context,
              locale: const Locale('zh'),
              child: child,
            ),
          ).then((DateTime? date) async {
            if (date != null) {
              final time = await showTimePicker(
                context: context,
                initialTime:
                    TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
                builder: (context, child) => Localizations.override(
                  context: context,
                  locale: const Locale('zh'),
                  child: child,
                ),
              );
              return DateTimeField.combine(date, time);
            } else {
              return currentValue;
            }
          });
        },
      ),
    ]);
  }
}
