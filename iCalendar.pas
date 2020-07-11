// Modified by houidef 24-01-2020 18:52:28

unit iCalendar;

interface

uses Classes, XMLDoc, XMLIntf, TypInfo, Variants, SysUtils, XmlDom,contnrs,dialogs;

type
  TCalendarEvents = class;
  TCalendarEvent = class(Tobject)
  private
    FStartEvent: TDateTime;
    FEndEvent: TDateTime;
    FSummary : string;
    FDescription : string;
    FEvent : string;
    //procedure SetAge(const Value: Integer);
    //procedure SetNom(const Value: String);
  public
    Parent: TCalendarEvents;
    function Next : TCalendarEvent;
    function Index: Integer;
    property StartEvent: TDateTime read FStartEvent write FStartEvent;
    property EndEvent: TDateTime read FEndEvent write FEndEvent;
    property Summary: string read FSummary write FSummary;
    property Description: string read FDescription write FDescription;
    property Event: string read FEvent write FEvent;
  end;
  TCalendarEvents = class(TObjectList)
  private
    function GetEvent(Index: Integer): TCalendarEvent;
    procedure SetEvent(Index: Integer; const Value: TCalendarEvent);
  public
    procedure Save;
    procedure Load;
    function GetEvents(FromDate : TDateTime) : TCalendarEvents;
    function NouvelleEvent: TCalendarEvent;
    procedure AjouterEvent(PStartTime: TdateTime; PEndTime: TdateTime;
                          PSummary: string; PDescription: string;PEvent:String);
    property Event[Index: Integer]: TCalendarEvent read GetEvent write SetEvent;
  end;
  TXMLSerializer = class(TObject)
  private
    XMLData: IXMLDocument;
    FFilename: TFilename;

    procedure SetXML(Value:TStrings);
    function GetXML: TStrings;

    procedure SetFilename(Value:TFilename);
    procedure SetEncoding(Value:DomString);
    procedure SetStandalone(Value:DomString);
    procedure SetVersion(Value:DomString);

    function GetFilename: TFilename;
    function GetEncoding:DomString;
    function GetStandalone:DomString;
    function GetVersion:DomString;

    procedure InitVarTypes;
    function StringToVarType(VarString:String):TVarType;
    function VarTypeToString(VarType:TVarType):String;
  public
    constructor Create; //override;

    procedure SaveObject(CalendarEvents:TCalendarEvents; Name:String);
    procedure LoadObject(CalendarEvents:TCalendarEvents; Name:String);
    procedure ReadEvent(CalendarEvents:TCalendarEvents; Node : IXMLNode);

    function LoadFile: Boolean;
    function SaveFile: Boolean;
  published
    property XMLText: TStrings read GetXML write SetXML;
    property Filename: TFilename read GetFilename write SetFilename;
    property Encoding: DomString read GetEncoding write SetEncoding;
    property Standalone: DomString read GetStandalone write SetStandalone;
    property Version: DomString read GetVersion write SetVersion;
  end;

var
  VarTypes: array[$0000..$4000] of String;

procedure Register;

implementation
{ TCalendarEvent }

function TCalendarEvent.Index: Integer;
begin
  Result := Parent.IndexOf(Self);
end;

function TCalendarEvent.Next: TCalendarEvent;
begin
  if Index < Pred(Parent.Count) then
    Result := Parent.event[Succ(Index)]
  else
    Result := nil;
end;

{ TCalendarEvents }

procedure TCalendarEvents.AjouterEvent(PStartTime: TdateTime; PEndTime: TdateTime;
                          PSummary: string; PDescription: string;PEvent:String);
begin
 with NouvelleEvent do
  begin
    FStartEvent := PStartTime;
    FEndEvent := PEndTime;
    FSummary := PSummary;
    FDescription := PDescription;
    FEvent := PEvent;
  end;
end;

function TCalendarEvents.GetEvent(Index: Integer): TCalendarEvent;
begin
  if (Count > 0) and (Index < Count) then
    Result := Items[Index] as TCalendarEvent
  else
    Result := nil;
end;

function TCalendarEvents.GetEvents(FromDate: TDateTime): TCalendarEvents;
var
  i : Integer;
begin
    Result := TCalendarEvents.Create;
    for i:= 0 to Count-1 do
       if(Event[i].StartEvent <= FromDate) and (Event[i].EndEvent >= FromDate) then
       Result.add(Event[i]);
  
end;

procedure TCalendarEvents.Load;
var
  XMLSerializer1:TXMLSerializer;
begin
XMLSerializer1:=TXMLSerializer.Create;
  XMLSerializer1.Filename := 'CalendarFile.xml';
  if(XMLSerializer1.LoadFile) then
        XMLSerializer1.LoadObject(self,'Cal1');
end;

function TCalendarEvents.NouvelleEvent: TCalendarEvent;
begin
  Result := Event[Add(TCalendarEvent.Create)];
  Result.Parent := Self;
end;

procedure TCalendarEvents.Save;
var
  XMLSerializer1:TXMLSerializer;
begin
  XMLSerializer1:=TXMLSerializer.Create;
  XMLSerializer1.Filename := 'CalendarFile.xml';
  XMLSerializer1.SaveObject(self,'Cal1');
  if (not XMLSerializer1.SaveFile) then
     ShowMessage('there is error!');
end;

procedure TCalendarEvents.SetEvent(Index: Integer;
  const Value: TCalendarEvent);
begin
  if (Count > 0) and (Index < Count) then
    Items[Index] := Value
  else
    Raise Exception.Create('Aucun élément à cet index');
end;
procedure Register;
begin
 // RegisterComponents('Custom', [TXMLSerializer]);
end;

constructor TXMLSerializer.Create;
var
  DocumentElement: IXMLNode;
begin
  inherited;

  XMLData := NewXMLDocument;
  XMLData.Options := [doNodeAutoIndent];

  DocumentElement := XMLData.CreateElement('classes', '');
  XMLData.DocumentElement := DocumentElement;
  XMLData.Encoding := 'ISO-8859-6';
  XMLData.Version := '1.0';
  XMLData.Standalone := 'yes';

  XMLData.Active := True;
end;

procedure TXMLSerializer.InitVarTypes;
begin
  VarTypes[varEmpty] := 'Empty';
  VarTypes[varNull] := 'Null';
  VarTypes[varSmallint] := 'Smallint';
  VarTypes[varInteger] := 'Integer';
  VarTypes[varSingle] := 'Single';
  VarTypes[varDouble] := 'Double';
  VarTypes[varCurrency] := 'Currency';
  VarTypes[varDate] := 'Date';
  VarTypes[varOleStr] := 'OleStr';
  VarTypes[varDispatch] := 'Dispatch';
  VarTypes[varError] := 'Error';
  VarTypes[varBoolean] := 'Boolean';
  VarTypes[varVariant] := 'Variant';
  VarTypes[varUnknown] := 'Unknown';
  VarTypes[varShortInt] := 'ShortInt';
  VarTypes[varByte] := 'Byte';
  VarTypes[varWord] := 'Word';
  VarTypes[varLongWord] := 'LongWord';
  VarTypes[varInt64] := 'Int64';
  VarTypes[varStrArg] := 'StrArg';
  VarTypes[varString] := 'String';
  VarTypes[varAny] := 'Any';
  VarTypes[varTypeMask] := 'TypeMask';
  VarTypes[varArray] := 'Array';
  VarTypes[varByRef] := 'ByRef';
end;

function TXMLSerializer.VarTypeToString(VarType:TVarType):String;
begin
  InitVarTypes;
  Result := VarTypes[VarType];
end;

function TXMLSerializer.StringToVarType(VarString:String):TVarType;
var
  Count: Integer;
begin
  InitVarTypes;

  Result := 0;

  for Count := $0000 to $4000 do
  begin
    if (VarTypes[Count] = VarString) then
    begin
      Result := Count;
      Exit;
    end;
  end;
end;

procedure TXMLSerializer.LoadObject(CalendarEvents:TCalendarEvents; Name:String);
var
  Count: Integer;
  Node: IXMLNode;
  VariantData: Variant;
begin
  XMLData.Active := True;

  repeat
    Node := XMLData.DocumentElement.ChildNodes.FindNode(Name);

    if Node <> nil then
    begin
      if (Node.Attributes['classname'] = CalendarEvents.ClassName) then
      begin
        for Count := 0 to Node.ChildNodes.Count-1 do
        begin
          ReadEvent(CalendarEvents,Node.ChildNodes.Nodes[Count]);
          {if not(VarIsNull(Node.ChildNodes.Nodes[Count].NodeValue)) then
          begin
            VariantData := VarAsType(Node.ChildNodes.Nodes[Count].NodeValue,StringToVarType(Node.ChildNodes.Nodes[Count].Attributes['type']));
            if IsPublishedProp(CalendarEvents,Node.ChildNodes.Nodes[Count].Attributes['name']) then
              SetPropValue(CalendarEvents,Node.ChildNodes.Nodes[Count].Attributes['name'],VariantData);
          end; }
        end;
      end;
    end;
  until not(Node = nil);
end;

function TXMLSerializer.LoadFile: Boolean;
begin
    XMLData :=  TXMLDocument.Create('CalendarFile.xml');
end;

function TXMLSerializer.SaveFile: Boolean;
begin
    XMLData.SaveToFile('CalendarFile.xml');

end;

procedure TXMLSerializer.SaveObject(CalendarEvents : TCalendarEvents;Name:String);
var
  I, Count: Integer;
  PropInfo: PPropInfo;
  PropList: PPropList;
  PropValue: Variant;
  PropType: PPTypeInfo;
  PropReturnValue: Word;
  ChildNode: IXMLNode;
  Node,Event: IXMLNode;
begin
  XMLData.Active := True;

  repeat
    ChildNode := XMLData.DocumentElement.ChildNodes.FindNode(Name);
    if ChildNode <> nil then
    begin
      if (ChildNode.Attributes['classname'] = CalendarEvents.ClassName) then
        XMLData.DocumentElement.ChildNodes.Remove(ChildNode);
    end;
  until ChildNode = nil;
  ChildNode := XMLData.DocumentElement.AddChild(Name);
  ChildNode.Attributes['classname'] := CalendarEvents.ClassName;
  for I := 0 to CalendarEvents.Count - 1 do
  begin
      Event := ChildNode.AddChild('Event');
      Node := Event.AddChild('data');
      Node.Attributes['name'] := 'fromdate';
      Node.Attributes['type'] := 'TDateTime';
      Node.NodeValue := VarToStr(CalendarEvents.Event[I].StartEvent);
      //===
      Node := Event.AddChild('data');
      Node.Attributes['name'] := 'todate';
      Node.Attributes['type'] := 'TDateTime';
      Node.NodeValue := VarToStr(CalendarEvents.Event[I].EndEvent);
      //===
      Node := Event.AddChild('data');
      Node.Attributes['name'] := 'Summary';
      Node.Attributes['type'] := 'string';
      Node.NodeValue := CalendarEvents.Event[I].Summary;
      //===
      Node := Event.AddChild('data');
      Node.Attributes['name'] := 'Description';
      Node.Attributes['type'] := 'string';
      Node.NodeValue := CalendarEvents.Event[I].Description;
  end;
end;

procedure TXMLSerializer.SetXML(Value:TStrings);
begin
  XMLData.XML := Value;
  XMLData.Active := True;
end;

function TXMLSerializer.GetXML: TStrings;
begin
  Result := XMLData.XML;
end;

procedure TXMLSerializer.SetFilename(Value:TFilename);
begin
  FFilename := Value;
end;

function TXMLSerializer.GetFilename: TFilename;
begin
  Result := FFilename;
end;

procedure TXMLSerializer.SetEncoding(Value:DomString);
begin
  XMLData.Active := True;
  XMLData.Encoding := Value;
end;

procedure TXMLSerializer.SetStandalone(Value:DomString);
begin
  XMLData.Active := True;
  XMLData.Standalone := Value;
end;

procedure TXMLSerializer.SetVersion(Value:DomString);
begin
  XMLData.Active := True;
  XMLData.Version := Value;
end;

function TXMLSerializer.GetEncoding:DomString;
begin
  XMLData.Active := True;
  Result := XMLData.Encoding;
end;

function TXMLSerializer.GetStandalone:DomString;
begin
  XMLData.Active := True;
  Result := XMLData.Standalone;
end;

function TXMLSerializer.GetVersion:DomString;
begin
  XMLData.Active := True;
  Result := XMLData.Version;
end;

procedure TXMLSerializer.ReadEvent(CalendarEvents: TCalendarEvents;
  Node: IXMLNode);
begin

  CalendarEvents.AjouterEvent(
       StrToDate(Node.ChildNodes[0].Text),
       StrToDate(Node.ChildNodes[1].Text),
       Node.ChildNodes[2].Text,
       Node.ChildNodes[3].Text,
       Node.ChildNodes[3].Text
  );
end;

end.
