namespace  NDesk.Options.Prism.Tests;

interface
uses
  NUnit.Framework,
  NDesk.Options;

type
  [TestFixture]
  OptionCommandLineTest = public class
  public
    [Test]
    method Bordercase_Test();

    [Test]
    method Parser_Test();

    method ParserTestRun(commandLine: String; expectedResult: array of String);
  end;


implementation


method OptionCommandLineTest.Bordercase_Test();
begin
  Assert.IsNull(OptionCommandLine.Parse(nil), 'Result is not null for null command line');
  Assert.AreEqual(0, length(OptionCommandLine.Parse('')), 'Result is wrong for empty command line');
end;


method OptionCommandLineTest.ParserTestRun(commandLine: String; expectedResult: array of String);
begin
  var  lActualResult: array of String := OptionCommandLine.Parse(commandLine);

  Assert.AreEqual(expectedResult.Length, lActualResult.Length, 'Actual result length differs from expected');

  for  i: Int32  :=  0  to  expectedResult.Length-1  do
    Assert.AreEqual(expectedResult[i], lActualResult[i], 'Parse result is wrong');
end;


method OptionCommandLineTest.Parser_Test();
begin
  self.ParserTestRun('Item1',            [ 'Item1' ]);
  self.ParserTestRun(' Item1  Item2 ',   [ 'Item1', 'Item2' ]);
  self.ParserTestRun(' Item1  Item2 I3', [ 'Item1', 'Item2', 'I3' ]);
  self.ParserTestRun('A "B""C" ',        [ 'A', '"B""C"' ]);
  self.ParserTestRun('A """"',           [ 'A', '""""' ]);
  self.ParserTestRun('A "" B',           [ 'A', '""', 'B' ]);
  self.ParserTestRun('A  B C ',          [ 'A', 'B', 'C' ]);
  self.ParserTestRun('A"  B" C ',        [ 'A"  B"', 'C' ]);
  self.ParserTestRun('A""B C ',          [ 'A""B C ' ]);
  self.ParserTestRun('A"B C',            [ 'A"B C' ]);
  self.ParserTestRun('A  B"',            [ 'A', 'B"' ]);
  self.ParserTestRun('A  B""',           [ 'A', 'B""' ]);
  self.ParserTestRun('A'#09'  "B C" ',   [ 'A', '"B C"' ]);
  self.ParserTestRun('"A  B C"',         [ '"A  B C"' ]);
  self.ParserTestRun('A'#10'"B C ',      [ 'A', '"B C ' ]);
  self.ParserTestRun('A'#13'"B C"',      [ 'A', '"B C"' ]);
  self.ParserTestRun('A B"C D"',         [ 'A', 'B"C D"' ]);
end;


end.