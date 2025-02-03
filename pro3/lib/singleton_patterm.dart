class SingletonPatterm {
  int? id;
  static SingletonPatterm? _instance;

  SingletonPatterm._();

  static SingletonPatterm get instance {
    _instance ??= SingletonPatterm._();
    return _instance!;
  }
}
//para pegar instacia dessa classe no main