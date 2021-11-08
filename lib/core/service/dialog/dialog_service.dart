abstract class DialogService {
  Future<dynamic>? showConfirmationDialog({
    required String title,
    required String middleText,
    required Function onCancel,
    required Function onContinue,
    required String textConfirm,
    required bool willPop,
  });

  Future<dynamic>? showLoadingDialog({
    required String message,
    required bool willPop,
  });
}
