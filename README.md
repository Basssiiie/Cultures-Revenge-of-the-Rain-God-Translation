<h1 align="center">
Cultures: Revenge of the Rain Gods
<br/>
English Translation Pack
</h1>

This is an English community translation pack for Revenge of the Rain Gods, a mission pack released for the first original Cultures game on a separate CD and as part of the **Cultures: Gold Edition**. Both these games have only been released officially in German. To share its wonderful campaign and new missions with the rest of the world, this English translation pack was created.

**This pack is currently a work in progress.**

| ![Select campaign window](https://raw.githubusercontent.com/Basssiiie/Cultures-Revenge-of-the-Rain-Gods-Translation/main/images/campaign-select.png) | ![Briefing for The Departure](https://raw.githubusercontent.com/Basssiiie/Cultures-Revenge-of-the-Rain-Gods-Translation/main/images/the-departure-briefing.png) | ![Paying tribute for mercenaries](https://raw.githubusercontent.com/Basssiiie/Cultures-Revenge-of-the-Rain-Gods-Translation/main/images/buying-mercenaries.png) |
|--|--|--|

## Features

This pack contains the following changes so far:

- All campaign levels of 'Revenge of the Rain Gods' in English.
- Enabled the available built-in English language files for various menu's and adds missing strings.

### Planned

- The new scenario's added by the mission pack.

#### Maybe?

- Campaign intro/outro movies.
- Briefing voice-overs.
- Import English translations from the base game.
- Multiplayer maps?
- In-game manual.

## Requirements

To play the 'Revenge of the Rain Gods' campaign in English, you must own the original German mission CD or a German copy of **Cultures: Gold Edition**.

**This translation pack does not contain the game itself.**

## How to install

1. Make a backup of the folder of the game you wish to have translated.
2. Download the latest version from the [Releases](https://github.com/Basssiiie/Cultures-Revenge-of-the-Rain-Gods-Translation/releases) tab.
3. Extract the contents of the `*.zip` file and paste them over the installation folder of your game.
4. Allow to replace everything.
5. Start the game and it should launch in English.

If you find any issues with the translations in this pack, please report them via the [Issues](https://github.com/Basssiiie/Cultures-Revenge-of-the-Rain-Gods-Translation/issues) page, or let me know personally.


### Optional: run in windowed mode

Follow these steps to make the game run in windowed mode, instead of full-screen, on modern machines.

1. Create a shortcut for the game by right clicking it and select '**Create shortcut**'.
2. Right-click the shortcut and select '**Properties**'.
3. Go to the '**Shortcut**' tab and find the '**Target**' field, which is the path to the `*.exe` file.
4. At the end of the path, after the `"` quote, add a space and the `-window` property.
5. Go to the '**Compatibility**' tab and enable the '**Reduced colour mode**' option and set its dropdown to '**16-bit (65535 colour)**'.
6. Save the changes and launch the game from the shortcut to start it in windowed mode.
7. Additionally, you can change the resolution of the windowed mode in the '**Graphic Options**' menu.


## Contributing

This project is open to contributions from others! If you want to pick up a translation, it may be a good idea to make an issue to give me a heads-up.

The project structured with the following folders:

- `translations`: contains the files with the translations for the game.
- `documentation`: contains information about specific translated levels, [see here](./documentation/README.md).
- `tests`: contains some automated test scripts to validate the submitted translations.

### Building the project

To build the project, you need to have the following dependencies installed:

1. Powershell or Powershell Core.
2. Python 3, available as `python` in the `PATH` environment variable.

To create a build:

1. Start Powershell.
2. Navigate to the project's folder using `cd`.
3. Run the following command:
```ps
./build.ps1
```

The output of the build will be placed in the `./dist` folder. These files act like a release of the translation pack and can be copy/pasted over the Cultures installation folder. The `dist` folder will be cleared before every build.

The build script will download the [Cultures file converters made by Mikulus](https://culturesnation.pl/serwerdownload.php?cat_id=8&download_id=403) to the `./bin` folder and run it using Python to convert some of the files to the appropriate format.


### Running tests

There are two options for running the tests locally: either via Docker or via Powershell with Pester.

#### Powershell with Pester

Running the tests via Pester requires only installing the Pester module on Windows. On other platforms you need to install [Powershell](https://github.com/PowerShell/PowerShell#readme) as well (it's multi-platform).

First install Pester for Powershell via:
```ps
Install-Module -Name Pester -Force -SkipPublisherCheck -Scope CurrentUser
```

The `-Force` and `-SkipPublisherCheck` are required on Windows 10 to override the older version of Pester that ships with Windows ([see here](https://pester.dev/docs/introduction/installation#installing-from-psgallery-on-windows-10-or-windows-server-2016)).

After Pester is installed, you can run the tests in the folder where this readme is located with the following command:
```ps
Invoke-Pester ./tests/* -Output Detailed
```

#### Docker

Running the tests via Docker requires more tooling to be installed, but is easier if you have these already. The following tooling is required:

- [Docker Desktop](https://docs.docker.com/get-docker)
- [Act](https://github.com/nektos/act#readme)

Please refer to the [documentation for installing Act](https://github.com/nektos/act#installation) to set up the environment.

After everything is ready, you can run the following command in the folder where this readme is located:
```bash
act -P ubuntu-latest=ghcr.io/catthehacker/ubuntu:pwsh-latest
```
