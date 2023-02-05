class Imc {
  double _peso = 0;
  double _altura = 0;

  Imc(this._peso, this._altura);

  int calcularImc() {
    return (_peso / ((_altura / 100) * (_altura / 100))).round();
  }

  double getPeso() => _peso;

  double getAltura() => _altura;
}
