<?php

class LivroModel {
    private $db;

    public function __construct($db){
        $this->db = $db;
    }

    public function buscarLivros() {
        $stmt = $this->db->query("
            select 
                l.id_livro, l.titulo, l.descricao, l.autor,
                e.quantidade_atual
            as estoque
            from livros l 
            inner join estoque e 
            on l.id_livro = e.id_livro
        ");
        return $stmt->fetchAll(PDO::FETCH_ASSOC);
    }

    public function getLivrosPeloTitulo($titulo){
        $stmt = $this->db->prepare("
            select * 
            from livros
            join Estoque on Estoque.id_livro = Livros.id_livro
            where livros.titulo LIKE :titulo
        ");
        $stmt->bindValue(':titulo', '%' . $titulo . '%');
        $stmt->execute();
        return $stmt->fetchAll(PDO::FETCH_ASSOC);
    }
}

?>