import 'package:flutter/foundation.dart';
import 'package:flutter_internet_speed_test/flutter_internet_speed_test.dart';

class InternetSpeedProvider with ChangeNotifier {
  bool _loading = false;
  double _transferRate = 0;
  double _downloadTransferRate = 0;
  double _uploadTransferRate = 0;
  double _downloadProgressPercent = 0;

  bool get loading => _loading;
  double get transferRate => _transferRate;
  double get downloadTransferRate => _downloadTransferRate;
  double get uploadTransferRate => _uploadTransferRate;
  double get downloadProgressPercent => _downloadProgressPercent;

  void setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  void setDownloadTransferRate(double value) {
    _downloadTransferRate = value;
    notifyListeners();
  }

  void setTransferRate(double value) {
    _transferRate = value;
    notifyListeners();
  }

  void setUploadTransferRate(double value) {
    _uploadTransferRate = value;
    notifyListeners();
  }

  void setDownloadProgressPercent(double value) {
    _downloadProgressPercent = value.roundToDouble();
    notifyListeners();
  }

  void startButtonPressed() {
    final speedTest = FlutterInternetSpeedTest();
    speedTest.startTesting(
      onStarted: () {
        if (kDebugMode) {
          print('Test Started');
        }
      },
      onCompleted: (TestResult download, TestResult upload) {
        // You can add code here to handle what should happen when the test is completed.
        if (kDebugMode) {
          print('Download speed: ${download.transferRate} Mbps');
        }
        setTransferRate(0);
        setDownloadProgressPercent(0);
        setDownloadTransferRate(download.transferRate);
        setUploadTransferRate(upload.transferRate);
        if (kDebugMode) {
          print('Upload speed: ${upload.transferRate} Mbps');
        }
      },
      onProgress: (double percent, TestResult data) {
        setDownloadProgressPercent(percent);
        setTransferRate(data.transferRate);
      },
      onError: (String errorMessage, String speedTestError) {
        if (kDebugMode) {
          print('Error : $errorMessage ');
        }
      },
      onDefaultServerSelectionInProgress: () {},
      onDefaultServerSelectionDone: (Client? client) {},
      onDownloadComplete: (TestResult data) {
        setTransferRate(0);
        setDownloadTransferRate(data.transferRate);
        if (kDebugMode) {
          print('Test DownloadComplete ');
        }
      },
      onUploadComplete: (TestResult data) {
        setTransferRate(0);
        setUploadTransferRate(data.transferRate);
        if (kDebugMode) {
          print('Test UploadComplete');
        }
      },
      onCancel: () {
        if (kDebugMode) {
          print('Test cancelled');
        }
      },
    );
  }
}
