unit uMain;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, Buttons, StdCtrls,
  ExtCtrls, AnchorDockPanel;

type

  { TForm1 }

  TForm1 = class(TForm)
    AnchorDockPanel1: TAnchorDockPanel;
    btn0: TButton;
    btn1: TButton;
    btn2: TButton;
    btn3: TButton;
    btn4: TButton;
    btn5: TButton;
    btn6: TButton;
    btn7: TButton;
    btn8: TButton;
    btn9: TButton;
    btnAns: TButton;
    btnDiv: TButton;
    btnDot: TButton;
    btnMinus: TButton;
    btnMul: TButton;
    btnPlus: TButton;
    Memo1: TMemo;
    StaticText1: TStaticText;
    procedure FormCreate(Sender: TObject);
    procedure OnClickButton(Sender: TObject);
  private
    FAnswerShown: boolean;
    procedure DoCalculation(const AExpr: string);
  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

uses fpexprpars;

{ TForm1 }

procedure TForm1.OnClickButton(Sender: TObject);
begin
  if FAnswerShown then
    Memo1.Text := '';

  FAnswerShown := false;

  if (Sender as TButton).Tag = 12 then
    DoCalculation(Memo1.Text)
  else
    Memo1.Text := Memo1.Text + (Sender as TButton).Caption;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  FAnswerShown := false;
end;

procedure TForm1.DoCalculation(const AExpr: string);
var
  FParser: TFPExpressionParser;
  parserResult: TFPExpressionResult;
  Text_: string;
begin
  Text_ := 'Nan';
  FParser := TFpExpressionParser.Create(self);
  FParser.Builtins := [bcMath];
  FParser.Expression := AExpr;
  parserResult := FParser.Evaluate;
  case parserResult.ResultType of
    rtInteger: Text_ := parserResult.ResInteger.ToString;
    rtFloat: Text_ := ArgToFloat(parserResult).ToString;
  end;
  Memo1.Lines.Add(Text_);
  FParser.Free;

  FAnswerShown := true;
end;

end.

