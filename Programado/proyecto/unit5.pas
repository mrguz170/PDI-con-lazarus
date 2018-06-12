unit Unit5;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, Buttons,
  ComCtrls, StdCtrls,math,LCLintf;

type
  MATRGB=Array of Array of Array of Byte;

  { TForm5 }

  TForm5 = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Label1: TLabel;
    Label2: TLabel;
    TrackBar1: TTrackBar;
    procedure TrackBar1Change(Sender: TObject);
  private

  public
  alpha   : Integer;
  procedure TanHiper(var M:MATRGB);


  end;

var
  Form5: TForm5;

implementation
uses unit1;

{$R *.lfm}

{ TForm5 }
//MEOTODOS PROPIOS

//Tan H --No funciona bien
procedure tform5.TanHiper(var M:MATRGB);
var
   i,j,k    : Integer;
begin

  for i:=0 to ANCHO-1 do begin
    for j:=0 to ALTO-1 do begin
       for k:=0 to 2 do begin
          M[i,j,k]:=trunc((255div 2) * (1 + tanh( alpha *(M[i,j,k]- (255 div 2)))));
       end;
      BM.Canvas.Pixels[i,j] := RGB(M[i,j,0],M[i,j,1],M[i,j,2]);
    end;
    form1.verImgHis();
  end;

end;


//fin procedimientos propios
procedure TForm5.TrackBar1Change(Sender: TObject);
begin
  alpha := TrackBar1.Position;
  Label1.Caption:=inttostr(alpha);
end;

end.

