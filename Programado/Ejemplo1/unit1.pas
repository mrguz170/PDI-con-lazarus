unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ExtCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private

  public
     procedure suma(S1: Integer; S2: Integer; var Res: Integer);
  end;

var
  Form1: TForm1;
  A, B: Integer;
  R: Integer;

  //array  1-D
  AB: Array[0..9] of Integer;
  //Array 2-D
  Mat: Array[0..5] of Array[0..9] of integer;   //matriz 6*10

implementation

{$R *.lfm}

{ TForm1 }
procedure tform1.suma(S1: Integer; S2: Integer; var Res: Integer);
begin
   Res := S1 + S2;
end;

procedure TForm1.Button1Click(Sender: TObject);
var i: byte;
begin
//llenar array
   for i:=0 to 9 do
     begin

     AB[i]:= random(100);

     end;

end;

procedure TForm1.Button2Click(Sender: TObject);
var i:Byte;
begin
   for i:=0 to 9 do
     begin
     Edit1.Text:=Edit1.Text  + ',' + IntToStr(AB[i]);
     end;
end;

procedure TForm1.Button3Click(Sender: TObject);
var
  i,j: byte;
begin
for i:=0 to 5 do
  begin
       for j:=0 to 9 do
         begin
              Mat[i,j]:=Random(50);
         end;
  end;
end;

end.

