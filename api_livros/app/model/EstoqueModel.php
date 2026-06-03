<?php

//Sprint 8 Implementar novo Livro
class EstoqueModel {

    public function __construct ($db){
        $this->db = $db;
    } 

    public function createEstoque(id_livro, quantidade_atual){
        $stmt = $this->db->prepare("
        INSERT INTO Estoque (id_livro, quantidade_atual)
        VALUES (:id_livro, :quantidade)
        ");
        $stmt->bindValue(':id_livro', $id_livro);
        $stmt->bindValue(':quantidade', $quantidade);
        return $stmt->execute();
        
    }
}

?>