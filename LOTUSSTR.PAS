{ @author: Sylvain Maltais (support@gladir.com)
  @created: 2023
  @website(https://www.gladir.com/CODER/LOTUSSCRIPTSTRLIB-TP)
  @abstract(Target: Turbo Pascal 7, Free Pascal)
}

Unit LOTUSSTR;

INTERFACE

Function Bin(X:Byte):String;
Function CurDir:String;
Function Date:String;
Function DuplicateString(C:Char;Num:Integer):String;
Function Hex(value:LongInt):String;
Function LCase(S:String):String;
Function Left(S:String;L:Integer):String;
Function LTrim(S:String):String;
Function Oct(value:Byte):String;
Function PadRight(S:String;Space:Byte):String;
Function PadZeroLeft(Value:Integer;Space:Byte):String;
Function Right(S:String;L:Integer):String;
Function RTrim(s:String):String;
Function Space(L:Byte):String;
Function StrCompare(A,B:String):Integer;
Function StrReverse(S:String):String;
Function Time:String;
Function Trim(s:String):String;
Function UCase(S:String):String;

IMPLEMENTATION

Uses DOS;

Function TrimZero(S:String):String;
Var
 I:Byte;
Begin
 For I:=1to Length(S)do Begin
  If S[I]<>'0'Then Begin
   TrimZero:=Copy(S,I,255);
   Exit;
  End;
 End;
 TrimZero:=S;
End;

Function Left(S:String;L:Integer):String;Begin
 Left:=Copy(S,1,L);
End;

Function Right(S:String;L:Integer):String;
Begin
 If(L>=Length(S))Then Right:=S
                 Else Right:=Copy(S,Length(S)-L,L);
End;

Function PadRight(S:String;Space:Byte):String;
Var
 I:Byte;
Begin
 If Length(S)<Space Then For I:=Length(S)+1 to Space do S:=S+' ';
 PadRight:=S;
End;

Function PadZeroLeft(Value:Integer;Space:Byte):String;
Var
 S:String;
Begin
 Str(Value,S);
 While Length(S)<Space do S:='0'+S;
 PadZeroLeft:=S;
End;

Function LTrim(S:String):String;
Var
 I:Byte;
Begin
 For I:=1to Length(S)do Begin
  If S[I]<>' 'Then Begin
   LTrim:=Copy(S,I,255);
   Exit;
  End;
 End;
 LTrim:=S;
End;

Function RTrim(s:String):String;
Var
 i:Integer;
Begin
 i:=Length(s);
 While (i>0)and(s[i]in[#9,' '])do Dec(i);
 s[0]:=Chr(i);
 RTrim:=S;
End;

Function Trim(s:String):String;Begin
 Trim:=LTrim(RTrim(s));
End;

Function LCase(S:String):String;
Var
 I:Byte;
Begin
 For I:=1 to Length(S)do Begin
  If S[I] in['A'..'Z']Then S[I]:=Chr(Ord(S[I])+32);
 End;
 LCase:=S;
End;

Function UCase(S:String):String;
Var
 I:Byte;
Begin
 For I:=1 to Length(S)do Begin
  If S[I] in['a'..'z']Then S[I]:=Chr(Ord(S[I])-32);
 End;
 UCase:=S;
End;

Function DuplicateString(C:Char;Num:Integer):String;
Var
 I:Byte;
 S:String;
Begin
 S:='';
 For I:=1 to Num do S:=S+C;
 DuplicateString:=S;
End;

Function Space(L:Byte):String;
Var
 S:String;
Begin
 If(L=0)Then Space:=''
  else
 Begin
  FillChar(S[1],L,' ');
  S[0]:=Char(L);
  Space:=S;
 End;
End;

Function StrCompare(A,B:String):Integer;Begin
 If A<B Then StrCompare:=-1 Else
 If A=B Then StrCompare:=0
        Else StrCompare:=1;
End;

Function StrReverse(S:String):String;
Var
 I:Integer;
 R:String;
Begin
 R:='';
 For I:=1 to Length(S)do Begin
  R:=S[I]+R;
 End;
 StrReverse:=R;
End;

Function Time:String;
Var
 S:String;
 Hour,Min,Sec,Sec100:Word;
Begin
 GetTime(Hour,Min,Sec,Sec100);
 S:=PadZeroLeft(Hour,2);
 S:=S+':';
 S:=S+PadZeroLeft(Min,2);
 S:=S+':';
 S:=S+PadZeroLeft(Sec,2);
 Time:=S;
End;

Function Date:String;
Var
 Year,Month,Day,DayOfWeek:Word;
 S:String;
Begin
 GetDate(Year,Month,Day,DayOfWeek);
 S:=PadZeroLeft(Month,2);
 S:=S+'/';
 S:=S+PadZeroLeft(Day,2);
 S:=S+'/';
 S:=S+PadZeroLeft(Year,4);
 Date:=S;
End;

Function CurDir:String;
Var
 S:String;
Begin
 GetDir(0,S);
 CurDir:=S;
End;

Function Bin(X:Byte):String;
Var
 I:Integer;
 S:String;
Begin
 If X=0 Then Begin
  Bin:='0';
  Exit;
 End;
 S:='';
 For I:=0 to 7 do Begin
  S:=Chr(Byte('0')+((X shr I)and 1))+S;
 End;
 Bin:=TrimZero(S);
End;

Function Hex(value:LongInt):String;
Const
 matrix:Array[0..15]of Char = ('0','1','2','3','4','5','6','7','8','9','A','B','C','D','E','F');
Begin
 If value=0 Then Begin
  Hex:='0';
  Exit;
 End;
 Hex:=TrimZero(matrix[(value shr 28) and $0F]+matrix[(value shr 24)and $F]+
               matrix[(value shr 20) and $0F]+matrix[(value shr 16)and $F]+
               matrix[(value shr 12) and $0F]+matrix[(value shr 8)and $F]+
               matrix[(value shr 4) and $0F]+matrix[value and $F]);
End;

Function Oct(value:Byte):String;
Const
 matrix:Array[0..7]of Char = ('0','1','2','3','4','5','6','7');
Begin
 If value=0 Then Begin
  Oct:='0';
  Exit;
 End;
 Oct:=TrimZero(matrix[(value shr 6) and 7]+
               matrix[(value shr 3) and 7]+
               matrix[value and 7]);
End;

END.
