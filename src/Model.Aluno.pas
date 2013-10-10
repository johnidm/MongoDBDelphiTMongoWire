unit Model.Aluno;

interface

uses
  Generics.Collections;

type
  TModelAluno = class
  private
    FCodigo: Integer;
    FNome: string;
  public
    property Codigo:  Integer read FCodigo write FCodigo;
    property Nome: string read FNome write FNome;
  end;

  TModelListaAlunos = class( TObjectList< TModelAluno > )
  end;

implementation

end.
