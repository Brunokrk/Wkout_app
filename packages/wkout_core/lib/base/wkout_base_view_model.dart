abstract class WkoutBaseViewModel extends ChangeNotifier {
    bool _screenLoading = false;
    bool get screenLoading => _screenLoading;

    void toggleScreenLoading() {
        _screenLoading = !_screenLoading;
        notifyListeners();
    }

    bool _screenError = false;
    bool get screenError => _screenError;

    void toggleScreenError() {
        _screenError = !_screenError;
        notifyListeners();
    }

    String? _screenErrorText;
    String? get screenErrorText => _screenErrorText;

    void setScreenErrorText(String? text) {
        _screenErrorText = text;
        notifyListeners();
    }

    void clearScreenError() {  
        _screenErrorText = null;
        notifyListeners();
    }
}
