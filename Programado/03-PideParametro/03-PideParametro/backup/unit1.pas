unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;

implementation

Uses unit2;

{$R *.lfm}

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
begin

end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  Form2.TrackBar1.Position:=form2.TrackBar1.Min;
  form2.param:=form2.TrackBar1.Position;
  form2.Label1.Caption:=inttostr(form2.param);
  Form2.showmodal;

  if Form2.ModalResult=MROK then begin

    ShowMessage('el valor del parámetro + 5 es: ' + inttostr(form2.param+5));
  end;

end;

end.

