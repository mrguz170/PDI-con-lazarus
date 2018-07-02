unit Unit3;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ComCtrls,
  StdCtrls, Buttons,LCLIntf, math;

type
  MATRGB=Array of Array of Array of Byte;

  { TForm3 }

  TForm3 = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Label1: TLabel;
    Label2: TLabel;
    TrackBar1: TTrackBar;

    procedure FormCreate(Sender: TObject);
    procedure TrackBar1Change(Sender: TObject);
  private

  public

  gamma1 :integer;
  procedure gamma(var M:MATRGB);

  end;

var
  Form3 : TForm3;
  gma,a   : real;

implementation
uses unit1;
{$R *.lfm}

{ TForm3 }
//procedimientos propios

//gamma
procedure Tform3.gamma(var M:MATRGB);
var
   i,j,k    : Integer;
begin
  for i:=0 to ANCHO-1 do begin
    for j:=0 to ALTO-1 do begin
       for k:=0 to 2 do begin
          M[i,j,k]:=trunc(255 * power((M[i,j,k]/255),gma));
       end;
      BM.Canvas.Pixels[i,j] := RGB(M[i,j,0],M[i,j,1],M[i,j,2]);
    end;
    form1.verImgHis(BM);
  end;

end;

//fin procedimientos propios
procedure TForm3.TrackBar1Change(Sender: TObject);
begin
  gamma1 := TrackBar1.Position;
  if gamma1<=10 then begin
    Label1.Caption:=FloatToStr(1/(20-gamma1));
    gma:= (1/(20-gamma1));
  end
  else begin
   Label1.Caption:=FloatToStr((gamma1-10));
   gma:= (gamma1-10);
  end;


end;

procedure TForm3.FormCreate(Sender: TObject);
begin
  gma:=1;
end;



end.

