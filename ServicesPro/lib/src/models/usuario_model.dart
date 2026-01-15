// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UsuarioModel {
  String? nome;
  String? email;
  String? senha;
  String? foto;
  String? tipoUsuario;
  String? tipoPessoa;
  DateTime? dataNascimento;
  String? telefone;
  String? endereco;
  int? categoriaPrestador;
  String? nomeCategoria;
  num? avalicao;
  int? qtdeServicos;
  bool? termosPolitica;
  String? cpf_cnpj;
  UsuarioModel({
    this.nome,
    this.email,
    this.foto,
    this.tipoUsuario,
    this.tipoPessoa,
    this.senha,
    this.dataNascimento,
    this.telefone,
    this.endereco,
    this.categoriaPrestador,
    this.nomeCategoria,
    this.avalicao,
    this.qtdeServicos,
    this.termosPolitica,
    this.cpf_cnpj,
  });

  UsuarioModel copyWith({
    String? nome,
    String? email,
    String? foto,
    String? senha,
    String? tipoUsuario,
    String? tipoPessoa,
    DateTime? dataNascimento,
    String? telefone,
    String? endereco,
    int? categoriaPrestador,
    String? nomeCategoria,
    num? avalicao,
    int? qtdeServicos,
    bool? termosPolitica,
    String? cpf_cnpj,
  }) {
    return UsuarioModel(
      nome: nome ?? this.nome,
      email: email ?? this.email,
      foto: foto ?? this.foto,
      tipoUsuario: tipoUsuario ?? this.tipoUsuario,
      tipoPessoa: tipoPessoa ?? this.tipoPessoa,
      dataNascimento: dataNascimento ?? this.dataNascimento,
      telefone: telefone ?? this.telefone,
      endereco: endereco ?? this.endereco,
      categoriaPrestador: categoriaPrestador ?? this.categoriaPrestador,
      nomeCategoria: nomeCategoria ?? this.nomeCategoria,
      avalicao: avalicao ?? this.avalicao,
      qtdeServicos: qtdeServicos ?? this.qtdeServicos,
      senha: senha ?? this.senha,
      termosPolitica: termosPolitica ?? this.termosPolitica,
      cpf_cnpj: cpf_cnpj ?? this.cpf_cnpj,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'nome': nome,
      'email': email,
      'foto': foto,
      'tipoUsuario': tipoUsuario,
      'tipoPessoa': tipoPessoa,
      'dataNascimento': dataNascimento != null
          ? '${dataNascimento!.year.toString().padLeft(4, '0')}-'
                '${dataNascimento!.month.toString().padLeft(2, '0')}-'
                '${dataNascimento!.day.toString().padLeft(2, '0')}'
          : null,

      'telefone': telefone,
      'endereco': endereco,
      'categoriaPrestador': categoriaPrestador,
      'nomeCategoria': nomeCategoria,
      'avalicao': avalicao,
      'qtdeServicos': qtdeServicos,
      'senha': senha,
      'termosPolitica': termosPolitica,
      'cpf_cnpj': cpf_cnpj,
    };
  }

  factory UsuarioModel.fromMap(Map<String, dynamic> map) {
    return UsuarioModel(
      nome: map['nome'] != null ? map['nome'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      foto: map['foto'] != null ? map['foto'] as String : null,
      tipoUsuario: map['tipoUsuario'] != null
          ? map['tipoUsuario'] as String
          : null,
      tipoPessoa: map['tipoPessoa'] != null
          ? map['tipoPessoa'] as String
          : null,
      dataNascimento: map['dataNascimento'] != null
          ? DateTime.parse(map['dataNascimento'] as String)
          : null,
      telefone: map['telefone'] != null ? map['telefone'] as String : null,
      endereco: map['endereco'] != null ? map['endereco'] as String : null,
      categoriaPrestador: map['categoriaPrestador'] != null
          ? map['categoriaPrestador'] as int
          : null,
      nomeCategoria: map['nomeCategoria'] != null
          ? map['nomeCategoria'] as String
          : null,
      avalicao: map['avalicao'] != null ? map['avalicao'] as num : null,
      qtdeServicos: map['qtdeServicos'] != null
          ? map['qtdeServicos'] as int
          : null,
      senha: map['senha'] ?? "",
      termosPolitica: map['termosPolitica'] ?? false,
      cpf_cnpj: map['cpf_cnpj'] ?? "",
    );
  }

  String toJson() => json.encode(toMap());

  factory UsuarioModel.fromJson(String source) =>
      UsuarioModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UsuarioModel(nome: $nome, email: $email, foto: $foto, tipoUsuario: $tipoUsuario, tipoPessoa: $tipoPessoa, dataNascimento: $dataNascimento, telefone: $telefone, endereco: $endereco, categoriaPrestador: $categoriaPrestador, nomeCategoria: $nomeCategoria, avalicao: $avalicao, qtdeServicos: $qtdeServicos, senha: $senha, termosPolitica: $termosPolitica, cpf_cnpj: $cpf_cnpj)';
  }

  @override
  bool operator ==(covariant UsuarioModel other) {
    if (identical(this, other)) return true;

    return other.nome == nome &&
        other.email == email &&
        other.foto == foto &&
        other.tipoUsuario == tipoUsuario &&
        other.tipoPessoa == tipoPessoa &&
        other.dataNascimento == dataNascimento &&
        other.telefone == telefone &&
        other.endereco == endereco &&
        other.categoriaPrestador == categoriaPrestador &&
        other.nomeCategoria == nomeCategoria &&
        other.avalicao == avalicao &&
        other.qtdeServicos == qtdeServicos &&
        other.senha == senha &&
        other.termosPolitica == termosPolitica &&
        other.cpf_cnpj == cpf_cnpj;
  }

  @override
  int get hashCode {
    return nome.hashCode ^
        email.hashCode ^
        foto.hashCode ^
        tipoUsuario.hashCode ^
        tipoPessoa.hashCode ^
        dataNascimento.hashCode ^
        telefone.hashCode ^
        endereco.hashCode ^
        categoriaPrestador.hashCode ^
        nomeCategoria.hashCode ^
        avalicao.hashCode ^
        qtdeServicos.hashCode ^
        senha.hashCode ^
        termosPolitica.hashCode ^
        cpf_cnpj.hashCode;
  }
}
