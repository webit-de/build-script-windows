#---------------------------
# if user is not admin, start powershell in admin mode in new window
#---------------------------

if(!([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator"))
{
  $arguments = "& '" + $myinvocation.mycommand.definition + "'"
  Start-Process powershell -Verb runAs -ArgumentList $arguments
  Break
}

#---------------------------
# Chocolatey
#---------------------------

# Chocolatey

if (Get-Command choco -errorAction SilentlyContinue) { # check if choco exists
  Write-Host ''
  Write-Host "Chocolatey already installed." -fore green
  Write-Host ''
} else { # if not, install actual version
  iex ((new-object net.webclient).DownloadString("https://chocolatey.org/install.ps1"))
}
if(!$?) { exit 1 }

Write-Progress -Activity "Component Installation" -PercentComplete 0

#---------------------------
# Refresh System Environment Variable for Terminal
#---------------------------

$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine")

Write-Host ''
Write-Host "Actual System Environment Path" -fore green
Write-Host $env:Path -fore yellow
Write-Host ''

#---------------------------
# Install Ruby, Nodejs and Git
#---------------------------

Write-Host ''
Write-Host "Install Ruby, Nodejs, Git with chocolatey" -fore green
Write-Host ''

# Ruby
choco install ruby -y
if(!$?) { exit 1 }

Write-Progress -Activity "Component Installation" -PercentComplete 10

# NodeJS Version 4.2.6
choco install nodejs.install -version 4.2.6 -y
if(!$?) { exit 1 }

Write-Progress -Activity "Component Installation" -PercentComplete 20

# Git
choco install git.install -y
if(!$?) { exit 1 }

Write-Progress -Activity "Component Installation" -PercentComplete 30

#---------------------------
# Refresh Environment Variables for Terminal
#---------------------------

$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")

Write-Host ''
Write-Host "Actual System and User Environment Path" -fore green
Write-Host $env:Path -fore yellow
Write-Host ''

#---------------------------
# Ruby
#---------------------------

Write-Host ''
Write-Host "Update gems on System" -fore green
Write-Host ''

gem update --system
if(!$?) { exit 1 }

Write-Progress -Activity "Component Installation" -PercentComplete 40

Write-Host ''
Write-Host "Install Compass and Bundler." -fore green
Write-Host ''

# Compass
gem install compass
if(!$?) { exit 1 }

Write-Progress -Activity "Component Installation" -PercentComplete 50

# Bundler.io
gem install bundler
if(!$?) { exit 1 }

Write-Progress -Activity "Component Installation" -PercentComplete 60

#---------------------------
# NodeJS
#---------------------------

Write-Host ''
Write-Host "Update npm to actual version" -fore green
Write-Host ''

# NPM
npm install -g npm
if(!$?) { exit 1 }

Write-Progress -Activity "Component Installation" -PercentComplete 70

Write-Host ''
Write-Host "Install Yeoman, Grunt and Bower." -fore green
Write-Host ''

# Yeoman
npm install -g yo
if(!$?) { exit 1 }

Write-Progress -Activity "Component Installation" -PercentComplete 80

# Grunt-Cli
npm install -g grunt-cli
if(!$?) { exit 1 }

Write-Progress -Activity "Component Installation" -PercentComplete 90

# Bower
npm install -g bower
if(!$?) { exit 1 }

Write-Progress -Activity "Component Installation" -PercentComplete 100

Write-Host ''
Write-Host "Thank You! Now everything should be ready to start with new Projects." -fore green
Write-Host ''
