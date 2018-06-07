unit Unit3;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ComCtrls,
  StdCtrls, Buttons,LCLIntf;

type

  { TForm3 }

  TForm3 = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Label1: TLabel;
    Label2: TLabel;
    TrackBar1: TTrackBar;
    procedure TrackBar1Change(Sender: TObject);
  private

  public
  param :Integer;
  end;

var
  Form3: TForm3;

implementation
uses unit1;
{$R *.lfm}

{ TForm3 }

procedure TForm3.TrackBar1Change(Sender: TObject);

begin
  param := TrackBar1.Position;
  Label1.Caption:=inttostr(param);
end;

end.

