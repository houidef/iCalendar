unit uFormEventEdit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, Buttons, StdCtrls, Spin, ComCtrls,ICalendar;

type
  TFormEventEdit = class(TForm)
    pgcEvent: TPageControl;
    tsEvent: TTabSheet;
    tsRecurrence: TTabSheet;
    ComboBox1: TComboBox;
    Summary: TEdit;
    fromdate: TDateTimePicker;
    todate: TDateTimePicker;
    SpinEdit1: TSpinEdit;
    SpinEdit2: TSpinEdit;
    CheckBox1: TCheckBox;
    Edit2: TEdit;
    Description: TMemo;
    ComboBox2: TComboBox;
    ComboBox3: TComboBox;
    ComboBox4: TComboBox;
    BitBtn1: TBitBtn;
    SpeedButton1: TSpeedButton;
    pnl1: TPanel;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
  private
    EventList : TCalendarEvents;
    { Private declarations }
  public
    procedure initiliser(EventList : TCalendarEvents;daySelected: TDateTime);
    { Public declarations }
  end;

var
  FormEventEdit: TFormEventEdit;

implementation

{$R *.dfm}

{ TFormEventEdit }

procedure TFormEventEdit.Initiliser(EventList : TCalendarEvents;daySelected: TDateTime);
var
  List : TCalendarEvents;
begin
  Self.EventList := Eventlist;
  List := EventList.GetEvents(daySelected);
  if(List.Count > 0) then
  begin
    FromDate.DateTime :=  List.event[0].StartEvent;
    ToDate.DateTime :=  List.event[0].EndEvent;
    Summary.text :=  List.event[0].Summary;
    Description.text :=  List.event[0].Description;
  end else
  begin
     FromDate.DateTime :=  daySelected;
     ToDate.DateTime :=  daySelected;
     Summary.text := '';
     Description.text := '';
  end;

end;

end.
