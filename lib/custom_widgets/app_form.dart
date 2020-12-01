import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:swift_flutter/resources/resources.dart';

final Map<String, String> globValidationMessages = {
  ValidationMessage.required: 'This field is required',
  ValidationMessage.email: 'Invalid email',
  ValidationMessage.minLength: 'Too short',
  ValidationMessage.min: 'Too short',
  ValidationMessage.maxLength: 'Too long',
  ValidationMessage.max: 'Too long',
  'indiregfrontnoface': 'Face is not clear on this card',
  'alreadyExists': 'Item already exists.'
};

final InputDecoration inputDecoration = InputDecoration(
  contentPadding: const EdgeInsets.only(left: 10, right: 10),
  filled: true,
  fillColor: Colors.white,
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(0),
  ),
//                            border: OutlineInputBorder(
//                                borderSide: new BorderSide()),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(0),
    borderSide: BorderSide(color: Color(0xFF8ED799), width: 1.0),
  ),
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(0),
    borderSide: BorderSide(color: Color(0xFF8ED799), width: 1.0),
  ),
  errorBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(0),
    borderSide: BorderSide(color: Colors.red, width: 1.0),
  ),
  focusedErrorBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(0),
    borderSide: BorderSide(color: Colors.red, width: 1.0),
  ),
);

class AppTextField extends ReactiveTextField {
  AppTextField(
      {@required String formControlName,
      @required String hintText,
      Map<String, String> validationMessages = const {},
      bool obscureText = false})
      : super(
          formControlName: formControlName,
          obscureText: obscureText,
          cursorColor: Resources.APP_PRIMARY_COLOR,
          validationMessages: (e) {
            return {}
              ..addAll(globValidationMessages)
              ..addAll(validationMessages);
          },
          decoration: inputDecoration.copyWith(hintText: hintText),
        );
}

class AppPhoneNumberField extends ReactiveFormField<String> {
  AppPhoneNumberField({
    Key key,
    SelectorConfig selectorConfig,
    ValueChanged<PhoneNumber> onInputChanged,
    ValueChanged<bool> onInputValidated,
    VoidCallback onSubmit,
    ValueChanged<String> onFieldSubmitted,
    String Function(String) validator,
    Function(String) onSaved,
    TextEditingController textFieldController,
    TextInputAction keyboardAction,
    PhoneNumber initialValue,
    String hintText,
    String errorMessage,
    double selectorButtonOnErrorPadding,
    int maxLength,
    bool isEnabled,
    bool formatInput,
    bool autoFocus,
    bool autoFocusSearch,
    AutovalidateMode autoValidateMode,
    bool ignoreBlank,
    bool countrySelectorScrollControlled,
    String locale,
    TextStyle textStyle,
    TextStyle selectorTextStyle,
    InputBorder inputBorder,
    InputDecoration searchBoxDecoration,
    FocusNode focusNode,
    List<String> countries,
    String formControlName,
    FormControl formControl,
    Map<String, String> validationMessages = const {},
    ControlValueAccessor valueAccessor,
    ShowErrorsFunction showErrors,
    EdgeInsets labelPadding = const EdgeInsets.only(bottom: 8),
    bool requiredField = false,
    String label,
  }) : super(
            key: key,
            formControl: formControl,
            formControlName: formControlName,
            valueAccessor: valueAccessor,
            validationMessages: (e) {
              return {}
                ..addAll(globValidationMessages)
                ..addAll(validationMessages);
            },
            showErrors: showErrors,
            builder: (field) {
              final state = field as _AppPhoneNumberField;
              final InputDecoration effectiveDecoration =
                  (const InputDecoration()).applyDefaults(
                      Theme.of(state.context).inputDecorationTheme);
              return Theme(
                data: ThemeData.light().copyWith(
                  colorScheme:
                      ColorScheme.light(primary: Resources.APP_PRIMARY_COLOR),
                ),
                child: InternationalPhoneNumberInput(
                  onInputChanged: (e) {
                    field.didChange(e.phoneNumber);
                  },
                  hintText: hintText,
                  textFieldController: state._textController,
                  focusNode: state._focusController.focusNode,
                  errorMessage: field.errorText,
                  initialValue: initialValue,
                  countries: ['NG'],
                  formatInput: true,
                  selectorConfig: SelectorConfig(
                      selectorType: PhoneInputSelectorType.DROPDOWN,
                      backgroundColor: Colors.white),
                  inputDecoration: inputDecoration.copyWith(hintText: hintText)
                ),
              );
            });

  @override
  ReactiveFormFieldState<String> createState() {
    return _AppPhoneNumberField();
  }
}

class _AppPhoneNumberField extends ReactiveFormFieldState<String> {
  TextEditingController _textController;
  FocusNodeController _focusController = FocusNodeController();

  @override
  void initState() {
    super.initState();

    final initialValue = this.value;
    _textController = TextEditingController(
        text: initialValue == null ? '' : initialValue.toString());
  }

  @override
  void subscribeControl() {
    this.control.registerFocusController(_focusController);
    super.subscribeControl();
  }

  @override
  void unsubscribeControl() {
    this.control.unregisterFocusController(_focusController);
    _focusController.dispose();

    super.unsubscribeControl();
  }

  @override
  void onControlValueChanged(dynamic value) {
    _textController.text = (value == null) ? '' : value.toString();
    super.onControlValueChanged(value);
  }

  @override
  ControlValueAccessor selectValueAccessor() {
    if (this.control is FormControl<int>) {
      return IntValueAccessor();
    } else if (this.control is FormControl<double>) {
      return DoubleValueAccessor();
    } else if (this.control is FormControl<DateTime>) {
      return DateTimeValueAccessor();
    } else if (this.control is FormControl<TimeOfDay>) {
      return TimeOfDayValueAccessor();
    }

    return super.selectValueAccessor();
  }
}
