unit Unit7;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs,LCLintf;

type
  kernel=Array[0..2,0..2] of Integer;
  MATRGB=Array of Array of Array of Byte;

  TForm7 = class(TForm)
  private

  public
    procedure erosionBin(var M:MATRGB);


  end;

  CONST
  //estructura para operaciones morfologicas
  B1: kernel=((1, 1, 1),
             (1, 1, 1),
             (1, 1, 1));

var
  Form7: TForm7;

implementation
uses unit1;

{$R *.lfm}
//erosion
procedure tform7.erosionBin(var M:MATRGB);
var
  i,j,k,a,b,val,bval,sum : Integer;
  AUX           : MATRGB;
  fnd           :Boolean;
begin
  //form1.ant();
  setlength(AUX, ANCHO, ALTO,3);
  //form1.Treshold();

  //hacer convoluvion de imagn con MASC
  for i:=1 to ANCHO-2 do begin
    for j:=1 to ALTO-2 do begin

        fnd:=True;

        for a:=-1 to 1 do begin
              for b:=-1to 1 do begin

                  sum:= sum+ (B1[a+1,b+1]*(M[i+a,j+b,0]/ 255));
              (*
                 val:=M[i+a,j+b,0];
                 bval:=B1[a+1,b+1];

                 if val <> bval then  fnd:=False;
                 *)
              end; //b
        end;//a

        //si no coincide toda la estructura entonces no se preserva
        if sum=

        (*
        if fnd=False then
          begin
          //No Coincide estructura
            AUX[i,j,0] := RGB(0,0,0) ;
            AUX[i,j,1] := RGB(0,0,0) ;
            AUX[i,j,2] := RGB(0,0,0) ;
          end;
          *)
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
  form1.verImgHis();
end;

end.

