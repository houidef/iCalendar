unit uskin;

interface

  uses
     Classes,Windows, Graphics, XMLIntf, XMLDoc,dialogs;
  type
    TSkin = class
    private
        XMLSkin: IXMLNode;
        Doc: IXMLDocument;
        Size : integer;
        Offset : TPoint;
        Color : TColor;
    public
      Path: string;
      //CalendarForm
      //Background
      CalFormBackground_Bitmap : string;
      CalFormBackground_Width : integer;
      CalFormBackground_TextMaxWidth : integer;
      CalFormBackground_Offset :TPoint;
      CalFormBackground_BottomPadding : integer;
      CalFormBackground_Margin : TRect;
      //Header
      Header_Align : Integer;
      Header_Font_size : integer;
      Header_Font_style: integer;
      Header_Font_shadow : boolean;
      Header_Offset : TPoint;
    //EventList
      EventList_Font_size: integer;
      EventList_Font_style: integer;
      EventList_Font_shadow : Boolean;
    //EventDay
      EventDay_Font_size: integer;
      EventDay_Font_style: integer;
      EventDay_Font_shadow: Boolean;
    //MenuButton
      MenuButtonOffset : TPoint;
      MenuButtonImg : string;
    //CloseButton
      CloseButtonOffset : TPoint;
      CloseButtonImg : string;
    //Year
      YearFontsize : Integer;
      YearFontcolor : TColor;
      YearfontName : string;
      YearFontstyle : Integer;
      YearFontshadow : Boolean;
      YearOffset : TPoint;
    //Month
      MonthFontsize : Integer;
      MonthFontcolor : TColor;
      MonthfontName: string;
      MonthFontstyle : Integer;
      MonthFontshadow : Boolean;
      MonthOffset : TPoint;
    //WeekNumber
      WeekNumberFontsize : Integer;
      WeekNumberFontcolor : TColor;
      WeekNumberfontName : string;
      WeekNumberfontstyle : Integer;
      WeekNumberfontshadow : Boolean;
      WeekNumberVisible : Boolean;
      WeekNumberOffset : Tpoint;
    //WeekDay
      WeekDayFontsize : integer;
      WeekDayFontcolor : TColor;
      WeekDayfontName : string;
      WeekDayFontstyle : Integer;
      WeekDayFontshadow : Boolean;
      WeekDayUseShort : Boolean;
    //Day
      DayFontsize : integer;
      DayFontcolor : TColor;
      DayfontName : string;
      DayFontstyle : integer;
      DayFontshadow : Boolean;
      Dayspace : Integer;
      VerticalSpace : Integer;
      DayEventColor : TColor;
      DayWeekendColor: TColor;
      DayOffset : TPoint;
    //PreButton
      PreButtonOffset : TPoint;
      PreButtonImg : string;
    //NextButton
      NextButtonOffset : TPoint;
      NextButtonImg : string;
    //TodayImg
      todayimg : string;
    //EventForm
    //Background
      BackgroundBitmap : string;
      BackgroundWidth : integer;
      BackgroundTextMaxWidth : integer;
      BackgroundOffset : TPoint;
      BackgroundBottomPadding : Integer;
      BackgroundMargin : TRect; //top="39" left="10" right="15" bottom="20"
    //Header
      HeaderAlign : Integer;
     // <Bitmap />
      HeaderFontsize : Integer;
      Headercolor : TColor;
      HeaderfontName : string;
      Headerstyle : Integer;
      Headershadow : Boolean;
      HeaderOffset  : TPoint;
      HeaderText : string;
    //EventList
      EventListFontsize : Integer;
      EventListcolor : TColor;
      EventListfontName : string;
      EventListstyle : Integer;
      EventListshadow : Boolean;
    //EventDay
      EventDayFontsize : Integer;
      EventDaycolor : TColor;
      EventDayfontName : string;
      EventDaystyle : Integer;
      EventDayshadow : Boolean;
    //MenuButton
      EventDayMenuButtonOffset : TPoint;
      EventDayMenuButtonImg : string;
    //CloseButton
      EventDayCloseButtonOffset : TPoint;
      EventDayCloseButtonImg : string;
    //AddButton
      AddButtonOffset : TPoint;
      AddButtonImg : string;
  //TaskForm
    //Background
      TaskFormBackgroundBitmap : string;
      TaskFormBackgroundWidth : integer;
      TaskFormBackgroundTextMaxWidth : integer;
      TaskFormBackgroundOffset : TPoint;
      TaskFormBackgroundBottomPadding : integer;
      TaskFormBackgroundMargin  : TRect; //top="30" left="10" right="15" bottom="15" />
    //Header
      TaskFormHeaderAlign : Integer;
      //TaskFormHeaderBitmap />
      TaskFormHeaderFontsize : Integer;
      TaskFormHeadercolor : TColor;
      TaskFormHeaderfontName : string;
      TaskFormHeaderstyle : integer;
      TaskFormHeadershadow : Boolean;
      TaskFormHeaderOffset  : Tpoint;
      TaskFormHeaderText : string;
    //EventList
      TaskFormEventListFontsize : Integer;
      TaskFormEventListcolor : TColor;
      TaskFormEventListfontName : string;
      TaskFormEventListstyle : integer;
      TaskFormEventListshadow : Boolean;
    //EventDay
      TaskFormEventDayFontsize : integer;
      TaskFormEventDaycolor : TColor;
      TaskFormEventDayfontName : string;
      TaskFormEventDaystyle : integer;
      TaskFormEventDayshadow : Boolean;
    //MenuButton
      TaskFormEventDayMenuButtonOffset : Tpoint;
      TaskFormEventDayMenuButtonImg : string;
    //CloseButton
      TaskFormEventDayCloseButtonOffset : Tpoint;
      TaskFormEventDayCloseButtonImg : string;
    //AddButton
      TaskFormEventDayAddButtonOffset  : Tpoint;
      TaskFormEventDayAddButtonImg : string;
    //PreButton
      TaskFormEventDayPreButtonOffset : TPoint;
      TaskFormEventDayPreButtonImg : string;
      TaskFormEventDayPreButtonImgD : string;
    //NextButton
      TaskFormEventDayNextButtonOffset : TPoint;
      TaskFormEventDayNextButtonImg : string;
      TaskFormEventDayNextButtonImgD : string;
  //WeatherForm
    //Background
      WeatherFormBackgroundBitmap : string;
      WeatherFormBackgroundWidth : Integer;
      WeatherFormBackgroundTextMaxWidth : integer;
      WeatherFormBackgroundOffset  : TPoint;
      WeatherFormBackgroundBottomPadding : integer;
      WeatherFormBackgroundMargin : Trect;
    //Header
      WeatherFormHeaderAlign : integer;
      WeatherFormHeaderFontsize : integer;
      WeatherFormHeaderstyle : integer;
      WeatherFormHeadershadow : Boolean;
      WeatherFormHeaderOffset  : TPoint;
    //EventList
      WeatherFormEventListFontsize : integer;
      WeatherFormEventListstyle : integer;
      WeatherFormEventListshadow : Boolean;
    //EventDay
      WeatherFormEventDayFontsize : integer;
      WeatherFormEventDaystyle : integer;
      WeatherFormEventDayshadow: Boolean;
    //MenuButton
      WeatherFormMenuButtonOffset : TPoint;
      WeatherFormMenuButtonImg : string;
    //CloseButton
    loseButtonOffset : TPoint;
    loseButtonImg : string;
    TodayTemperaturesize : integer;
    TodayTemperaturecolor : TColor;
    TodayTemperaturefontName : string;
    TodayTemperaturestyle : integer;
    TodayTemperatureshadow : Boolean;
    Todaysize : integer;
    Todaycolor : TColor;
    TodayfontName : string;
    Todaystyle : integer;
    Todayshadow : Boolean;
    WeekdayNamesize : integer;
    WeekdayNamecolor : TColor;
    WeekdayNamefontName : string;
    WeekdayNamestyle : integer;
    WeekdayNameshadow : Boolean;
    CityNamesize : integer;
    CityNamecolor : TColor;
    CityNamefontName : string;
    CityNamestyle : integer;
    CityNameshadow :Boolean;
    Temperaturesize : integer;
    Temperaturecolor : TColor;
    TemperaturefontName : string;
    Temperaturestyle : integer;
    Temperatureshadow : Boolean;
    WeatherFormVerticalSpace : Integer;
    //TodayWeatherSize>
      TodayWeatherSizeWidth : Integer;
      TodayWeatherSizeHeight : Integer;
//=========
      text1,Text2,Text3,Text4: string;
      constructor Create;
      procedure load;
      procedure save;
      function LoadFile: Boolean;
      function SaveFile: Boolean;
    end;
implementation

uses Variants;

{ Skin }

constructor TSkin.Create;
var
  Node,Node1: IXMLNode;
begin
  Path := 'BlackGlass\';
  loadfile;
  {text1 := XMLSkin.ChildNodes[0].XML;
  text2 := XMLSkin.ChildNodes[1].XML;
  text3 := XMLSkin.ChildNodes[2].XML;
  text4 := XMLSkin.ChildNodes[3].XML; }
  repeat
    Node := XMLSkin.ChildNodes.FindNode('WindowSetting');
    if(Node <> nil) then
    begin
      if Node.Attributes['windowName'] = 'CalendarForm' then
      begin //CalendarForm
         //showmessage(Node.Attributes['windowName']);
          Node1 := Node.ChildNodes.FindNode('Background');
          if(Node1 <> nil)then
          begin//Background
            CalFormBackground_Bitmap := Path + Node1.ChildNodes.Nodes['Bitmap'].Text;
            CalFormBackground_Width := VarAsType(Node1.ChildNodes.Nodes['Width'].NodeValue,varInteger);
            CalFormBackground_TextMaxWidth := VarAsType(Node1.ChildNodes.Nodes['TextMaxWidth'].NodeValue,varInteger);
            CalFormBackground_Offset :=Point(Node1.ChildNodes.Nodes['Offset'].Attributes['X'],Node1.ChildNodes.Nodes['Offset'].Attributes['Y']);
            CalFormBackground_BottomPadding := VarAsType(Node1.ChildNodes.Nodes['BottomPadding'].NodeValue,varInteger);
            CalFormBackground_Margin := Rect(Node1.ChildNodes.Nodes['Margin'].Attributes['left'],
                                             Node1.ChildNodes.Nodes['Margin'].Attributes['top'],
                                             Node1.ChildNodes.Nodes['Margin'].Attributes['right'],
                                             Node1.ChildNodes.Nodes['Margin'].Attributes['bottom']);
          end;
         { Node1 := Node.ChildNodes.FindNode('Header');
          if(Node1 <> nil)then //Header
          begin
            Header_Align := Integer;
            Header_Font_size : integer;
            Header_Font_style: integer;
            Header_Font_shadow : boolean;
            Header_Offset : TPoint;
          end;
          Node1 := Node.ChildNodes.FindNode('EventList');
          if(Node1 <> nil)then //EventList
          begin
            EventList_Font_size: integer;
            EventList_Font_style: integer;
            EventList_Font_shadow : Boolean;
          end;
          Node1 := Node.ChildNodes.FindNode('EventDay');
          if(Node1 <> nil)then //EventDay
          begin
            EventDay_Font_size: integer;
            EventDay_Font_style: integer;
            EventDay_Font_shadow: Boolean;
          end;
          Node1 := Node.ChildNodes.FindNode('MenuButton');
          if(Node1 <> nil)then //MenuButton
          begin
            MenuButtonOffset : TPoint;
            MenuButtonImg : string;
          end;
          Node1 := Node.ChildNodes.FindNode('CloseButton');
          if(Node1 <> nil)then //CloseButton
          begin
            CloseButtonOffset : TPoint;
            CloseButtonImg : string;
          end;
          Node1 := Node.ChildNodes.FindNode('Year');
          if(Node1 <> nil)then //Year
          begin
            YearFontsize : Integer;
            YearFontcolor : TColor;
            YearfontName : string;
            YearFontstyle : Integer;
            YearFontshadow : Boolean;
            YearOffset : TPoint;
          end;
          Node1 := Node.ChildNodes.FindNode('Month');
          if(Node1 <> nil)then //Month
          begin
            MonthFontsize : Integer;
            MonthFontcolor : TColor;
            MonthfontName: string;
            MonthFontstyle : Integer;
            MonthFontshadow : Boolean;
            MonthOffset : TPoint;
          end;
          Node1 := Node.ChildNodes.FindNode('WeekNumber');
          if(Node1 <> nil)then //WeekNumber
          begin
            WeekNumberFontsize : Integer;
            WeekNumberFontcolor : TColor;
            WeekNumberfontName : string;
            WeekNumberfontstyle : Integer;
            WeekNumberfontshadow : Boolean;
            WeekNumberVisible : Boolean;
            WeekNumberOffset : Tpoint;
          end;
          Node1 := Node.ChildNodes.FindNode('WeekDay');
          if(Node1 <> nil)then //WeekDay
          begin
            WeekDayFontsize : integer;
            WeekDayFontcolor : TColor;
            WeekDayfontName : string;
            WeekDayFontstyle : Integer;
            WeekDayFontshadow : Boolean;
            WeekDayUseShort : Boolean;
          end;
          Node1 := Node.ChildNodes.FindNode('Day');
          if(Node1 <> nil)then //Day
          begin
            DayFontsize : integer;
            DayFontcolor : TColor;
            DayfontName : string;
            DayFontstyle : integer;
            DayFontshadow : Boolean;
            Dayspace : Integer;
            VerticalSpace : Integer;
            DayEventColor : TColor;
            DayWeekendColor: TColor;
            DayOffset : TPoint;
          end;
          Node1 := Node.ChildNodes.FindNode('PreButton');
          if(Node1 <> nil)then //PreButton
          begin
            PreButtonOffset : TPoint;
            PreButtonImg : string;
          end;
          Node1 := Node.ChildNodes.FindNode('NextButton');
          if(Node1 <> nil)then //NextButton
          begin
            NextButtonOffset : TPoint;
            NextButtonImg : string;
          end;
          Node1 := Node.ChildNodes.FindNode('TodayImg');
          if(Node1 <> nil)then //TodayImg
          begin
            todayimg : string;
          end;  }
      end;
      {if Node.Attributes['windowName'] = 'EventForm' then
      begin//EventForm
      //Background
        BackgroundBitmap : string;
        BackgroundWidth : integer;
        BackgroundTextMaxWidth : integer;
        BackgroundOffset : TPoint;
        BackgroundBottomPadding : Integer;
        BackgroundMargin : TRect; //top="39" left="10" right="15" bottom="20"
      //Header
        HeaderAlign : Integer;
       // <Bitmap />
        HeaderFontsize : Integer;
        Headercolor : TColor;
        HeaderfontName : string;
        Headerstyle : Integer;
        Headershadow : Boolean;
        HeaderOffset  : TPoint;
        HeaderText : string;
      //EventList
        EventListFontsize : Integer;
        EventListcolor : TColor;
        EventListfontName : string;
        EventListstyle : Integer;
        EventListshadow : Boolean;
      //EventDay
        EventDayFontsize : Integer;
        EventDaycolor : TColor;
        EventDayfontName : string;
        EventDaystyle : Integer;
        EventDayshadow : Boolean;
      //MenuButton
        EventDayMenuButtonOffset : TPoint;
        EventDayMenuButtonImg : string;
      //CloseButton
        EventDayCloseButtonOffset : TPoint;
        EventDayCloseButtonImg : string;
      //AddButton
        AddButtonOffset : TPoint;
        AddButtonImg : string;
      end;
      if Node.Attributes['windowNam'] = 'TaskForm' then
      begin//TaskForm
      //Background
        TaskFormBackgroundBitmap : string;
        TaskFormBackgroundWidth : integer;
        TaskFormBackgroundTextMaxWidth : integer;
        TaskFormBackgroundOffset : TPoint;
        TaskFormBackgroundBottomPadding : integer;
        TaskFormBackgroundMargin  : TRect; //top="30" left="10" right="15" bottom="15" />
      //Header
        TaskFormHeaderAlign : Integer;
        //TaskFormHeaderBitmap />
        TaskFormHeaderFontsize : Integer;
        TaskFormHeadercolor : TColor;
        TaskFormHeaderfontName : string;
        TaskFormHeaderstyle : integer;
        TaskFormHeadershadow : Boolean;
        TaskFormHeaderOffset  : Tpoint;
        TaskFormHeaderText : string;
      //EventList
        TaskFormEventListFontsize : Integer;
        TaskFormEventListcolor : TColor;
        TaskFormEventListfontName : string;
        TaskFormEventListstyle : integer;
        TaskFormEventListshadow : Boolean;
      //EventDay
        TaskFormEventDayFontsize : integer;
        TaskFormEventDaycolor : TColor;
        TaskFormEventDayfontName : string;
        TaskFormEventDaystyle : integer;
        TaskFormEventDayshadow : Boolean;
      //MenuButton
        TaskFormEventDayMenuButtonOffset : Tpoint;
        TaskFormEventDayMenuButtonImg : string;
      //CloseButton
        TaskFormEventDayCloseButtonOffset : Tpoint;
        TaskFormEventDayCloseButtonImg : string;
      //AddButton
        TaskFormEventDayAddButtonOffset  : Tpoint;
        TaskFormEventDayAddButtonImg : string;
      //PreButton
        TaskFormEventDayPreButtonOffset : TPoint;
        TaskFormEventDayPreButtonImg : string;
        TaskFormEventDayPreButtonImgD : string;
      //NextButton
        TaskFormEventDayNextButtonOffset : TPoint;
        TaskFormEventDayNextButtonImg : string;
        TaskFormEventDayNextButtonImgD : string;
      end;
      if Node.Attributes['windowName'] = 'WeatherForm' then
      begin//WeatherForm
      //Background
        WeatherFormBackgroundBitmap : string;
        WeatherFormBackgroundWidth : Integer;
        WeatherFormBackgroundTextMaxWidth : integer;
        WeatherFormBackgroundOffset  : TPoint;
        WeatherFormBackgroundBottomPadding : integer;
        WeatherFormBackgroundMargin : Trect;
      //Header
        WeatherFormHeaderAlign : integer;
        WeatherFormHeaderFontsize : integer;
        WeatherFormHeaderstyle : integer;
        WeatherFormHeadershadow : Boolean;
        WeatherFormHeaderOffset  : TPoint;
      //EventList
        WeatherFormEventListFontsize : integer;
        WeatherFormEventListstyle : integer;
        WeatherFormEventListshadow : Boolean;
      //EventDay
        WeatherFormEventDayFontsize : integer;
        WeatherFormEventDaystyle : integer;
        WeatherFormEventDayshadow: Boolean;
      //MenuButton
        WeatherFormMenuButtonOffset : TPoint;
        WeatherFormMenuButtonImg : string;
      //CloseButton
      loseButtonOffset : TPoint;
      loseButtonImg : string;
      TodayTemperaturesize : integer;
      TodayTemperaturecolor : TColor;
      TodayTemperaturefontName : string;
      TodayTemperaturestyle : integer;
      TodayTemperatureshadow : Boolean;
      Todaysize : integer;
      Todaycolor : TColor;
      TodayfontName : string;
      Todaystyle : integer;
      Todayshadow : Boolean;
      WeekdayNamesize : integer;
      WeekdayNamecolor : TColor;
      WeekdayNamefontName : string;
      WeekdayNamestyle : integer;
      WeekdayNameshadow : Boolean;
      CityNamesize : integer;
      CityNamecolor : TColor;
      CityNamefontName : string;
      CityNamestyle : integer;
      CityNameshadow :Boolean;
      Temperaturesize : integer;
      Temperaturecolor : TColor;
      TemperaturefontName : string;
      Temperaturestyle : integer;
      Temperatureshadow : Boolean;
      WeatherFormVerticalSpace : Integer;
      //TodayWeatherSize>
        TodayWeatherSizeWidth : Integer;
        TodayWeatherSizeHeight : Integer;
      end; }
    end;
  until not(Node = nil);

  //text2 := XMLSkin.ChildNodes['model'].Text;
  //text3  := XMLSkin.ChildNodes['number'].Text;
end;

procedure TSkin.load;
begin


end;

function TSkin.LoadFile: Boolean;
begin
  Doc := LoadXMLDocument(Path + 'skin.xml');
  XMLSkin := Doc.DocumentElement;
end;

procedure TSkin.save;
begin
  doc.SaveToFile(Path + 'skin.xml');
end;

function TSkin.SaveFile: Boolean;
begin

end;

end.
