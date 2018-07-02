unit Unit2;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, Buttons,
  ComCtrls, StdCtrls;

type

  { TForm2 }

  TForm2 = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Label1: TLabel;
    TrackBar1: TTrackBar;
    procedure TrackBar1Change(Sender: TObject);
  private

  public
  param : Integer
  end;

var
  Form2: TForm2;

implementation

{$R *.lfm}

{ TForm2 }


procedure TForm2.TrackBar1Change(Sender: TObject);
begin
  param:=TrackBar1.Position;
  Label1.Caption:=inttostr(param);
end;

end.

