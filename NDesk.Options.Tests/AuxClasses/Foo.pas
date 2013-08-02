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
namespace  NDesk.Options.Tests;

interface
uses
  System.ComponentModel;

type
  [TypeConverter(typeOf(FooConverter))]
  Foo = class
  private
    var fValue: String;

  public
    class var A: Foo := new Foo('A'); readonly; 
    class var B: Foo := new Foo('B'); readonly; 

    constructor (value: String);

    method ToString(): String; override;
  end;


implementation


constructor Foo(value: String);
begin
  self.fValue := value;
end;


method Foo.ToString(): String;
begin
  exit  (self.fValue);
end;


end.


