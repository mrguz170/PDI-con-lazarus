unit Unit4;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ExtCtrls, Buttons,LCLintf, Grids, ColorBox;

type

  { TForm4 }
  //tipo propio definido
  MATCONV=Array[0..2,0..2] of Integer;
  MATRGB=Array of Array of Array of Byte;

  TForm4 = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    ColorBox1: TColorBox;
    ColorBox2: TColorBox;
    Label1: TLabel;
    Label2: TLabel;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    StringGrid1: TStringGrid;
    StringGrid2: TStringGrid;
    StringGrid3: TStringGrid;
    StringGrid4: TStringGrid;
    procedure ColorBox1Change(Sender: TObject);
    procedure RadioButton1Change(Sender: TObject);
    procedure RadioButton2Change(Sender: TObject);
    procedure RadioButton3Change(Sender: TObject);
  private

  public
  procedure sobel(var M:MATRGB);
  procedure prewitt(var M:MATRGB);
  procedure test(var M:MATRGB);
  procedure ToBin(var M:MATRGB);


  end;

CONST
  //SOBEL MASK
  MASC1: MATCONV=((-1,-2,-1),
                (0, 0, 0),
                (1, 2, 1));

  MASC2: MATCONV=((-1,0,1),
                (-2, 0, 2),
                (-1, 0, 1));

   //PREWITT MASK
  MASC3: MATCONV=((-1,-1,-1),
                (0, 0, 0),
                (1, 1, 1));

  MASC4: MATCONV=((-1, 0, 1),
                  (-1, 0, 1),
                  (-1, 0, 1));




var
  Form4: TForm4;

implementation
uses unit1;
{$R *.lfm}

{ TForm4 }

//metodos propios
procedure Tform4.ToBin(var M:MATRGB);
var
  i,j,T: Integer;
begin
  T:=0;
  form1.grises_prom(M);
  for i:=0 to ANCHO-1 do begin
    for j:=0 to ALTO-1 do begin
        T := T + M[i,j,0];
    end;
  end;

T:= T div (ANCHO*ALTO);

//MAYOR > T -> 255
//menor_igual <= 0 -> 0
for i:=0 to ANCHO-1 do begin
    for j:=0 to ALTO-1 do begin
        if M[i,j,0] <= T then
           begin
           M[i,j,0]:=getRvalue(ColorBox1.Selected);
           M[i,j,1]:=getGvalue(ColorBox1.Selected);
           M[i,j,2]:=getBvalue(ColorBox1.Selected);
           BM.Canvas.Pixels[i,j] := ColorBox1.Selected;
           end
        else
           begin
           M[i,j,0]:=getRvalue(ColorBox2.Selected);
           M[i,j,1]:=getGvalue(ColorBox2.Selected);
           M[i,j,2]:=getBvalue(ColorBox2.Selected);
           BM.Canvas.Pixels[i,j] := ColorBox2.Selected;
           end;
    end;
end;

end;

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
//conv PREWITT
procedure tform4.prewitt(var M:MATRGB);
var
  i,j,k,a,b,cnv : Integer;
  AUX           : MATRGB;
begin
  form1.ant();
  setlength(AUX, ANCHO, ALTO,3);

  //hacer convoluvion de imagn con MASC
  for i:=1 to ANCHO-2 do begin
    for j:=1 to ALTO-2 do begin

        for k:=0 to 2 do begin
            cnv:=0;

            for a:=-1 to 1 do begin
              for b:=-1to 1 do begin
                  cnv:= cnv+ (MASC3[a+1,b+1]*M[i+a,j+b,k] + MASC4[a+1,b+1]*M[i+a,j+b,k] );
              end;
            end;//a
        AUX[i,j,k]:=abs(cnv) div 6; //almacenar en aux
        end;//k
    end;//j
  end;//i

  //copiar a MAT, BM
  for i:=0 to ANCHO-1 do begin
      for j:=0 to ALTO-1  do begin
          for k:=0 to 2 do begin
              M[i,j,k] := AUX[i,j,k];
          end;
          BM.Canvas.Pixels[i,j]:=RGB(M[i,j,0],M[i,j,1],M[i,j,2]);
      end;
  end;

  ToBin(M);

end;

//conv SOBEL
procedure tform4.SOBEL(var M:MATRGB);
var
i,j,k,a,b,cnv : Integer;
AUX           : MATRGB;
begin
  form1.ant();
  setlength(AUX, ANCHO, ALTO,3);

  //hacer convoluvion de imagn con MASC
  for i:=1 to ANCHO-2 do begin
    for j:=1 to ALTO-2 do begin

        for k:=0 to 2 do begin
            cnv:=0;

            for a:=-1 to 1 do begin
              for b:=-1to 1 do begin
                  cnv:= cnv+ (MASC1[a+1,b+1]*M[i+a,j+b,k] + MASC2[a+1,b+1]*M[i+a,j+b,k] );
              end;
            end;//a
        AUX[i,j,k]:=abs(cnv) div 8; //almacenar en aux
        end;//k
    end;//j
  end;//i

   //copiar a MAT, BM
  for i:=0 to ANCHO-1 do begin
      for j:=0 to ALTO-1  do begin
          for k:=0 to 2 do begin
              M[i,j,k] := AUX[i,j,k];
          end;
          BM.Canvas.Pixels[i,j]:=RGB(M[i,j,0],M[i,j,1],M[i,j,2]);
      end;
  end;

  ToBin(M);
end;

procedure TForm4.RadioButton1Change(Sender: TObject);
begin
     Panel2.Color:=RGB(0,255,0);
     Panel3.Color:=CLwhite;
     //Panel4.Color:=CLwhite;
end;

procedure TForm4.ColorBox1Change(Sender: TObject);
begin

end;

procedure TForm4.RadioButton2Change(Sender: TObject);
begin
     Panel2.Color:=CLwhite;
     Panel3.Color:=RGB(0,255,0);
     //Panel4.Color:=CLwhite;
end;

procedure TForm4.RadioButton3Change(Sender: TObject);
begin
     Panel2.Color:=CLwhite;
     Panel3.Color:=CLwhite;
     //Panel4.Color:=RGB(0,255,0);
end;

end.

