unit cIRC_Data;

interface

uses
  Windows,
  SysUtils,
  Classes,
  Graphics,
  Controls,
  Forms,
  Dialogs,
  ExtCtrls,
  StrUtils;

type

  TcIRC_Server = class;
  TcIRC_ServerArray = class;
  TcIRC_Message = class;
  TcIRC_MessageArray = class;
  TcIRC_Channel = class;
  TcIRC_ChannelArray = class;
  TcIRC_User = class;
  TcIRC_UserArray = class;

  { TcIRC_Server }

  TcIRC_Server = class(TObject)
  private

  public
    constructor Create;
    destructor Destroy; override;
  public

  end;

  { TcIRC_ServerArray }

  TcIRC_ServerArray = class(TObject)
  private

  public
    constructor Create;
    destructor Destroy; override;
  public

  end;

  { TcIRC_Message }

  TcIRC_Message = class(TObject)
  private
    FCommand: string;
    FData: string;
    FDestination: string;
    FHostname: string;
    FNick: string;
    FParams: string;
    FPrefix: string;
    FServer: string;
    FTimeStamp: TDateTime;    FTrailing: string;    FUser: string;    FValid: Boolean;  public
    constructor Create(const Data: string);
  public
    property Command: string read FCommand;
    property Data: string read FData;
    property Destination: string read FDestination;
    property Hostname: string read FHostname;
    property Nick: string read FNick;
    property Params: string read FParams;
    property Prefix: string read FPrefix;
    property Server: string read FServer;
    property TimeStamp: TDateTime read FTimeStamp;    property Trailing: string read FTrailing;    property User: string read FUser;    property Valid: Boolean read FValid;  end;

  { TcIRC_MessageArray }

  TcIRC_MessageArray = class(TObject)
  private

  public
    constructor Create;
    destructor Destroy; override;
  public

  end;

  { TcIRC_Channel }

  TcIRC_Channel = class(TObject)
  private

  public
    constructor Create;
    destructor Destroy; override;
  public

  end;

  { TcIRC_ChannelArray }

  TcIRC_ChannelArray = class(TObject)
  private

  public
    constructor Create;
    destructor Destroy; override;
  public

  end;

  { TcIRC_User }

  TcIRC_User = class(TObject)
  private

  public
    constructor Create;
  public

  end;

  { TcIRC_UserArray }

  TcIRC_UserArray = class(TObject)
  private

  public
    constructor Create;
    destructor Destroy; override;
  public

  end;

implementation

{ TcIRC_Server }

constructor TcIRC_Server.Create;
begin

end;

destructor TcIRC_Server.Destroy;
begin

  inherited;
end;

{ TcIRC_ServerArray }

constructor TcIRC_ServerArray.Create;
begin

end;

destructor TcIRC_ServerArray.Destroy;
begin

  inherited;
end;

{ TcIRC_Message }

constructor TcIRC_Message.Create(const Data: string);
var
  S: string;
  sub: string;
  i: Integer;
begin
  FValid := False;
  FTimeStamp := Now;
  FData := Data;
  S := Data;
  // :<prefix> <command> <params> :<trailing>
  // the only required part of the message is the command
  // if there is no prefix, then the source of the message is the server for the current connection (such as for PING)
  if Copy(Data, 1, 1) = ':' then
  begin
    i := Pos(' ', S);
    if i > 0 then
    begin
      FPrefix := Copy(S, 2, i - 2);
      S := Copy(S, i + 1, Length(S) - i);
    end;
  end;
  i := Pos(' :', S);
  if i > 0 then
  begin
    FTrailing := Copy(S, i + 2, Length(S) - i - 1);
    S := Copy(S, 1, i - 1);
  end;
  i := Pos(' ', S);
  if i > 0 then
  begin
    // params found
    FParams := Copy(S, i + 1, Length(S) - i);
    S := Copy(S, 1, i - 1);
  end;
  FCommand := S;
  if FCommand = '' then
    Exit;
  FValid := True;
  if FPrefix <> '' then
  begin
    // prefix format: nick!user@hostname
    i := Pos('!', FPrefix);
    if i > 0 then
    begin
      FNick := Copy(FPrefix, 1, i - 1);
      sub := Copy(FPrefix, i + 1, Length(FPrefix) - i);
      i := Pos('@', sub);
      if i > 0 then
      begin
        FUser := Copy(sub, 1, i - 1);
        FHostname := Copy(sub, i + 1, Length(sub) - i);
      end;
    end
    else
      FNick := FPrefix;
  end;
  i := Pos(' ', FParams);
  if i <= 0 then
    FDestination := FParams;
end;

{ TcIRC_MessageArray }

constructor TcIRC_MessageArray.Create;
begin

end;

destructor TcIRC_MessageArray.Destroy;
begin

  inherited;
end;

{ TcIRC_Channel }

constructor TcIRC_Channel.Create;
begin

end;

destructor TcIRC_Channel.Destroy;
begin

  inherited;
end;

{ TcIRC_ChannelArray }

constructor TcIRC_ChannelArray.Create;
begin

end;

destructor TcIRC_ChannelArray.Destroy;
begin

  inherited;
end;

{ TcIRC_User }

constructor TcIRC_User.Create;
begin

end;

{ TcIRC_UserArray }

constructor TcIRC_UserArray.Create;
begin

end;

destructor TcIRC_UserArray.Destroy;
begin

  inherited;
end;

end.