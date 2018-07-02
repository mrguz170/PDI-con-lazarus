unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls, Grids, ComCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    StringGrid1: TStringGrid;
    Timer1: TTimer;
    TrackBar1: TTrackBar;
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure TrackBar1Change(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;
  dim  :  byte;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  If label1.Visible=False then
  begin
    label1.Visible:=True;


  end

  else
  begin
    label1.Visible:=False;
  end;



end;

procedure TForm1.TrackBar1Change(Sender: TObject);
var
  i,j : Byte;
begin
  dim:=TrackBar1.Position;
  label2.Caption:=IntToStr(dim);
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

procedure TForm1.FormCreate(Sender: TObject);
var
i,j: Byte;
begin
 dim:=3;
 StringGrid1.DefaultColWidth:=30;
 StringGrid1.DefaultRowHeight:=30;
 TrackBar1.Position:=TrackBar1.Min;

 label2.Caption:=Inttostr(dim);
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

end.

