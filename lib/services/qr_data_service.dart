import 'package:scan_qr_app/models/models.dart';
import 'package:scan_qr_app/services/services.dart';

class QrDataService {
  Future<List<QrDataModel>> getData() async {
    final db = await SqliteService.instance.db;
    final data = await db.query('TBL_QR_DATA');
    return data.map((e) => QrDataModel.fromMap(e)).toList();
  }

  Future<int> create(QrDataModel data) async {
    final db = await SqliteService.instance.db;
    final insertData = data.toMap();
    return await db.insert('TBL_QR_DATA', insertData);
  }
}
