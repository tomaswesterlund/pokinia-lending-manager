import 'package:flutter/material.dart';
import 'package:pokinia_lending_manager/core/enums/data_repositories_enum.dart';
import 'package:pokinia_lending_manager/core/enums/table_names_enum.dart';
import 'package:pokinia_lending_manager/data/models/base_data_model.dart';
import 'package:pokinia_lending_manager/domain/services/log_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class BaseRepository<T extends BaseDataModel> extends ChangeNotifier {
  late final SupabaseClient _supabaseClient;
  SupabaseClient get supabaseClient => _supabaseClient;

  late final DataRepositories _sourceRepository;
  late final LogService _logger;
  late final TableNames _tableName;
  final T Function(Map<String, dynamic>) _fromJsonT;

  bool _initialized = false;
  bool get initialized => _initialized;

  final List<T> _data = [];
  List<T> get data => List.unmodifiable(_data);

  final List<Function> _listeners = [];

  BaseRepository(this._supabaseClient, this._sourceRepository, this._tableName,
      this._fromJsonT)
      : _logger = LogService(_sourceRepository.value);

  void startListener(Function(String source) onLoaded) {
    _supabaseClient
        .from(_tableName.value)
        .stream(primaryKey: ['id']).listen((List<Map<String, dynamic>> data) {
      var items = data.map(_fromJsonT).toList();
      _data.clear();
      _data.addAll(items);

      if (!_initialized) {
        _initialized = true;
        onLoaded(_sourceRepository.value);
      }

      informListeners();
    }).onError((error, stackTrace) {
      _logger.e('startListener', 'Error listening to: $error');
    });
  }

  @override
  void addListener(Function() listener) {
    _listeners.add(listener);
  }

  void informListeners() {
    notifyListeners();
    for (var listener in _listeners) {
      listener();
    }
  }
}
