<Project DefaultTargets="Build" xmlns="http://schemas.microsoft.com/developer/msbuild/2003" ToolsVersion="3.5">
  <PropertyGroup>
    <ProductVersion>3.5</ProductVersion>
    <RootNamespace>NDesk.Options.Tests</RootNamespace>
    <StartupClass />
    <OutputType>library</OutputType>
    <AssemblyName>NDesk.Options.Tests</AssemblyName>
    <AllowGlobals>False</AllowGlobals>
    <AllowLegacyWith>False</AllowLegacyWith>
    <AllowLegacyOutParams>False</AllowLegacyOutParams>
    <AllowLegacyCreate>False</AllowLegacyCreate>
    <AllowUnsafeCode>False</AllowUnsafeCode>
    <ApplicationIcon />
    <Configuration Condition="'$(Configuration)' == ''">Release</Configuration>
    <TargetFrameworkVersion>v3.5</TargetFrameworkVersion>
    <Name>NDesk.Options.Tests</Name>
    <ProjectGuid>{18ceafa0-4a14-4094-9415-bb9869eaf3a7}</ProjectGuid>
  </PropertyGroup>
  <PropertyGroup Condition=" '$(Configuration)' == 'Debug' ">
    <Optimize>False</Optimize>
    <OutputPath>bin\Debug\</OutputPath>
    <DefineConstants>DEBUG;TRACE;</DefineConstants>
    <GeneratePDB>True</GeneratePDB>
    <GenerateMDB>True</GenerateMDB>
    <EnableAsserts>True</EnableAsserts>
    <TreatWarningsAsErrors>False</TreatWarningsAsErrors>
    <CaptureConsoleOutput>False</CaptureConsoleOutput>
    <StartMode>Project</StartMode>
    <RegisterForComInterop>False</RegisterForComInterop>
    <CpuType>anycpu</CpuType>
    <RuntimeVersion>v25</RuntimeVersion>
    <XmlDoc>False</XmlDoc>
    <XmlDocWarningLevel>WarningOnPublicMembers</XmlDocWarningLevel>
    <EnableUnmanagedDebugging>False</EnableUnmanagedDebugging>
    <SuppressWarnings>
    </SuppressWarnings>
    <CodeFlowAnalysis>True</CodeFlowAnalysis>
    <UseXmlDoc>False</UseXmlDoc>
    <XmlDocAllMembers>False</XmlDocAllMembers>
    <WarnOnCaseMismatch>True</WarnOnCaseMismatch>
    <RunCodeAnalysis>False</RunCodeAnalysis>
    <RequireExplicitLocalInitialization>False</RequireExplicitLocalInitialization>
    <FutureHelperClassName>
    </FutureHelperClassName>
  </PropertyGroup>
  <PropertyGroup Condition=" '$(Configuration)' == 'Release' ">
    <Optimize>true</Optimize>
    <OutputPath>.\bin\Release</OutputPath>
    <GeneratePDB>False</GeneratePDB>
    <GenerateMDB>False</GenerateMDB>
    <EnableAsserts>False</EnableAsserts>
    <TreatWarningsAsErrors>False</TreatWarningsAsErrors>
    <CaptureConsoleOutput>False</CaptureConsoleOutput>
    <StartMode>Project</StartMode>
    <RegisterForComInterop>False</RegisterForComInterop>
    <CpuType>anycpu</CpuType>
    <RuntimeVersion>v25</RuntimeVersion>
    <XmlDoc>False</XmlDoc>
    <XmlDocWarningLevel>WarningOnPublicMembers</XmlDocWarningLevel>
    <EnableUnmanagedDebugging>False</EnableUnmanagedDebugging>
  </PropertyGroup>
  <ItemGroup>
    <Reference Include="mscorlib">
    </Reference>
    <Reference Include="nunit.framework">
      <Name>nunit.framework</Name>
      <Private>True</Private>
    </Reference>
    <Reference Include="nunit.mocks">
      <Name>nunit.mocks</Name>
      <Private>True</Private>
    </Reference>
    <Reference Include="System">
    </Reference>
  </ItemGroup>
  <ItemGroup>
    <Compile Include="AuxClasses\DefaultOption.pas">
    </Compile>
    <Compile Include="AuxClasses\Foo.pas">
    </Compile>
    <Compile Include="AuxClasses\FooConverter.pas">
    </Compile>
    <Compile Include="OptionCommandLineTest.pas">
    </Compile>
    <Compile Include="OptionContextTest.pas">
    </Compile>
    <Compile Include="OptionSetTest.pas">
    </Compile>
    <Compile Include="OptionTest.pas">
    </Compile>
    <Compile Include="Properties\AssemblyInfo.pas" />
    <EmbeddedResource Include="Properties\Resources.resx">
      <Generator>ResXFileCodeGenerator</Generator>
    </EmbeddedResource>
    <Compile Include="Properties\Resources.Designer.pas" />
    <None Include="Properties\Settings.settings">
      <Generator>SettingsSingleFileGenerator</Generator>
    </None>
    <Compile Include="Properties\Settings.Designer.pas" />
    <Compile Include="Utils\Utils.pas">
    </Compile>
  </ItemGroup>
  <ItemGroup>
    <Folder Include="AuxClasses" />
    <Folder Include="Utils" />
    <Folder Include="Properties\" />
  </ItemGroup>
  <ItemGroup>
    <ProjectReference Include="..\NDesk.Options\NDesk.Options.oxygene">
      <Name>NDesk.Options</Name>
      <Project>{eb1a6efb-37f3-4905-a926-454c8eff194d}</Project>
      <Private>True</Private>
      <HintPath>..\NDesk.Options\bin\Debug\NDesk.Options.dll</HintPath>
    </ProjectReference>
  </ItemGroup>
  <Import Project="$(MSBuildExtensionsPath)\RemObjects Software\Oxygene\RemObjects.Oxygene.Echoes.targets" />
</Project>
