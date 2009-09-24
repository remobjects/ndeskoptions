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
  System.ComponentModel,
  System.Globalization;

type
  FooConverter = class(TypeConverter)
  public
    method  CanConvertFrom(context: ITypeDescriptorContext;  sourceType: &Type): Boolean; override;
    method ConvertFrom(context: ITypeDescriptorContext;  culture: CultureInfo;  value: Object): Object; override;
  end;


implementation


method FooConverter.CanConvertFrom(context: ITypeDescriptorContext;  sourceType: &Type): Boolean;
begin
  exit  (((sourceType = typeof(String)) or inherited CanConvertFrom(context, sourceType)));
end;


method FooConverter.ConvertFrom(context: ITypeDescriptorContext;  culture: CultureInfo;  value: Object): Object;
begin
  var lValue: String := String(value);

  if  (assigned(lValue))  then
    case  lValue  of
      "A":  exit  (Foo.A);
      "B":  exit  (Foo.B);
    end;

  exit  (inherited  ConvertFrom(context, culture, value));
end;


end.