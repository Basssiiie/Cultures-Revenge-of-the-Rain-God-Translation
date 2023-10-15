BeforeDiscovery {
    $files = Get-ChildItem "./translations/english/data_m/*.ini"
}

Describe "Map string *.ini files" {
	It "Files exist" -ForEach @{ files = $files } {
		$files.Count | Should -BeGreaterThan 5

		$filenames = $files | Select-Object -ExpandProperty Name
		$filenames | Should -Contain "c2_01_a_txt.ini"
		$filenames | Should -Contain "c1_md_05_txt.ini"
	}

    It "Valid ini file: <_.Name>" -ForEach $files {

		$lines = Get-Content $_.FullName -Encoding "windows-1252"
		$count = 1;
		foreach ($line in $lines)
		{
			if($count -eq 1)
			{
				$line | Should -Be "[Text]"
			}
			elseif($count -gt 1 -and $line.StartsWith("sn "))
			{
				$line | Should -Match '^sn \d+ "[^"]*"$'
			}
			elseif($count -gt 2 -and $line.StartsWith("s "))
			{
				$line | Should -Match '^s "[^"]*"$'
			}
			else
			{
				$line | Should -Match '^\s*$'
				$count | Should -BeGreaterThan 1
			}
			$count++
		}
    }
}
