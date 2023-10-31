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
Remove-Item "./dist"

# Copy the raw text files that do not need
$language = "english"
Copy-Item "./translations/$language/data_m" "./dist/data_m" -Recurse

New-Item -ItemType Directory -Path "./dist/data/gui"

# Convert the other files that need to be compiled
@"
5
./translations/$language/game.ini
./dist/game.cif
9
./translations/$language/data/gui/language_eng.txt
./dist/data/gui/language_eng.tab
"@ | python "./bin/converters/source_code/main.py"

Write-Host "`nBuild succeeded!`nTranslation pack created in: ./dist" -ForegroundColor Green
