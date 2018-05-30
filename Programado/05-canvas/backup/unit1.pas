unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Image1: TImage;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.Button1Click(Sender: TObject);
begin
  image1.canvas.lineto(80,80);
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  image1.Canvas.Brush.color:= clwhite;
  image1.Canvas.Ellipse(15,12,70,80);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  image1.Canvas.Brush.color:= clwhite;
  image1.Canvas.Pen.color:=CLblack;
  image1.Canvas.Rectangle(0,0, image1.Width, image1.Height);
end;

end.

