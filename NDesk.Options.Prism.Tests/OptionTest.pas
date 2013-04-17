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
  NUnit.Framework;


type
  [TestFixture]
  OptionTest = public class
  public
    [Test]
    method Exceptions_Test();
  end;


implementation


method OptionTest.Exceptions_Test();
begin
  var p: Object := nil;
  
  Utils.AssertException(typeOf(ArgumentNullException), 'Value cannot be null.'#13#10'Parameter name: prototype', p, 
    method (v: Object);
    begin
      new DefaultOption(nil, nil);
    end);

  Utils.AssertException(typeOf(ArgumentException), 'Cannot be an empty string.'#13#10'Parameter name: prototype', p, 
    method (v: Object);
    begin
      new DefaultOption('', nil);
    end);
  
  Utils.AssertException(typeOf(ArgumentException), 'Empty option names are not supported.'#13#10'Parameter name: prototype', p,
    method(v: Object);
    begin
      new DefaultOption('a|b||c=', nil);
    end);

  Utils.AssertException(typeOf(ArgumentException), 'Conflicting option types: ''='' vs. '':''.'#13#10'Parameter name: prototype', p,
    method(v: Object) ;
    begin
      new DefaultOption('a=|b:', nil);
    end);

  Utils.AssertException(typeOf(ArgumentException), 'The default option handler ''<>'' cannot require values.'#13#10'Parameter name: prototype', p, 
    method(v: Object) ;
    begin
      new DefaultOption('<>=', nil);
    end);

  Utils.AssertException(typeOf(ArgumentException), 'The default option handler ''<>'' cannot require values.'#13#10'Parameter name: prototype', p, 
    method(v: Object) ;
    begin
      new DefaultOption('<>:', nil)
    end);

  Utils.AssertException(nil, nil, p,
    method(v: Object) ;
    begin
      new DefaultOption('t|<>=', nil, 1);
    end);

  Utils.AssertException(typeOf(ArgumentException), 'The default option handler ''<>'' cannot require values.'#13#10'Parameter name: prototype', p,
    method(v: Object);
    begin
      new DefaultOption('t|<>=', nil, 2);
    end);

  Utils.AssertException(nil, nil, p, 
    method(v: Object);
    begin
      new DefaultOption('a|b=', nil, 2);
    end);

  Utils.AssertException(typeOf(ArgumentOutOfRangeException), 'Specified argument was out of the range of valid values.'#13#10'Parameter name: maxValueCount', p, 
    method(v: Object);
    begin
      new DefaultOption('a', nil, -1);
    end);

  Utils.AssertException(typeOf(ArgumentException), 'Cannot provide maxValueCount of 0 for OptionValueType.Required or OptionValueType.Optional.'#13#10'Parameter name: maxValueCount', p, 
    method(v: Object);
    begin
      new DefaultOption('a=', nil, 0);
    end);

  Utils.AssertException(typeOf(ArgumentException), 'Ill-formed name/value separator found in "a={".'#13#10'Parameter name: prototype', p,
    method(v: Object);
    begin
      new DefaultOption('a={', nil);
    end);

  Utils.AssertException(typeOf(ArgumentException), 'Ill-formed name/value separator found in "a=}".'#13#10'Parameter name: prototype', p, 
    method(v: Object);
    begin
      new DefaultOption('a=}', nil);
    end);

  Utils.AssertException(typeOf(ArgumentException), 'Ill-formed name/value separator found in "a={{}}".'#13#10'Parameter name: prototype', p, 
    method(v: Object);
    begin
      new DefaultOption('a={{}}', nil);
    end);

  Utils.AssertException(typeOf(ArgumentException), 'Ill-formed name/value separator found in "a={}}".'#13#10'Parameter name: prototype', p, 
    method(v: Object);
    begin
      new DefaultOption('a={}}', nil);
    end);

  Utils.AssertException(typeOf(ArgumentException), 'Ill-formed name/value separator found in "a={}{".'#13#10'Parameter name: prototype', p, 
    method(v: Object);
    begin
      new DefaultOption('a={}{', nil);
    end);

  Utils.AssertException(typeOf(ArgumentException), 'Cannot provide key/value separators for Options taking 1 value(s).'#13#10'Parameter name: prototype', p, 
    method(v: Object);
    begin
      new DefaultOption('a==', nil);
    end);

  Utils.AssertException(typeOf(ArgumentException), 'Cannot provide key/value separators for Options taking 1 value(s).'#13#10'Parameter name: prototype', p, 
    method(v: Object);
    begin
      new DefaultOption('a={}', nil);
    end);

  Utils.AssertException(typeOf(ArgumentException), 'Cannot provide key/value separators for Options taking 1 value(s).'#13#10'Parameter name: prototype', p, 
    method(v: Object);
    begin
      new DefaultOption('a=+-*/', nil);
    end);

  Utils.AssertException(nil, nil, p, 
    method(v: Object);
    begin
      new DefaultOption('a', nil, 0);
    end);

  Utils.AssertException(nil, nil, p, 
    method(v: Object);
    begin
      new DefaultOption('a', nil, 0);
    end);

  Utils.AssertException(nil, nil, p, 
    method(v: Object);
    begin
      var d: DefaultOption := new DefaultOption('a', nil);
      Assert.AreEqual(d.GetValueSeparators.Length, 0);
    end);

  Utils.AssertException(nil, nil, p, 
    method(v: Object);
    begin
      var d: DefaultOption := new DefaultOption('a=', nil, 1);
      Assert.AreEqual(d.GetValueSeparators.Length, 0);
    end);

  Utils.AssertException(nil, nil, p, 
    method(v: Object);
    begin
      var s: array of String := new DefaultOption('a=', nil, 2).GetValueSeparators;
      Assert.AreEqual(s.Length, 2);
      Assert.AreEqual(":", s[0]);
      Assert.AreEqual("=", s[1]);
    end);

  Utils.AssertException(nil, nil, p, 
    method(v: Object);
    begin
      var d: DefaultOption := new DefaultOption('a={}', nil, 2);
      Assert.AreEqual(d.GetValueSeparators.Length, 0);
    end);

  Utils.AssertException(nil, nil, p, 
    method(v: Object);
    begin
      var s: array of String := new DefaultOption('a={-->}{=>}', nil, 2).GetValueSeparators;
      Assert.AreEqual(s.Length, 2);
      Assert.AreEqual(s[0], '-->');
      Assert.AreEqual(s[1], '=>');
    end);

  Utils.AssertException(nil, nil, p, 
    method(v: Object);
    begin
      var s: array of String := new DefaultOption('a=+-*/', nil, 2).GetValueSeparators;
      Assert.AreEqual(s.Length, 4);
      Assert.AreEqual("+", s[0]);
      Assert.AreEqual("-", s[1]);
      Assert.AreEqual("*", s[2]);
      Assert.AreEqual("/", s[3]);
    end);
end;


end.
