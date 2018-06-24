unit Unit6;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, Grids,
  ComCtrls, StdCtrls, Buttons,LCLintf, ColorBox;

type

  { TForm6 }

  //
  MATRGB=Array of Array of Array of Byte;

  TForm6 = class(TForm)
  BitBtn1: TBitBtn;
  BitBtn2: TBitBtn;
  ColorDialog1: TColorDialog;
  Label1: TLabel;
  StringGrid1: TStringGrid;
  TrackBar1: TTrackBar;
  procedure FormCreate(Sender: TObject);
  procedure TrackBar1Change(Sender: TObject);

  private

  public
  dim  : Integer;
  procedure libre(var M:MATRGB);

  end;

var
  Form6: TForm6;
  dim  :  byte;

implementation
uses unit1;

//
procedure TForm6.TrackBar1Change(Sender: TObject);
var
  i,j : Byte;
begin
  dim:=TrackBar1.Position;
  label1.Caption:=IntToStr(dim);
  StringGrid1.ColCount:=dim;
  StringGrid1.RowCount:=dim;

  StringGrid1.Width:=(StringGrid1.ColCount*StringGrid1.DefaultColWidth)+5;
  StringGrid1.Height:=(StringGrid1.RowCount*StringGrid1.DefaultRowHeight)+5;

  for i:=0 to StringGrid1.ColCount-1 do begin
   for j:=0 to StringGrid1.RowCount-1 do begin
      StringGrid1.Cells[i,j]:='0';
   end;
  end;


end;

procedure TForm6.FormCreate(Sender: TObject);
var
i,j: Byte;
begin
 dim:=3;
 //definimos altoy ancho
 StringGrid1.DefaultColWidth:=30;
 StringGrid1.DefaultRowHeight:=30;
 TrackBar1.Position:=TrackBar1.Min;

 label1.Caption:=Inttostr(dim);
 StringGrid1.ColCount:=dim;
 StringGrid1.RowCount:=dim;
 StringGrid1.Width:=(StringGrid1.ColCount*StringGrid1.DefaultColWidth)+5;
 StringGrid1.Height:=(StringGrid1.RowCount*StringGrid1.DefaultRowHeight)+5;

 //llenams con 0's las celdas
 for i:=0 to StringGrid1.ColCount-1 do begin
   for j:=0 to StringGrid1.RowCount-1 do begin
      StringGrid1.Cells[i,j]:='0';

   end;
 end;

end;

//////////////---------Metodos gus---------- ////////////////////
/////////////////////////////////////////////////////////////////

//convolucion libre
procedure tform6.libre(var M:MATRGB);
var
i,j,k,a,b,cnt : Integer;
cnv           : Integer  ;
AUX           : MATRGB;
begin
  form1.ant();
  setlength(AUX, ANCHO, ALTO,3);
  cnt:=0;

  //contar los numero entre los que se dividira el valor abs - cnv
  for i:=0 to dim-1 do begin
    for j:=0 to dim-1 do begin
        if  StrToInt(StringGrid1.Cells[i,j])>=1 then  cnt:=cnt + strToInt(StringGrid1.Cells[i,j]);
    end;
  end;

  //hacer convoluvion de imagn
  for i:=1 to ANCHO-(dim-1) do begin
    for j:=1 to ALTO-(dim-1) do begin

        for k:=0 to 2 do begin
            cnv:=0;

            for a:=-1 to dim-2 do begin
              for b:=-1 to dim-2 do begin

                  cnv := cnv + (StrtoInt(StringGrid1.Cells[a+1,b+1]) * M[i+a,j+b,k]);
              end;
            end;//a

        if cnt>0 then begin
             AUX[i,j,k]:=abs(cnv) div cnt; //almacenar en aux
        end
        else begin
             AUX[i,j,k]:=abs(cnv) div 1; //almacenar en aux
        end;


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

  form1.verImgHis();
end;

//---------------

{$R *.lfm}

end.

