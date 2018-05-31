unit Unit2;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ComCtrls,
  StdCtrls, Buttons;

type

  { TForm2 }

  TForm2 = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Label1: TLabel;
    TrackBar1: TTrackBar;
    procedure BitBtn2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure TrackBar1Change(Sender: TObject);
  private

  public
  param: integer;

  end;

var
  Form2: TForm2;

implementation
uses unit1;

{$R *.lfm}

{ TForm2 }

procedure TForm2.TrackBar1Change(Sender: TObject);
begin
  param:=TrackBar1.Position;
  Label1.Caption:=inttostr(param);
end;

procedure TForm2.FormCreate(Sender: TObject);
begin

end;

procedure TForm2.BitBtn2Click(Sender: TObject);
begin

  Form1.modal_res :=  param;
  Form1.Edit1.Text:=inttostr(55);

end;

end.

