unit App.Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, DAO.Aluno,
  Model.Aluno;

type
  TForm2 = class(TForm)
    OpenDialog1: TOpenDialog;
    Insert: TButton;
    Desconect: TButton;
    Conect: TButton;
    LabeledEdit1: TLabeledEdit;
    LabeledEdit2: TLabeledEdit;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    procedure Button1Click(Sender: TObject);
    procedure ConectClick(Sender: TObject);
    procedure DesconectClick(Sender: TObject);
    procedure InsertClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
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

procedure TForm2.Button1Click(Sender: TObject);
var
  Aluno: TModelAluno;
  DAOAluno: TDAOAluno;
begin
  Aluno:= DAOAluno.Pesquisar( StrToInt( LabeledEdit1.Text ) );
  try
    LabeledEdit1.Text:= IntToStr( Aluno.Codigo );
    LabeledEdit2.Text:= Aluno.Nome;
  finally
    FreeAndNil( Aluno );
  end;


end;

procedure TForm2.Button2Click(Sender: TObject);
var
  DAOAluno: TDAOAluno;
begin

  DAOAluno:= TDAOAluno.Create;
  DAOAluno.TEste;

end;

procedure TForm2.Button3Click(Sender: TObject);
var
  DAOAluno: TDAOAluno;

  ListaAlunos: TModelListaAlunos;

begin
  DAOAluno:= TDAOAluno.Create();
  try

    ListaAlunos:= DAOAluno.ListarTodos();
    try

    finally
      FreeAndNil( ListaAlunos );
    end;

  finally
    FreeAndNil( DAOAluno );
  end;
end;

procedure TForm2.ConectClick(Sender: TObject);
begin
  TConnMongoDB.CreateConnection( );
end;

procedure TForm2.DesconectClick(Sender: TObject);
begin
  TConnMongoDB.CloseConnection();
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
      Aluno.Codigo:= StrToInt( LabeledEdit1.Text );
      Aluno.Nome:= LabeledEdit2.Text;

      DAOAluno.Salvar( Aluno );

    finally
      FreeAndNil( DAOAluno )
    end;
  finally
    FreeAndNil( Aluno )
  end;


end;

end.