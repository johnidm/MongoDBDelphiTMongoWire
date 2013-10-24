unit App.Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, DAO.Aluno,
  Model.Aluno, Data.DB, Datasnap.DBClient, Vcl.Grids, Vcl.DBGrids, Vcl.Menus;

type
  TForm2 = class(TForm)
    Insert: TButton;
    Button1: TButton;
    Button2: TButton;
    EdtCodigo: TLabeledEdit;
    EdtNome: TLabeledEdit;
    DBGrid1: TDBGrid;
    Button3: TButton;
    DataSource1: TDataSource;
    ClientDataSet1: TClientDataSet;
    ClientDataSet1Codigo: TIntegerField;
    ClientDataSet1Nome: TStringField;
    btn1: TButton;
    Edit1: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure InsertClick(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure btn1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

uses Conn.MongoDB;

procedure TForm2.btn1Click(Sender: TObject);
var
  TempoIni, TempoFim: TTime;
  Aluno: TModelAluno;
  DAOAluno: TDAOAluno;
  Contador: Integer;
begin

  DAOAluno:= TDAOAluno.Create();
  try

    TempoIni:= Now();
    for Contador:= 1 to ( StrToInt( Edit1.Text ) ) do
    begin
      Aluno:= TModelAluno.Create();
      try
        Aluno.Codigo:= Contador;
        Aluno.Nome:= 'Nome ' + IntToStr( Contador )  ;

        DAOAluno.Salvar( Aluno );
      finally
        FreeAndNil( Aluno )
      end;
    end;
    TempoFim:= Now();

    Label2.Caption:=
      FormatDateTime( 'hh:nn:ss', TempoFim - TempoIni );

  finally
    FreeAndNil( DAOAluno )
  end;

end;

procedure TForm2.Button1Click(Sender: TObject);
var
  Aluno: TModelAluno;
  DAOAluno: TDAOAluno;
begin
  Aluno:= DAOAluno.Pesquisar( StrToInt( EdtCodigo.Text ) );
  try
    ShowMessage( Aluno.Nome );
  finally
    FreeAndNil( Aluno );
  end;
end;

procedure TForm2.Button2Click(Sender: TObject);
var
  DAOAluno: TDAOAluno;
begin
  DAOAluno:= TDAOAluno.Create();
  try
    DAOAluno.Excluir( StrToint( EdtCodigo.Text ) );
  finally
    FreeAndNil( DAOAluno );
  end;

  Button3.Click();
end;


procedure TForm2.Button3Click(Sender: TObject);
var
  DAOAluno: TDAOAluno;
  ListaAlunos: TModelListaAlunos;

  ModelAluno: TModelAluno;

  TempoIni, TempoFim: TTime;
begin
  if ( ClientDataSet1.Active ) then
    ClientDataSet1.Close;

  ClientDataSet1.CreateDataSet();
  ClientDataSet1.EmptyDataSet();

  DAOAluno:= TDAOAluno.Create();
  try
    TempoIni:= Now();

    ListaAlunos:= DAOAluno.ListarTodos();
    try
      for ModelAluno in ListaAlunos do
      begin
        ClientDataSet1.Insert;

        ClientDataSet1Codigo.AsInteger:= ModelAluno.Codigo;
        ClientDataSet1Nome.AsString:= ModelAluno.Nome;

        ClientDataSet1.Post;
      end;

    finally
      FreeAndNil( ListaAlunos );
    end;

    TempoFim:= Now();

  finally
    FreeAndNil( DAOAluno );
  end;

   Label3.Caption:=
     FormatDateTime( 'hh:nn:ss', TempoFim - TempoIni );

   Label1.Caption:= 'Total : ' + IntToStr( ClientDataSet1.RecordCount )
end;


procedure TForm2.FormCreate(Sender: TObject);
begin
  TConnMongoDB.CreateConnection( );
end;

procedure TForm2.InsertClick(Sender: TObject);
var
  Aluno: TModelAluno;
  DAOAluno: TDAOAluno;
begin

  Aluno:= TModelAluno.Create();
  try
    DAOAluno:= TDAOAluno.Create();
    try
      Aluno.Codigo:= StrToint( EdtCodigo.Text );
      Aluno.Nome:= EdtNome.Text;

      DAOAluno.Salvar( Aluno );


    finally
      FreeAndNil( DAOAluno )
    end;
  finally
    FreeAndNil( Aluno )
  end;


  Button3.Click();
end;

initialization


finalization
  TConnMongoDB.CloseConnection();

end.
