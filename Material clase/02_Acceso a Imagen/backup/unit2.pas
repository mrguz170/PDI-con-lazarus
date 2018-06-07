unit Unit2;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ComCtrls,
  Buttons, StdCtrls;

type

  { TForm2 }

  TForm2 = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Label1: TLabel;
    Label2: TLabel;
    TrackBar1: TTrackBar;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Label1Click(Sender: TObject);
    procedure Label2Click(Sender: TObject);
    procedure TrackBar1Change(Sender: TObject);
  private

  public

  end;

var
  Form2: TForm2;

implementation

{$R *.lfm}

{ TForm2 }

procedure TForm2.BitBtn1Click(Sender: TObject);
begin

end;

procedure TForm2.BitBtn2Click(Sender: TObject);
begin

end;

procedure TForm2.FormCreate(Sender: TObject);
begin
  TrackBar1.Position:=10;
end;

procedure TForm2.Label1Click(Sender: TObject);
begin

end;

procedure TForm2.Label2Click(Sender: TObject);
begin

end;

procedure TForm2.TrackBar1Change(Sender: TObject);
begin



end;

end.

