unit Unit4;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ExtCtrls, Buttons,LCLintf,math;

type

  { TForm4 }
  //tipo propio definido
  MATCONV=Array[0..2,0..2] of Integer;
  MATRGB=Array of Array of Array of Byte;

  TForm4 = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    RadioButton3: TRadioButton;
    procedure RadioButton1Change(Sender: TObject);
    procedure RadioButton2Change(Sender: TObject);
    procedure RadioButton3Change(Sender: TObject);
  private

  public
  procedure conv(var M:MATRGB);
  procedure test(var M:MATRGB);


  end;

CONST
  MASC: MATCONV=((-1,-2,-1),
                (0, 0, 0),
                (1, 2, 1));


var
  Form4: TForm4;

implementation
uses unit1;
{$R *.lfm}

{ TForm4 }

//metodos propios
procedure Tform4.test(var M:MATRGB);
var
  i,j,k     :Integer;
begin
   for i:=0 to ANCHO-1 do begin
    for j:=0 to ALTO-1 do begin
      for k:=0 to 2 do begin
        M[i,j,k]:=255-M[i,j,k];
       // MAT[i,j,k]:=not(MAT[i,j,k]);
      end;
      BM.Canvas.Pixels[i,j]:=RGB(M[i,j,0],M[i,j,1],M[i,j,2]);

    end; //i
  end;  //j

 //visualizar resultado
 form1.Image1.Picture.Assign(BM);
end;

///
procedure tform4.conv(var M:MATRGB);
var
i,j,k,a,b,cnv : Integer;
AUX           : MATRGB;
begin
  setlength(AUX, ANCHO, ALTO,3);

  //hacer convoluvion de imagn con MASC
  for i:=1 to ANCHO-2 do begin
    for j:=1 to ALTO-2 do begin

        for k:=0 to 2 do begin
            cnv:=0;

            for a:=-1 to 1 do begin
              for b:=-1to 1 do begin
                   cnv:= cnv + (MASC[a+1,b+1] * M[i+a,j+b,k]);
              end;
            end;//a
        AUX[i,j,k]:=abs(cnv) div 4; //almacenar en aux
        end;//k
    end;//j
  end;//i

  //copiar a MAT, BM
  for i:=0 to ANCHO-1 do begin
      for j:=0 to ALTO-1  do begin
          for k:=0 to 2 do begin
              M[i,j,k] := AUX[i,j,k];
          end;
      UNIT1.BM.Canvas.Pixels[i,j]:=RGB(M[i,j,0],M[i,j,1],M[i,j,2]);
      end;

  end;
  form1.Image1.Picture.Assign(BM);
end;

procedure TForm4.RadioButton1Change(Sender: TObject);
begin
     Panel2.Visible:=true;
     Panel3.Visible:=false;
     Panel4.Visible:=false;
end;

procedure TForm4.RadioButton2Change(Sender: TObject);
begin
     Panel3.Visible:=true;
     Panel2.Visible:=false;
     Panel4.Visible:=false;
end;

procedure TForm4.RadioButton3Change(Sender: TObject);
begin
  Panel4.Visible:=true;
  Panel2.Visible:=false;
  Panel3.Visible:=false;
end;

end.

