import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upentregas/app/modules/otp/models/otp_input_model.dart';
import 'package:upentregas/app/modules/veiculo/veiculo_view.dart';
import 'package:upentregas/app/shared/styles/app_text_styles.dart';
import 'package:upentregas/app/shared/textcontrollers/textfield_controllers.dart';
import 'package:upentregas/app/shared/ui/messages/message_provisorio.dart';

class OTPView extends StatefulWidget {
  final String? mobileNumber;
  const OTPView({
    Key? key,
    required this.mobileNumber,
  })  : assert(mobileNumber != null),
        super(key: key);

  @override
  _OTPViewState createState() => _OTPViewState();
}

class _OTPViewState extends State<OTPView> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final PinDecoration pinDecoration = const UnderlineDecoration(
    enteredColor: Colors.black,
    hintText: '------',
  );

  bool isCodeSent = false;
  String _verificationId = '';

  void _onVerifyCode() async {
    setState(() {
      isCodeSent = true;
    });
    // ignore: prefer_function_declarations_over_variables
    final PhoneVerificationCompleted verificationCompleted =
        (AuthCredential phoneAuthCredential) {
      _firebaseAuth
          .signInWithCredential(phoneAuthCredential)
          .then((UserCredential value) {
        if (value.user != null) {
          Get.to(() => const VeiculoView());
          pinEditingController.clear();
        } else {
          MessageProvisorio().showMessage(message: 'validationerror'.tr);
        }
      }).catchError((error) {
        MessageProvisorio().showMessage(message: 'tryagain'.tr);
      });
    };
    // ignore: prefer_function_declarations_over_variables
    final PhoneVerificationFailed verificationFailed =
        (FirebaseAuthException authException) {
      MessageProvisorio().showMessage(message: authException.message!);
      setState(() {
        isCodeSent = false;
      });
    };

    // ignore: prefer_function_declarations_over_variables
    final PhoneCodeSent codeSent =
        (String verificationId, [int? forceResendingToken]) async {
      _verificationId = verificationId;
      setState(() {
        _verificationId = verificationId;
      });
    };
    // ignore: prefer_function_declarations_over_variables
    final PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verificationId) {
      _verificationId = verificationId;
      setState(() {
        _verificationId = verificationId;
      });
    };

    await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: '${widget.mobileNumber}',
        timeout: const Duration(seconds: 60),
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
  }

  void _onFormSubmitted() async {
    AuthCredential _authCredential = PhoneAuthProvider.credential(
        verificationId: _verificationId, smsCode: pinEditingController.text);

    _firebaseAuth
        .signInWithCredential(_authCredential)
        .then((UserCredential value) {
      if (value.user != null) {
        Get.to(() => const VeiculoView());
      } else {
        MessageProvisorio().showMessage(message: 'validateotp'.tr);
      }
    }).catchError((error) {
      //print(AppLocalizations.of(context)!.wrong);
    });
  }

  @override
  void initState() {
    super.initState();
    _onVerifyCode();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'verifydetails'.tr,
          style: AppTextStyles.title16,
        ),
        centerTitle: true,
        bottom: PreferredSize(
          child: Padding(
            padding: EdgeInsets.only(bottom: Get.height * 0.002),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  direction: Axis.horizontal,
                  children: [
                    Text.rich(
                      TextSpan(
                        text: "${'codesent'.tr} ${widget.mobileNumber}",
                        style: AppTextStyles.title16,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ],
            ),
          ),
          preferredSize: Size.fromHeight(Get.width * 0.03),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: PinInputTextField(
                pinLength: 6,
                decoration: pinDecoration,
                controller: pinEditingController,
                autoFocus: true,
                textInputAction: TextInputAction.done,
                onSubmit: (pin) {
                  if (pin.length == 6) {
                    _onFormSubmitted();
                  } else {
                    /*showToast(
                        AppLocalizations.of(context)!.invalidcode, Colors.red);*/
                  }
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child: Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (pinEditingController.text.length == 6) {
                        _onFormSubmitted();
                      } else {
                        /*showToast(AppLocalizations.of(context)!.invalidcode,
                            Colors.red);*/
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                      padding: const EdgeInsets.all(16.0),
                      primary: Theme.of(context).primaryColor,
                    ),
                    child: Text(
                      'verifycode'.tr,
                      style: AppTextStyles.button,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
