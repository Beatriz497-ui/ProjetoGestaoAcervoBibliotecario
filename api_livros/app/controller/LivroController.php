<?php

require_once "../app/model/LivroModel.php";
require_once "../app/view/LivroView.php";
require_once "../app/model/EstoqueModel.php";

class LivroController{
    private $modelLivro;
    private $viewLivro;
    private $modelEstoque;
    private $db;
    
    public function __construct($db){
        $this->db = $db;
        //conectar no DB e consultar Livros existentes
        $this->modelLivro = new LivroModel($db);
        //Exibir os Livros para o Front-end
        $this->viewLivro = new LivroView();
        //Sprint 8 
        $this->modelEstoque = new EstoqueModel($db);
    }

    public function getLivros(){
        $livros = $this->modelLivro->buscarLivros();
        $this->viewLivro->sendResponse($livros);
    }

    //[SPRINT7] Implementa Filtro Livros
    public function getLivrosPeloTitulo(){
        $titulo = $_GET['titulo'];
        if (isset($titulo)){
            $data = $this->modelLivro->getLivrosPeloTitulo($titulo);
            $this->viewLivro->sendResponse($data, 200);
        }else {
            $this->viewLivro->sendResponse([
                'message' => 'Título inválido.'
            ] , 400);
        }
    }

    //SPRINT 8 - IMPLEMENTA NOVO LIVRO
    public function createLivro() {
        $data = json_decode(file_get_contents("php://input"), true);

        if ( isset($data['titulo']) && 
        isset($data['descricao']) && 
        isset($data['autor']) ){

        $this->db->beginTransaction();
        $idLivro = $this->modelLivro->createLivro(
            $data['titulo'],
            $data['autor'],
            $data['descricao']
        );

        try{
            $this->db->beginTransaction
        if(!$idLivro){
            throw new Exeception('Não foi possível ')
        }
        $estoqueCriado = $this->modelEstoque->createEstoque($idLivro, 0);

        if(!estoqueCriado){
            throw new Exception('Não foi possível inserir o Estoque!')
        }

        $this->db->commit();
        $this->viewLivro->sendResponse([
            'message' => 'Livro criado com sucesso!',
            'id_livro' => $idLivro
        ]);
        }catch(Throwable $e){
            if($this->db->inTransaction()){
                $this->db->rollback();
            }

            $this->viewLivro->sendResponse([
                'message' => 'Erro ao cadastrar Novo Livro',
                'detalhe' =>$e->getMessage()
            ], 400);

        }
            
        }
    }else{
        $this->viewLivro->sendResponse(
            ['message' => 'Dados inválidos'],
            400
        )
    }

}
?>