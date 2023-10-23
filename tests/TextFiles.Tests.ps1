BeforeDiscovery {
    $files = Get-ChildItem "./translations/english/data_m/c1_txt/c1_fhll/text_*.txt"
}

Describe "Map briefing *.txt files" {
	It "Files exist" -ForEach @{ files = $files } {
		$files.Count | Should -BeGreaterThan 50

		$filenames = $files | Select-Object -ExpandProperty Name
		$filenames | Should -Contain "text_140203.txt"
		$filenames | Should -Contain "text_501000.txt"
	}

    It "Valid txt file: <_.Name>" -ForEach $files {

		$content = [IO.File]::ReadAllText($_.FullName, [Text.Encoding]::GetEncoding(1252))
		$length = $content.Length;

		for ($idx = 0; $idx -lt $length; $idx++)
		{
			$character = $content[$idx];

			if($count -eq [char]'\')
			{
				# Only \n is currently allowed
				$content[++$idx] | Should -Be "n"
			}
			elseif($character -eq [char]'<')
			{
				$middle = $content.IndexOf(':', ++$idx)
				$middle | Should -Not -Be -1

				$tag = $content.Substring($idx, ($middle - $idx))
				$tag | Should -BeIn @(
					"anchor", "block", "color", "font", "globaljump", "icon", "include",
					"includetext", "localjump", "onscreencallback", "picture", "rem",
					"setdatafileid", "textxend", "textxstart", "userpicture"
				)

				$end = $content.IndexOf('>', ++$middle)
				$end | Should -Not -Be -1

				$value = $content.Substring($middle, ($end - $middle))
				$value_regex = switch -Regex ($tag)
				{
					"^(?:include|includetext|rem)$" { "^[^<]+$" } # plain text string
					"^(?:globaljump|onscreencallback)$" { "^\d+,\d+,\d+$" } # three integers
					default { "^\d+$" } # single integer
				}
				$value | Should -Match $value_regex

				$idx = $end
			}
			else
			{
				$character | Should -Not -Be ">"
			}
		}
    }
}
