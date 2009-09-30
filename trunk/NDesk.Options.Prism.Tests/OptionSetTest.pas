//
// Converted to Delphi Prism from original code by Anton Kasyanov
// (CS2PAS utility was used (http://code.remobjects.com/p/csharptoxy/))
// NDesk.Options is available at http://www.ndesk.org/Options
//
// Authors:
//  Jonathan Pryor <jpryor@novell.com>
//
// Copyright (C) 2008 Novell (http://www.novell.com)
//
// Permission is hereby granted, free of charge, to any person obtaining
// a copy of this software and associated documentation files (the
// "Software"), to deal in the Software without restriction, including
// without limitation the rights to use, copy, modify, merge, publish,
// distribute, sublicense, and/or sell copies of the Software, and to
// permit persons to whom the Software is furnished to do so, subject to
// the following conditions:
// 
// The above copyright notice and this permission notice shall be
// included in all copies or substantial portions of the Software.
// 
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
// EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
// MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
// NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
// LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
// OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
// WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//
namespace  NDesk.Options.Prism.Tests;

interface
uses
  System.Collections.Generic,
  System.ComponentModel,
  System.IO,
  NUnit.Framework,
  NDesk.Options;

type
  [TestFixture]
  OptionSetTest = public class
  private
     class method  _([ParamArray] argument: array of String): IEnumerable<String>;
     class method  AssertDictionary<TKey, TValue>(dictionary: Dictionary<TKey, TValue>; [ParamArray] &set: array of String);

  public
    [Test]
    method BooleanValues_Test();

    [Test]
    method BundledValues_Test();
     
    [Test]
    method CombinationPlatter_Test();

    [Test]
    method CustomKeyValue_Test();

    [Test]
    method DefaultHandler_Test();

    [Test]
    method  DefaultHandlerRuns_Test();

    [Test]
    method  DerivedType_Test();

    [Test]
    method  Exceptions_Test();

    [Test]
    method  HaltProcessing_Test();

    [Test]
    method  KeyValueOptions_Test();

    [Test]
    method  Localization_Test();

    [Test]
    method  MixedDefaultHandler_Test();

    [Test]
    method  OptionalValues_Test();

    [Test]
    method  OptionBundling_Test();

    [Test]
    method  OptionContext_Test();

    [Test]
    method  OptionParts_Test();

    [Test]
    method  RequiredValues_Test();

    [Test]
    method WriteOptionDescriptions_Test();
  end;


  CiOptionSet nested in OptionSetTest = private class(OptionSet)
  public
    method CheckOptionParts(option: String;  er: Boolean;  ef: String;  en: String;  es: String;  ev: String);
    method GetOptionForName(n: String): Option; reintroduce;
    method InsertItem(&index: Int32;  item: Option); override;
    method Parse(option: String; c: OptionContext): Boolean; override;
  end;


  ContextCheckerOption nested in OptionSetTest = private class(Option)
  private
    var fName: String;
    var fValue: String;
    var fIndex: Int32;

  protected
    method OnParseComplete(optionContext: NDesk.Options.OptionContext); override;

  public
    constructor(p: String;  d: String;  name: String;  value: String;  &index: Int32);
  end;


  CustomOption nested in OptionSetTest = private class(Option)
  private
    var fAction: Action<OptionValueCollection>;

  protected
    method OnParseComplete(optionContext: OptionContext); override;

  public
    constructor(parameter: String;  description: String;  count: Int32;  action: Action<OptionValueCollection>);
  end;


implementation


{$REGION OptionSetTest.CiOptionSet }
method OptionSetTest.CiOptionSet.CheckOptionParts(option: String;  er: Boolean;  ef: String;  en: String;  es: String;  ev: String);
begin
  var f: String;
  var n: String;
  var s: String;
  var v: String;

  Assert.AreEqual(inherited GetOptionParts(option, out f, out n, out s, out v), er);
  Assert.AreEqual(f, ef);
  Assert.AreEqual(n, en);
  Assert.AreEqual(s, es);
  Assert.AreEqual(v, ev)
end;


method OptionSetTest.CiOptionSet.GetOptionForName(n: String): Option;
begin
  exit  (inherited GetOptionForName(n));
end;


method OptionSetTest.CiOptionSet.InsertItem(&index: Int32;  item: Option);
begin
  if (item.Prototype.ToLower <> item.Prototype) then 
    raise new ArgumentException('prototypes must be null!');
  inherited InsertItem(&index, item);
end;


method OptionSetTest.CiOptionSet.Parse(option: String; c: OptionContext): Boolean;
begin
  var f: String;
  var n: String;
  var s: String;
  var v: String;
  
  if (assigned(c.Option))  then
    exit  (inherited Parse(option, c));

  if  (not inherited GetOptionParts(option, out f, out n, out s, out v)) then
    exit  (inherited Parse(option, c));

  exit  (inherited Parse(String.Concat(f, n.ToLower, iif(((v <> nil) and (s <> nil)), (s+v), '')), c));
end;
{$ENDREGION}


{$REGION OptionSetTest.CustomOption }
constructor OptionSetTest.CustomOption(parameter: String;  description: String;  count: Int32;  action: Action<OptionValueCollection>);
begin
  inherited constructor(parameter, description, count);
  self.fAction := action;
end;


method OptionSetTest.CustomOption.OnParseComplete(optionContext: OptionContext);
begin
  self.fAction.Invoke(optionContext.OptionValues);
end;
{$ENDREGION}


{$REGION MyRegion}
constructor OptionSetTest.ContextCheckerOption(p: String;  d: String;  name: String;  value: String;  &index: Int32);
begin
  inherited constructor(p, d, 1);
  self.fName := name;
  self.fValue := value;
  self.fIndex := &index
end;


method OptionSetTest.ContextCheckerOption.OnParseComplete(optionContext: NDesk.Options.OptionContext);
begin
  Assert.AreEqual(1, optionContext.OptionValues.Count);
  Assert.AreEqual(self.fValue, optionContext.OptionValues.Item[0]);
  Assert.AreEqual(self.fName, optionContext.OptionName);
  Assert.AreEqual(self.fIndex, optionContext.OptionIndex);
  Assert.AreEqual(self, optionContext.Option);
  Assert.AreEqual(inherited Description, optionContext.Option.Description);
end;
{$ENDREGION}


{$REGION Aux methods }
class method OptionSetTest._(argument: array of String): IEnumerable<String>;
begin
  exit  (argument);
end;


class method OptionSetTest.AssertDictionary<TKey, TValue>(dictionary: Dictionary<TKey, TValue>;  &set: array of String);
begin
  var lKeyConverter: TypeConverter := TypeDescriptor.GetConverter(typeOf(TKey));
  var lValueConverter: TypeConverter := TypeDescriptor.GetConverter(typeOf(TValue));

  Assert.AreEqual(dictionary.Count, (&set.Length div 2));

  for  i: Int32  :=  0  to  &set.Length-1  step  2  do begin
    var  lKey: TKey := (lKeyConverter.ConvertFromString(&set[i]) as TKey);
    Assert.IsTrue(dictionary.ContainsKey(lKey));

    if  (not  assigned(&set[(i+1)]))  then
      Assert.AreEqual(default(TValue), dictionary[lKey])
    else
      Assert.AreEqual(TValue(lValueConverter.ConvertFromString(&set[i+1])), dictionary[lKey]);
  end;
end;
{$ENDREGION}


method OptionSetTest.BooleanValues_Test();
begin
  var a: Boolean := false;

  var p: OptionSet := new OptionSet();
  p.Add('a', method(v: String);
             begin
               a := assigned(v);
             end);

  p.Parse(OptionSetTest._([ '-a' ]));
  Assert.IsTrue(a);

  p.Parse(OptionSetTest._([ '-a+' ]));
  Assert.IsTrue(a);

  p.Parse(OptionSetTest._([ '-a-' ]));
  Assert.IsFalse(a);
end;


method OptionSetTest.BundledValues_Test();
begin
  var defines: List<String> := new List<String>;
  var libs: List<String> := new List<String>;
  var debug: Boolean := false;
  
  var p: OptionSet := new OptionSet;

  p.Add('D|define=',    method(v: String);
                        begin
                          defines.Add(v);
                        end);

  p.Add('L|library:',   method(v: String);
                        begin
                          libs.Add(v);
                        end);

  p.Add('Debug',        method(v: String);
                        begin
                          debug := assigned(v);
                        end);

  p.Add('E',            method(v: String);
                        begin
                        end);

  p.Parse(OptionSetTest._([ '-DNAME', '-D', 'NAME2', '-Debug', '-L/foo', '-L', '/bar', '-EDNAME3' ]));
  Assert.AreEqual(3, defines.Count);
  Assert.AreEqual('NAME', defines.Item[0]);
  Assert.AreEqual('NAME2', defines.Item[1]);
  Assert.AreEqual('NAME3', defines.Item[2]);
  Assert.IsTrue(debug);

  Assert.AreEqual(2, libs.Count);
  Assert.AreEqual('/foo', libs.Item[0]);
  Assert.IsNull(libs.Item[1]);
  
  Utils.AssertException(typeOf(OptionException), 'Cannot bundle unregistered option ''-V''.', p,
    method(v: OptionSet);
    begin
      v.Parse(OptionSetTest._([ '-EVALUENOTSUP' ]));
    end);
end;


method OptionSetTest.CombinationPlatter_Test();
begin
  var a: Int32 := -1;
  var b: Int32 := -1;
  var av: String := nil;
  var bv: String := nil;
  var f: Foo := nil;
  var help: Int32 := 0;
  var verbose: Int32 := 0;

  var p: OptionSet := new OptionSet;
  
  p.Add('a=',           method(v: String);
                        begin
                          a := 1;
                          av := v;
                        end);
  
  p.Add('b', 'desc',    method(v: String);
                        begin
                          b := 2;
                          bv := v;
                        end);

  p.Add<Foo>('f=',      method(v: Foo);
                        begin
                          f := v;
                        end);

  p.Add('v',            method(v: String);
                        begin
                          inc(verbose);
                        end);

  p.Add('h|?|help',     method(v: String);
                        begin
                          case  v  of
                            'h':    help := help or 1;
                            '?':    help := help or 2;
                            'help': help := help or 4;
                          end;
                        end);
  
  var e: List<String> := p.Parse([ 'foo', '-v', '-a=42', '/b-', '-a', '64', 'bar', '--f', 'B', '/h', '-?', '--help', '-v' ]);

  Assert.AreEqual(2, e.Count);
  Assert.AreEqual('foo', e.Item[0]);
  Assert.AreEqual('bar', e.Item[1]);
  Assert.AreEqual(1, a);
  Assert.AreEqual('64', av);
  Assert.AreEqual(2, b);
  Assert.IsNull(bv);
  Assert.AreEqual(2, verbose);
  Assert.AreEqual(7, help);
  Assert.AreEqual(Foo.B, f);
end;


method OptionSetTest.CustomKeyValue_Test();
begin
  var  a: Dictionary<String, String> := new Dictionary<String, String>();
  var  b: Dictionary<String, array of String> := new Dictionary<String, array of String>();

  var p: OptionSet := new OptionSet;

  p.Add(new CustomOption('a==:', nil, 2,  method(v: OptionValueCollection);
                                          begin
                                            a.Add(v.Item[0], v.Item[1]);
                                          end));

  p.Add(new CustomOption('b==:', nil, 3,  method(v: OptionValueCollection);
                                          begin
                                            b.Add(v.Item[0], [ v.Item[1], v.Item[2] ]);
                                          end));

  p.Parse(OptionSetTest._([ '-a=b=c', '-a=d', 'e', '-a:f=g', '-a:h:i', '-a', 'j=k', '-a', 'l:m' ]));

  Assert.AreEqual(6, a.Count);
  Assert.AreEqual("c", a.Item['b']);
  Assert.AreEqual("e", a.Item['d']);
  Assert.AreEqual("g", a.Item['f']);
  Assert.AreEqual("i", a.Item['h']);
  Assert.AreEqual("k", a.Item['j']);
  Assert.AreEqual("m", a.Item['l']);
  
  Utils.AssertException(typeOf(OptionException), 'Missing required value for option ''-a''.', p,
    method(v: OptionSet);
    begin
      v.Parse(OptionSetTest._([ '-a=b' ]));
    end);

  p.Parse(OptionSetTest._([ '-b', 'a', 'b', 'c', '-b:d:e:f', '-b=g=h:i', '-b:j=k:l' ]));
  
  Assert.AreEqual(4, b.Count);
  Assert.AreEqual("b", b.Item['a'][0]);
  Assert.AreEqual("c", b.Item['a'][1]);
  Assert.AreEqual("e", b.Item['d'][0]);
  Assert.AreEqual("f", b.Item['d'][1]);
  Assert.AreEqual("h", b.Item['g'][0]);
  Assert.AreEqual("i", b.Item['g'][1]);
  Assert.AreEqual("k", b.Item['j'][0]);
  Assert.AreEqual("l", b.Item['j'][1])
end;


method OptionSetTest.DefaultHandler_Test();
begin
  var extra: List<String> := new List<String>;
  var p: OptionSet := new OptionSet;

  p.Add('<>',   method(v: String);
                begin
                  extra.Add(v)
                end);

  Assert.AreEqual(0, p.Parse(OptionSetTest._([ '-a', 'b', '--c=D', 'E' ])).Count);
  Assert.AreEqual(4, extra.Count);
  Assert.AreEqual('-a', extra.Item[0]);
  Assert.AreEqual("b", extra.Item[1]);
  Assert.AreEqual('--c=D', extra.Item[2]);
  Assert.AreEqual("E", extra.Item[3])
end;


method OptionSetTest.DefaultHandlerRuns_Test();
begin
  var formats: Dictionary<String, List<String>> := new Dictionary<String, List<String>>;
  var format: String := 'foo';

  var p: OptionSet := new OptionSet();

  p.Add('f|format=',  method(v: String);
                      begin
                        format := v;
                      end);

  p.Add('<>',         method(v: String);
                      begin
                        var f: List<String>;
                        if  (not formats.TryGetValue(format, out f))  then  begin
                          f := new List<String>;
                          formats.Add(format, f);
                        end;
                        f.Add(v);
                      end);

  Assert.AreEqual(0, p.Parse(OptionSetTest._([ 'a', 'b', '-fbar', 'c', 'd', '--format=baz', 'e', 'f' ])).Count);
  Assert.AreEqual(3, formats.Count);
  Assert.AreEqual(2, formats.Item['foo'].Count);
  Assert.AreEqual("a", formats.Item['foo'].Item[0]);
  Assert.AreEqual("b", formats.Item['foo'].Item[1]);
  Assert.AreEqual(2, formats.Item['bar'].Count);
  Assert.AreEqual("c", formats.Item['bar'].Item[0]);
  Assert.AreEqual("d", formats.Item['bar'].Item[1]);
  Assert.AreEqual(2, formats.Item['baz'].Count, 2);
  Assert.AreEqual("e", formats.Item['baz'].Item[0]);
  Assert.AreEqual("f", formats.Item['baz'].Item[1]);
end;


method OptionSetTest.DerivedType_Test();
begin
  var help: Boolean := false;
  
  var p: CiOptionSet := new CiOptionSet();
  
  p.Add('h|help', method(v: String);
                  begin
                    help := assigned(v);
                  end);

  p.Parse(OptionSetTest._([ '-H' ]));
  Assert.IsTrue(help);

  help := false;
  p.Parse(OptionSetTest._([ '-HELP' ]));
  Assert.IsTrue(help);
  Assert.AreEqual(p.Item[0], p.GetOptionForName('h'));
  Assert.AreEqual(p.Item[0], p.GetOptionForName('help'));
  Assert.AreEqual(nil, p.GetOptionForName('invalid'));

  Utils.AssertException(typeOf(ArgumentException), 'prototypes must be null!', p,
      method(v: CiOptionSet);
      begin
        v.Add<Int32>('N|NUM=',  method(n: Int32);
                                begin
                                end);
      end);

  Utils.AssertException(typeOf(ArgumentNullException), 'Value cannot be null.'#13#10'Parameter name: option', p,
      method(v: CiOptionSet);
      begin
        v.GetOptionForName(nil);
      end);
end;


method OptionSetTest.Exceptions_Test();
begin
  var a: String := nil;
  var p: OptionSet := new OptionSet();
  p.Add('a=', v -> begin a := v end);
  p.Add('b', v -> begin end);
  p.Add('c', v -> begin end);
  p.Add<Int32>('n=', v -> begin end);
  p.Add<Foo>('f=', v -> begin end);

  Utils.AssertException(typeOf(OptionException), 'Missing required value for option ''-a''.', p, v -> v.Parse(OptionSetTest._([ '-a' ])));

  Utils.AssertException(nil, nil, p, v -> v.Parse(OptionSetTest._([ '-a', '-a' ])));
  Assert.AreEqual('-a', a);

  Utils.AssertException(nil, nil, p, v -> v.Parse(OptionSetTest._([ '-a', '-b' ])));
  Assert.AreEqual('-b', a);

  Utils.AssertException(typeOf(ArgumentNullException), 'Value cannot be null.'#13#10'Parameter name: option', p, v -> v.Add(nil));

  Utils.AssertException(typeOf(OptionException), 'Could not convert string `value'' to type Int32 for option `-n''.', p, v -> v.Parse(OptionSetTest._([ '-n', 'value' ])));

  Utils.AssertException(typeOf(OptionException), 'Could not convert string `invalid'' to type Foo for option `--f''.', p, v -> v.Parse(OptionSetTest._([ '--f', 'invalid' ])));

  Utils.AssertException(typeOf(OptionException), 'Cannot bundle unregistered option ''-z''.', p, v -> v.Parse(OptionSetTest._([ '-cz', 'extra' ])));

  Utils.AssertException(typeOf(ArgumentNullException), 'Value cannot be null.'#13#10'Parameter name: action', p, v -> v.Add('foo', nil));

  Utils.AssertException(typeOf(ArgumentException), 'Cannot provide maxValueCount of 2 for OptionValueType.None.'#13#10'Parameter name: maxValueCount', p, 
        v-> v.Add('foo', (k, val) -> begin end));
end;


method OptionSetTest.HaltProcessing_Test();
begin
  var lOptionSet: OptionSet := new OptionSet();
  
  lOptionSet.Add('a', method(v: String);
                      begin
                      end);

  lOptionSet.Add('b', method(v: String);
                      begin
                      end);

  var e: List<String> := lOptionSet.Parse(OptionSetTest._([ '-a', '-b', '--', '-a', '-b' ]));
  
  Assert.AreEqual(2, e.Count);
  Assert.AreEqual('-a', e.Item[0]);
  Assert.AreEqual('-b', e.Item[1]);
end;


method OptionSetTest.KeyValueOptions_Test();
begin
  var a: Dictionary<String, String> := new Dictionary<String, String>();
  var b: Dictionary<Int32, Char> := new Dictionary<Int32, Char>();

  var p: OptionSet := new OptionSet();
  p.Add<String, String>('a=', (k, v) -> a.Add(k, v));
  p.Add<Int32, Char>('b=', (k, v) -> b.Add(k, v));
  p.Add<String, String>('c:', (k, v) -> begin if (assigned(k)) then a.Add(k, v) end);
  p.Add<String, String>('d={=>}{-->}', (k, v) -> a.Add(k, v));
  p.Add<String, String>('e={}', (k, v) -> a.Add(k, v));
  p.Add<String, String>('f=+/', (k, v) -> a.Add(k, v));


  p.Parse(OptionSetTest._([ '-a', 'A', 'B', '-a', 'C', 'D', '-a=E=F', '-a:G:H', '-aI=J', '-b', '1', 'a', '-b', '2', 'b' ]));
  OptionSetTest.AssertDictionary<String, String>(a, [ 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J' ]);
  OptionSetTest.AssertDictionary<Int32, Char>(b, [ '1', 'a', '2', 'b' ]);
  
  a.Clear();
  p.Parse(OptionSetTest._([ '-c' ]));
  Assert.AreEqual(0, a.Count);

  p.Parse(OptionSetTest._([ '-c', 'a' ]));
  Assert.AreEqual(0, a.Count);

  p.Parse(OptionSetTest._([ '-ca' ]));
  OptionSetTest.AssertDictionary<String, String>(a, [ "a", nil ]);
  
  a.Clear();
  p.Parse(OptionSetTest._([ '-ca=b' ]));
  OptionSetTest.AssertDictionary<String, String>(a, [ 'a', 'b' ]);

  a.Clear();
  p.Parse(OptionSetTest._([ '-dA=>B', '-d', 'C-->D', '-d:E', 'F', '-d', 'G', 'H', '-dJ-->K' ]));
  OptionSetTest.AssertDictionary<String, String>(a, [ 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'J', 'K' ]);

  a.Clear();
  p.Parse(OptionSetTest._([ '-eA=B', '-eC=D', '-eE', 'F', '-e:G', 'H' ]));
  OptionSetTest.AssertDictionary<String, String>(a, [ 'A=B', '-eC=D', 'E', 'F', 'G', 'H' ]);

  a.Clear();
  p.Parse(OptionSetTest._([ '-f1/2', '-f=3/4', '-f:5+6', '-f7', '8', '-f9=10', '-f11=12' ]));
  OptionSetTest.AssertDictionary<String, String>(a, [ '1', '2', '3', '4', '5', '6', '7', '8', '9=10', '-f11=12' ]);
end;


method OptionSetTest.Localization_Test();
begin
  var p: OptionSet := new OptionSet(f -> 'hello!');

  p.Add<Int32>('n=', v -> begin end);

  Utils.AssertException(typeOf(OptionException), 'hello!', p, v -> v.Parse(OptionSetTest._([ '-n=value' ])));

  var expected: StringWriter := new StringWriter();
  expected.WriteLine('  -nhello!                   hello!');

  var actual: StringWriter := new StringWriter();
  p.WriteOptionDescriptions(actual);

  Assert.AreEqual(expected.ToString(), actual.ToString());
end;


method OptionSetTest.MixedDefaultHandler_Test();
begin
  var tests: List<String> := new List<String>;

  var p: OptionSet := new OptionSet;
  
  p.Add('t|<>=',  method(v: String);
                  begin
                    tests.Add(v);
                  end);

  Assert.AreEqual(0, p.Parse(OptionSetTest._([ '-tA', '-t:B', '-t=C', 'D', '--E=F' ])).Count);
  Assert.AreEqual(5, tests.Count);
  Assert.AreEqual("A", tests.Item[0]);
  Assert.AreEqual("B", tests.Item[1]);
  Assert.AreEqual("C", tests.Item[2]);
  Assert.AreEqual("D", tests.Item[3]);
  Assert.AreEqual('--E=F', tests.Item[4])
end;


method OptionSetTest.OptionalValues_Test();
begin
  var a: String := nil;
  var n: Int32 := -1;
  var f: Foo := nil;

  var  p: OptionSet := new OptionSet();
  p.Add('a:',  method(v: String); begin a := v; end);
  p.Add<Int32>('n:', method(v: Int32); begin n := v; end);
  p.Add<Foo>('f:', method(v: Foo); begin f := v; end);
  
  p.Parse(OptionSetTest._([ '-a=s' ]));
  Assert.AreEqual("s", a);

  p.Parse(OptionSetTest._([ '-a' ]));
  Assert.IsNull(a);

  p.Parse(OptionSetTest._([ '-a=' ]));
  Assert.AreEqual("", a);

  p.Parse(OptionSetTest._([ '-f', 'A' ]));
  Assert.IsNull(f);

  p.Parse(OptionSetTest._([ '-f' ]));
  Assert.IsNull(f);

  p.Parse(OptionSetTest._([ '-f=A' ]));
  Assert.AreEqual(Foo.A, f);

  f := nil;
  p.Parse(OptionSetTest._([ '-fA' ]));
  Assert.AreEqual(Foo.A, f);

  p.Parse(OptionSetTest._([ '-n42' ]));
  Assert.AreEqual(42, n);

  p.Parse(OptionSetTest._([ '-n', '42' ]));
  Assert.AreEqual(0, n);

  p.Parse(OptionSetTest._([ '-n=42' ]));
  Assert.AreEqual(42, n);

  p.Parse(OptionSetTest._([ '-n' ]));
  Assert.AreEqual(0, n);
end;


method OptionSetTest.OptionBundling_Test();
begin
  var a: String := nil;
  var b: String := nil;
  var c: String := nil;
  var f: String := nil;
  var p: OptionSet := new OptionSet();
  
  p.Add('a',  method(v: String);
              begin
                a := 'a';
              end);

  p.Add('b',  method(v: String);
              begin
                b := 'b';
              end);

  p.Add('c',  method(v: String);
              begin
                c := 'c';
              end);

  p.Add('f=', method(v: String);
              begin
                f := v;
              end);

  var extra: List<String> := p.Parse(OptionSetTest._([ '-abcf', 'foo', 'bar' ]));
  
  Assert.AreEqual(1, extra.Count);
  Assert.AreEqual('bar', extra.Item[0]);
  Assert.AreEqual("a", a);
  Assert.AreEqual("b", b);
  Assert.AreEqual("c", c);
  Assert.AreEqual("foo", f);
end;


method OptionSetTest.OptionContext_Test();
begin
  var p: OptionSet := new OptionSet();
  p.Add(new ContextCheckerOption('a=', 'a desc', '/a', 'a-val', 1));
  p.Add(new ContextCheckerOption('b', 'b desc', '--b+', '--b+', 2));
  p.Add(new ContextCheckerOption('c=', 'c desc', '--c', 'C', 3));
  p.Add(new ContextCheckerOption('d', 'd desc', '/d-', nil, 4));

  Assert.AreEqual(4, p.Count);
  p.Parse(OptionSetTest._([ '/a', 'a-val', '--b+', '--c=C', '/d-' ]));
end;


method OptionSetTest.OptionParts_Test();
begin
  var p: CiOptionSet := new CiOptionSet;
  p.CheckOptionParts('A', false, nil, nil, nil, nil);
  p.CheckOptionParts('A=B', false, nil, nil, nil, nil);
  p.CheckOptionParts('-A=B', true, '-', 'A', '=', 'B');
  p.CheckOptionParts('-A:B', true, '-', 'A', ':', 'B');
  p.CheckOptionParts('--A=B', true, '--', 'A', '=', 'B');
  p.CheckOptionParts('--A:B', true, '--', 'A', ':', 'B');
  p.CheckOptionParts('/A=B', true, '/', 'A', '=', 'B');
  p.CheckOptionParts('/A:B', true, '/', 'A', ':', 'B');
  p.CheckOptionParts('-A=B=C', true, '-', 'A', '=', 'B=C');
  p.CheckOptionParts('-A:B=C', true, '-', 'A', ':', 'B=C');
  p.CheckOptionParts('-A:B:C', true, '-', 'A', ':', 'B:C');
  p.CheckOptionParts('--A=B=C', true, '--', 'A', '=', 'B=C');
  p.CheckOptionParts('--A:B=C', true, '--', 'A', ':', 'B=C');
  p.CheckOptionParts('--A:B:C', true, '--', 'A', ':', 'B:C');
  p.CheckOptionParts('/A=B=C', true, '/', 'A', '=', 'B=C');
  p.CheckOptionParts('/A:B=C', true, '/', 'A', ':', 'B=C');
  p.CheckOptionParts('/A:B:C', true, '/', 'A', ':', 'B:C');
  p.CheckOptionParts('-AB=C', true, '-', 'AB', '=', 'C');
  p.CheckOptionParts('-AB:C', true, '-', 'AB', ':', 'C')
end;


method OptionSetTest.RequiredValues_Test();
begin
  var a: String := nil;
  var n: Int32 := 0;
  
  var p: OptionSet := new OptionSet();
  
  p.Add('a=',         method(v: String);
                      begin
                        a := v;
                      end);

  p.Add<Int32>('n=',  method(v: Int32);
                      begin
                        n := v;
                      end);

  var extra: List<String> := p.Parse(OptionSetTest._([ 'a', '-a', 's', '-n=42', 'n' ]));

  Assert.AreEqual(2, extra.Count);
  Assert.AreEqual("a", extra.Item[0]);
  Assert.AreEqual("n", extra.Item[1]);
  Assert.AreEqual("s", a);
  Assert.AreEqual(42, n);
  
  Assert.AreEqual(0, p.Parse(OptionSetTest._([ '-a=' ])).Count);
  Assert.AreEqual("", a);
end;


method OptionSetTest.WriteOptionDescriptions_Test();
begin
  var p: OptionSet := new OptionSet();
  
  p.Add('p|indicator-style=', 'append / indicator to directories',  method(v: String);
                                                                    begin
                                                                    end);

  p.Add('color:', 'controls color info',                            method(v: String);
                                                                    begin
                                                                    end);

  p.Add('color2:', 'set {color}',                                   method(v: String);
                                                                    begin
                                                                    end);

  p.Add('rk=', 'required key/value option',                         method(k: String; v: String);
                                                                    begin
                                                                    end);

  p.Add('rk2=', 'required {{foo}} {0:key}/{1:value} option',        method(k: String; v: String);
                                                                    begin
                                                                    end);

  p.Add('ok:', 'optional key/value option',                         method(k: String; v: String) 
                                                                    begin
                                                                    end);

  p.Add('long-desc', 'This has a really'#10'long, multi-line description that also'#10'tests'#10'the-builtin-supercalifragilisticexpialidicious-break-on-hyphen.  Also, a list:'#10'  item 1'#10'  item 2',
                                                                    method(v: String);
                                                                    begin
                                                                    end);

  p.Add('long-desc2', 'IWantThisDescriptionToBreakInsideAWordGeneratingAutoWordHyphenation.',
                                                                    method(v: String);
                                                                    begin
                                                                    end);

  p.Add('h|?|help', 'show help text',                               method(v: String);
                                                                    begin
                                                                    end);

  p.Add('version', 'output version information and exit',           method(v: String);
                                                                    begin
                                                                    end);

  p.Add('<>',                                                       method(v: String);
                                                                    begin
                                                                    end);

  var expected: StringWriter := new StringWriter();

  expected.WriteLine('  -p, --indicator-style=VALUE');
  expected.WriteLine('                             append / indicator to directories');
  expected.WriteLine('      --color[=VALUE]        controls color info');
  expected.WriteLine('      --color2[=color]       set color');
  expected.WriteLine('      --rk=VALUE1:VALUE2     required key/value option');
  expected.WriteLine('      --rk2=key:value        required {foo} key/value option');
  expected.WriteLine('      --ok[=VALUE1:VALUE2]   optional key/value option');
  expected.WriteLine('      --long-desc            This has a really');
  expected.WriteLine('                               long, multi-line description that also');
  expected.WriteLine('                               tests');
  expected.WriteLine('                               the-builtin-supercalifragilisticexpialidicious-');
  expected.WriteLine('                               break-on-hyphen.  Also, a list:');
  expected.WriteLine('                                 item 1');
  expected.WriteLine('                                 item 2');
  expected.WriteLine('      --long-desc2           IWantThisDescriptionToBreakInsideAWordGenerating-');
  expected.WriteLine('                               AutoWordHyphenation.');
  expected.WriteLine('  -h, -?, --help             show help text');
  expected.WriteLine('      --version              output version information and exit');
  
  var actual: StringWriter := new StringWriter();
  p.WriteOptionDescriptions(actual);
  
  Assert.AreEqual(expected.ToString, actual.ToString);
end;


end.