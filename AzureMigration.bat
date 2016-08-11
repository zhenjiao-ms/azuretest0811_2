git add *
git commit -m "add files"
git push origin
rem powershell ".\AzureMigration.ps1 -parameters:'SourceFolder=.\azure-content-pr;OutputFolder=.\azure-content-migrated;LogOutputFolder=.\Migrationlog'"