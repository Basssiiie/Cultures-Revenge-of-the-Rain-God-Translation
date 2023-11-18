$ErrorActionPreference = "Stop"

# Download converter by Mikulus if it does not exist yet
if (!(Test-Path -Path "./bin"))
{
	New-Item -ItemType Directory -Path "./bin"

	$url = "https://culturesnation.pl/serwerdownload.php?file_id=403";
	Invoke-WebRequest -Uri $Url -OutFile "./bin/download.zip"
	Expand-Archive -Path "./bin/download.zip" -DestinationPath "./bin"
}

# Remove the old build files
$output = "./dist"
Remove-Item "$output"

# Copy the raw text files that do not need conversion
$language = "english"
$root = "./translations/$language"
Copy-Item "$root/data_m/c1_txt" "$output/data_m/c1_txt" -Recurse

New-Item -ItemType Directory -Path "$output/data/gui"

# Convert the other files that need to be compiled
$core = @(
	"5`n$root/game.ini`n$output/game.cif",
	"9`n$root/data/gui/language_eng.txt`n$output/data/gui/language_eng.tab"
)
$maps = Get-Item "$root/data_m/*.ini" `
	| ForEach-Object { "5`n$($_.FullName)`n$output/data_m/$($_.BaseName).cif" }

$files = ($core + $maps) -join "`n"
$files -join "`n" | python "./bin/converters/source_code/main.py"

Write-Host "`nBuild succeeded!`nTranslation pack created in: $output" -ForegroundColor Green
