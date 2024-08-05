class Livro {
  final String id;
  final String titulo;
  final String autor;
  final String editora;
  final String anopublicacao;
  final String genero;
  String estado;
  final String avatarUrl;
  String nomecliente;
  String telefonecliente;

  Livro({
    required this.id,
    required this.titulo,
    required this.autor,
    required this.editora,
    required this.anopublicacao,
    required this.genero,
    required this.estado,
    required this.avatarUrl,
    required this.nomecliente,
    required this.telefonecliente,
  });
}
