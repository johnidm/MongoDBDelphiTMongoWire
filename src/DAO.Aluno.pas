unit DAO.Aluno;

interface


uses
  Model.Aluno, DAO.Base, System.SysUtils, mongoWire;


const
  COLLECTION = 'unoesc.alunos'; { database e a coleção(tabelas) }


type
  TDAOAluno = class( TDAOBase )
  public
    procedure Salvar(const AModelCliente: TModelAluno);
    procedure Excluir(const AID: Integer);
    function Pesquisar(const AID: Integer): TModelAluno;
    function ListarTodos(): TModelListaAlunos;

    procedure Teste();
  end;
 
implementation

{ TQueryMongoDB }

uses Conn.MongoDB, bsonDoc, mongoID, System.Variants;

{ TDAOAluno }

procedure TDAOAluno.Excluir(const AID: Integer);
begin
  {
  TConnMongoDB.GetCurrentConnection().Delete(
    COLLECTION, BSON( [ 'codigo', IntToStr( AID ) ] ) );
  }
end;

function TDAOAluno.ListarTodos: TModelListaAlunos;
var
  WireQuery: TMongoWireQuery;
  Document: IBSONDocument;
  Aluno: TModelAluno;

  s: string;
begin
  Result:= TModelListaAlunos.Create();

  Document:= BSON;

  WireQuery:= TMongoWireQuery.Create( TConnMongoDB.GetCurrentConnection() );
  try
    WireQuery.Query( COLLECTION, nil );

    while WireQuery.Next( Document ) do
    begin
      Aluno:= TModelAluno.Create();

      s:= VarToStr( Document[ 'id' ] );

      Aluno.Codigo:= StrToInt( VarToStr( Document[ 'codigo' ] ) );
      Aluno.Nome:= VarToStr( Document[ 'nome' ] );

      Result.Add( Aluno );
    end;

  finally
    FreeAndNil( WireQuery );
  end;

end;

function TDAOAluno.Pesquisar(const AID: Integer): TModelAluno;
var
  WireQuery: TMongoWireQuery;


  Document: IBSONDocument;
begin
  Result:= TModelAluno.Create();

  Document:= TConnMongoDB.GetCurrentConnection().Get( COLLECTION, DocumentSelect );

  Document:= BSON;
  WireQuery:= TMongoWireQuery.Create( TConnMongoDB.GetCurrentConnection() );
  try
    WireQuery.Query( COLLECTION, BSON( [ 'id', 'ObjectID("5237b774d033c807549b48e8")' ] ) );
    WireQuery.Next( Document );

    Result.Codigo:= StrToInt( VarToStr( Document[ 'codigo' ] ) );
    Result.Nome:= VarToStr( Document[ 'nome' ] );

  finally
    FreeAndNil( WireQuery );
  end;

end;



procedure TDAOAluno.Salvar(const AModelCliente: TModelAluno);
begin
  TConnMongoDB.GetCurrentConnection().Insert(
    COLLECTION, BSON( [

      'id', mongoObjectId,
      'codigo', AModelCliente.Codigo,
      'nome', AModelCliente.Nome

    ] ) );
end;

procedure TDAOAluno.Teste;
var
  q: TMongoWireQuery;

  s: string;
  d: IBSONDocument;
begin
  TConnMongoDB.GetCurrentConnection().Insert(COLLECTION ,BSON([
    'id',mongoObjectID,
    'sentence', 'this is a sentece',
    'tags',VarArrayOf(['some', 'indexing', 'words']) ]

  ));

  q:=TMongoWireQuery.Create( TConnMongoDB.GetCurrentConnection());
  q.Query(COLLECTION, BSON(['tags','words']));

  d:= BSON;

 q.Next( d );
 s:= d[ 'tags' ];

end;

end.
