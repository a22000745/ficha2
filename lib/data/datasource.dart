class DataSource{
  final _datasource = [];
  static DataSource _instance = DataSource._internal();

  DataSource._internal();

  static DataSource getInstance(){
    _instance ??= DataSource._internal();
    return _instance;
  }
  void insert(operation) => _datasource.add(operation);

  //List getAll => _datasource;

}