unit cIRC_Test;

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
  StrUtils,
  cIRC_Data;

type

  TcIRC_TestMessageData = record
    Command: string;
    Destination: string;
    Hostname: string;
    Nick: string;
    Params: string;
    Prefix: string;
    Trailing: string;    User: string;
  end;

procedure RunTests;

procedure RunServerTests(var Success: Boolean);
procedure RunMessageTests(var Success: Boolean);
procedure RunChannelTests(var Success: Boolean);
procedure RunUserTests(var Success: Boolean);

implementation

uses
  Main;

procedure RunTests;
var
  Success: Boolean;
begin
  Success := True;
  Main.FormMain.Memo1.Lines.Clear;
  Main.FormMain.Memo1.Lines.Add('== RUNNING TESTS ==');
  RunServerTests(Success);
  RunMessageTests(Success);
  RunChannelTests(Success);
  RunUserTests(Success);
  if Success then
    Main.FormMain.Memo1.Lines.Add('== ALL TESTS PASSED! ==')
  else
    Main.FormMain.Memo1.Lines.Add('== ONE OR MORE TESTS FAILED! ==');
end;

procedure RunServerTests(var Success: Boolean);
begin

end;

procedure RunMessageTest(var Success: Boolean; const Data: string; const CheckData: TcIRC_TestMessageData);
var
  TestMessage: cIRC_Data.TcIRC_Message;
  Local: string;
begin
  TestMessage := cIRC_Data.TcIRC_Message.Create(Data);
  try
    Local := '';
    if TestMessage.Command <> CheckData.Command then
      Local := 'Command="' + TestMessage.Command + '"';
    if TestMessage.Destination <> CheckData.Destination then
      Local := 'Destination="' + TestMessage.Destination + '"';
    if TestMessage.Hostname <> CheckData.Hostname then
      Local := 'Hostname="' + TestMessage.Hostname + '"';
    if TestMessage.Nick <> CheckData.Nick then
      Local := 'Nick="' + TestMessage.Nick + '"';
    if TestMessage.Params <> CheckData.Params then
      Local := 'Params="' + TestMessage.Params + '"';
    if TestMessage.Prefix <> CheckData.Prefix then
      Local := 'Prefix="' + TestMessage.Prefix + '"';
    if TestMessage.Trailing <> CheckData.Trailing then      Local := 'Trailing="' + TestMessage.Trailing + '"';    if TestMessage.User <> CheckData.User then
      Local := 'User="' + TestMessage.User + '"';
    if Local <> '' then
    begin
      Main.FormMain.Memo1.Lines.Add('RunMessageTest FAILED [' + Local + ']: "' + Data + '"');
      Success := False;
    end
    else
      Main.FormMain.Memo1.Lines.Add('RunMessageTest SUCCESS: "' + Data + '"');
  finally
    TestMessage.Free;
  end;
end;

procedure RunMessageTests(var Success: Boolean);
var
  CheckData: TcIRC_TestMessageData;
begin
  CheckData.Command := '';
  CheckData.Destination := '';
  CheckData.Hostname := '';
  CheckData.Nick := '';
  CheckData.Params := '';
  CheckData.Prefix := '';
  CheckData.Trailing := '';  CheckData.User := '';
  RunMessageTest(Success, '', CheckData);
  CheckData.Command := 'QUIT';
  RunMessageTest(Success, 'QUIT', CheckData);
  CheckData.Prefix := 'testnick!~testuser@testhost';
  CheckData.Nick := 'testnick';
  CheckData.User := '~testuser';
  CheckData.Hostname := 'testhost';
  CheckData.Command := 'PRIVMSG';
  CheckData.Params := '#chan';
  CheckData.Destination := '#chan';
  CheckData.Trailing := 'test message';
  RunMessageTest(Success, ':testnick!~testuser@testhost PRIVMSG #chan :test message', CheckData);
  CheckData.Command := 'INVITE';
  CheckData.Params := 'opnick';
  CheckData.Destination := 'opnick';
  CheckData.Trailing := '#chan';
  RunMessageTest(Success, ':testnick!~testuser@testhost INVITE opnick :#chan', CheckData);
  CheckData.Command := 'JOIN';
  CheckData.Params := '#chan';
  CheckData.Destination := '#chan';
  CheckData.Trailing := '';
  RunMessageTest(Success, ':testnick!~testuser@testhost JOIN #chan', CheckData);
  CheckData.Command := 'NICK';
  CheckData.Params := '';
  CheckData.Destination := '';
  CheckData.Trailing := 'testnick2';
  RunMessageTest(Success, ':testnick!~testuser@testhost NICK :testnick2', CheckData);
  CheckData.Command := 'PART';
  CheckData.Params := '#chan';
  CheckData.Destination := '#chan';
  CheckData.Trailing := 'part message';
  RunMessageTest(Success, ':testnick!~testuser@testhost PART #chan :part message', CheckData);
  CheckData.Command := 'QUIT';
  CheckData.Params := '';
  CheckData.Destination := '';
  CheckData.Trailing := 'quit message';
  RunMessageTest(Success, ':testnick!~testuser@testhost QUIT :quit message', CheckData);
  CheckData.Prefix := 'opnick!~opuser@ophost';
  CheckData.Nick := 'opnick';
  CheckData.User := '~opuser';
  CheckData.Hostname := 'ophost';
  CheckData.Command := 'KICK';
  CheckData.Params := '#chan testnick';
  CheckData.Destination := '';
  CheckData.Trailing := 'some reason';
  RunMessageTest(Success, ':opnick!~opuser@ophost KICK #chan testnick :some reason', CheckData);
  CheckData.Command := 'KILL';
  CheckData.Params := 'testnick';
  CheckData.Destination := 'testnick';
  CheckData.Trailing := 'some reason';
  RunMessageTest(Success, ':opnick!~opuser@ophost KILL testnick :some reason', CheckData);
  CheckData.Prefix := 'irc.sylnt.us';
  CheckData.Nick := 'irc.sylnt.us';
  CheckData.User := '';
  CheckData.Hostname := '';
  CheckData.Command := '311';
  CheckData.Params := 'exec tme520 ~TME520 218-883-738-54.tpgi.com.au *';
  CheckData.Destination := '';
  CheckData.Trailing := 'TME520';
  RunMessageTest(Success, ':irc.sylnt.us 311 exec tme520 ~TME520 218-883-738-54.tpgi.com.au * :TME520', CheckData);
  CheckData.Command := '319';
  CheckData.Params := 'exec crutchy';
  CheckData.Destination := '';
  CheckData.Trailing := '#wiki +#test #sublight #help @#exec #derp @#civ';
  RunMessageTest(Success, ':irc.sylnt.us 319 exec crutchy :#wiki +#test #sublight #help @#exec #derp @#civ', CheckData);
  CheckData.Command := '330';
  CheckData.Params := 'exec crutchy_ crutchy';
  CheckData.Destination := '';
  CheckData.Trailing := 'is logged in as';
  RunMessageTest(Success, ':irc.sylnt.us 330 exec crutchy_ crutchy :is logged in as', CheckData);
  CheckData.Command := '353';
  CheckData.Params := 'exec = #civ';
  CheckData.Destination := '';
  CheckData.Trailing := 'exec @crutchy chromas arti';
  RunMessageTest(Success, ':irc.sylnt.us 353 exec = #civ :exec @crutchy chromas arti', CheckData);
  CheckData.Command := '401';
  CheckData.Params := 'exec SedBot';
  CheckData.Destination := '';
  CheckData.Trailing := 'No such nick/channel';
  RunMessageTest(Success, ':irc.sylnt.us 401 exec SedBot :No such nick/channel', CheckData);
  CheckData.Command := '318';
  CheckData.Params := 'crutchy crutchy';
  CheckData.Destination := '';
  CheckData.Trailing := 'End of /WHOIS list.';
  RunMessageTest(Success, ':irc.sylnt.us 318 crutchy crutchy :End of /WHOIS list.', CheckData);
  CheckData.Command := '315';
  CheckData.Params := 'crutchy #Soylent';
  CheckData.Destination := '';
  CheckData.Trailing := 'End of /WHO list.';
  RunMessageTest(Success, ':irc.sylnt.us 315 crutchy #Soylent :End of /WHO list.', CheckData);
  CheckData.Command := '354';
  CheckData.Params := 'crutchy 152 #Soylent mrcoolbp H@+';
  CheckData.Destination := '';
  CheckData.Trailing := '';
  RunMessageTest(Success, ':irc.sylnt.us 354 crutchy 152 #Soylent mrcoolbp H@+', CheckData);
  CheckData.Command := '322';
  CheckData.Params := 'crutchy # 8';
  CheckData.Destination := '';
  CheckData.Trailing := 'testing of other bots';
  RunMessageTest(Success, ':irc.sylnt.us 322 crutchy # 8 :testing of other bots', CheckData);
end;

procedure RunChannelTests(var Success: Boolean);
begin

end;

procedure RunUserTests(var Success: Boolean);
begin

end;

end.