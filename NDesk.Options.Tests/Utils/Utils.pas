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
namespace NDesk.Options.Tests;

interface

uses
  System;

type
  Utils = static class
  public
    class method AssertException<T>(exception: &Type;  message: String;  argument: T;  action: Action<T>);
  end;


implementation

class method Utils.AssertException<T>(exception: &Type;  message: String;  argument: T;  action: Action<T>);
begin
  var lActualType: &Type := nil;
  var lStack: String := nil;
  var lActualMessage: String := nil;

  try
    action(argument);
  except
    on  E: Exception  do  begin
      lActualType := E.GetType();
      lActualMessage := E.Message;
      if  (not Object.&Equals(lActualType, exception))  then
        lStack := E.ToString()
    end
  end;

  if  (not Object.&Equals(lActualType, exception))  then
    raise  new  InvalidOperationException(String.Format('Assertion failed: Expected Exception Type {0}, got {1}.' + Environment.NewLine + 'Actual Exception: {2}', exception, lActualType, lStack));

  NUnit.Framework.Assert.AreEqual(lActualMessage, message);
  
  if  (not Object.&Equals(lActualMessage, message))  then
    raise new InvalidOperationException(String.Format('Assertion failed:' + Environment.NewLine + 'Expected: {0}' + Environment.NewLine + '  Actual: {1}', message, lActualMessage))
end;


end.
