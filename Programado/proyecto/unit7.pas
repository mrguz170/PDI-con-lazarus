unit Unit7;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs,LCLintf;

type
  kernel=Array[0..2,0..2] of Byte;
  MATRGB=Array of Array of Array of Byte;

  TForm7 = class(TForm)
  private

  public
    procedure erosionBin(var M:MATRGB);
    procedure dilatacionbin(var M:MATRGB);


  end;

  CONST
  //estructura para operaciones morfologicas
  B1: kernel=((255, 255, 255),
              (255, 255, 255),
              (255, 255, 255));

var
  Form7: TForm7;

implementation
uses unit1;

{$R *.lfm}
//erosion
procedure tform7.erosionBin(var M:MATRGB);
var
  i,j,k,a,b,val,bval : Integer;
  fnd           :Boolean;
  pivote        :Array of Integer;
begin
  //form1.ant();
  //pivote:=B1[1,1];
  for i:=1 to ANCHO-2 do begin
    for j:=1 to ALTO-2 do begin

    end;
  end;



  for i:=1 to ANCHO-2 do begin
    for j:=1 to ALTO-2 do begin



      if M[i,j,0]= B1[1,1] then
        begin
        //form1.Edit1.Text:=IntToStr(B1[1,1]);
        fnd:=True;

          for a:=-1 to 1 do begin
             for b:=-1to 1 do begin

                   val:=M[i+a,j+b,0];
                   bval:=B1[a+1,b+1];

                   if val <> bval then fnd:=False;

             end; //b
          end;//a

      //si coincide toda la estructura entonces no se preserva
        if fnd=True then
          begin
          //Si Coincide estructura

          for a:=-1 to 1 do begin
               for b:=-1to 1 do begin

                  M[i+a,j+b,0]:=0;
                  M[i+a,j+b,1]:=0;
                  M[i+a,j+b,2]:=0;

               end; //b
          end;//a

          M[i,j,0] := 255;
          M[i,j,1] := 255;
          M[i,j,2] := 255;


          end;//end if


        end;//end if
    end;
  end;//end i

  (*
  for i:=1 to ANCHO-2 do begin
    for j:=1 to ALTO-2 do begin

        fnd:=True;

        for a:=-1 to 1 do begin
              for b:=-1to 1 do begin

                 val:=M[i+a,j+b,0];
                 bval:=B1[a+1,b+1];

                 if val <> bval then fnd:=False;

              end; //b
        end;//a

        //si coincide toda la estructura entonces no se preserva
        if fnd=True then
          begin
          //Si Coincide estructura

              for a:=-1 to 1 do begin
               for b:=-1to 1 do begin

                  M[i+a,j+b,0]:=0;
                  M[i+a,j+b,1]:=0;
                  M[i+a,j+b,2]:=0;

               end; //b
              end;//a

          M[i,j,0] := 255;
          M[i,j,1] := 255;
          M[i,j,2] := 255;

          end;//end if

    end;//j
  end;//i


  *)
  //copiar a MAT, BM
  for i:=0 to ANCHO-1 do begin
      for j:=0 to ALTO-1  do begin
      BM.Canvas.Pixels[i,j]:=RGB(M[i,j,0],M[i,j,1],M[i,j,2]);
      end;
  end;
  form1.verImgHis();
end;

//dilatacion binaria --no funciona
procedure tform7.dilatacionbin(var M:MATRGB);
var
  i,j,k,a,b,val,bval : Integer;
  fnd           :Boolean;
begin
  //form1.ant();

  for i:=1 to ANCHO-2 do begin
    for j:=1 to ALTO-2 do begin

        fnd:=false;

        for a:=-1 to 1 do begin
              for b:=-1to 1 do begin

                 val:=M[i+a,j+b,0];
                 bval:=B1[a+1,b+1];

                 if val=bval then fnd:=true;

              end; //b
        end;//a


        if fnd=True then
          begin
          //Si Coincide estructura

              for a:=-1 to 1 do begin
               for b:=-1to 1 do begin

                  M[i+a,j+b,0]:=255;
                  M[i+a,j+b,1]:=255;
                  M[i+a,j+b,2]:=255;

               end; //b
              end;//a

          M[i,j,0] := 255;
          M[i,j,1] := 255;
          M[i,j,2] := 255;

          end;//end if

    end;//j
  end;//i

  //copiar a MAT, BM
  for i:=0 to ANCHO-1 do begin
      for j:=0 to ALTO-1  do begin
      BM.Canvas.Pixels[i,j]:=RGB(M[i,j,0],M[i,j,1],M[i,j,2]);
      end;
  end;
  form1.verImgHis();
end;


end.

