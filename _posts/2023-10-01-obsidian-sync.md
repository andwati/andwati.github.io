---
title : Setting up Obsidian sync in Windows
description : Syncing Obsidian in Windows with Windows Task Scheduler with git
date : 2023-10-01
tags : [obsidian, git,sync, windows, cron, task scheduler, powershell]
---

Syncing Obsidian in Windows with Windows Task Scheduler and git

<!-- more -->

[Obsidian](https://obsidian.md/) is a powerful note-taking and knowledge management tool that has gained a dedicated following among researchers, writers, and knowledge workers. To make the most of Obsidian, it's essential to keep your notes synchronized across devices and ensure your data is regularly backed up.Obsidian is the private and flexible writing app that adapts to the way you think.

Obsidian is free for personal use.It does not charge based on features or usage.You only pay if you use Obsidian commercially.

In this article, we'll guide you through the process of setting up automated synchronization for your Obsidian vault on Windows using Windows Task Scheduler and a PowerShell script.[^note]

## Prerequisites

Before we dive into setting up the synchronization task, ensure you have the following prerequisites in place:

1. **Obsidian Installed:** Make sure Obsidian is [installed](https://obsidian.md/download) on your Windows computer, and you have an existing Obsidian vault that you want to sync.

1. **Git Installed:** You'll need Git installed and configured with your Obsidian vault's repository. If you haven't already done this, you can download Git from the [official website](https://git-scm.com/downloads) and follow the installation instructions.

1. **PowerShell Script:** The provided PowerShell script, sync.ps1, should be located in your Obsidian vault folder.

## Understanding the PowerShell Script

The provided PowerShell script, sync.ps1, is the heart of our synchronization task. It automates the process of committing changes in your Obsidian vault's Git repository and pushing them to your remote repository (e.g., GitHub or GitLab). Here's a brief overview of the script:

```ps1
# Define the folder path
$FolderPath = "C:\path\to\obsidian-vault"

# Change directory to the repository folder
Set-Location -Path $FolderPath

# Check if the working tree is clean
$IsClean = (git diff-index --quiet HEAD --) -or (git diff-files --quiet)

if ($IsClean) {
    Write-Host "Working tree is clean. Skipping commit and pushing changes."
    git push
} else {
    # Get the current date in the desired format (Day - Date)
    $CommitMessage = "$(Get-Date -Format 'dddd - yyyy-MM-dd HH:mm:ss')"

    # Commit the changes
    git add .
    git commit -m $CommitMessage

    # Push the changes
    git push
}
```

This script does the following:

- Sets the folder path to your Obsidian vault.
- Checks if there are any changes to commit. If the vault is clean (no changes), it skips the commit and only pushes changes.
- If there are changes, it commits them with a timestamped message and then pushes them to the remote repository.

## Setting up Windows Task Scheduler

Now that we have our PowerShell script ready, let's set up a scheduled task using Windows Task Scheduler to automate the synchronization process. Follow these steps:

1. **Open an Elevated PowerShell Prompt:** To run the necessary commands, open PowerShell as an administrator.

1. **Define Task Variables:** Execute the following commands to define variables for your task:

   ```ps1
   $ScriptPath = "C:\path\to\obsidian-vault\sync.ps1"
   $TaskName = "obsidian-sync"
   $UserAccount = "$env:USERDOMAIN\$env:USERNAME"
   ```

   Replace $ScriptPath with the actual path to your sync.ps1 script, $TaskName with a name for your task.

1. **Configure Task Trigger:** Set up a trigger for your task. In this example, we'll schedule the task to run daily at 9:00 PM:

   ```ps1
   $Trigger = New-ScheduledTaskTrigger -Daily -At '9:00 PM'
   ```

   You can adjust the schedule according to your preference.

1. Define Task Principal and Settings: Configure the task's principal (the user account under which the task will run) and settings:

   ```ps1
   $Principal = New-ScheduledTaskPrincipal -UserId $UserAccount -RunLevel Highest
   $Settings = New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -RunOnlyIfNetworkAvailable -WakeToRun
   ```

   These settings ensure that the task runs with the necessary privileges and conditions.

1. **Define Task Action:** Specify the action that the task will perform, which is running the PowerShell script:

   ```ps1
   $Action = New-ScheduledTaskAction -Execute 'PowerShell.exe' -Argument "-ExecutionPolicy Bypass -WindowStyle Hidden -File `"$ScriptPath`""
   ```

   This action runs PowerShell with the provided script.

1. **Create the Scheduled Task:** Finally, create the scheduled task and register it with Windows Task Scheduler:

   ```ps1
   $Task = New-ScheduledTask -Action $Action -Trigger $Trigger -Principal $Principal -Settings $Settings
   Register-ScheduledTask -TaskName $TaskName -InputObject $Task
   ```

The Obsidian synchronization task is now set up and ready to run automatically based on the schedule you defined.

# Inspiration

When looking up on how to implement this I found some breakthrough from this [stack overflow](https://stackoverflow.com/questions/7195503/setting-up-a-cron-job-in-windows) post. There are suggestions on how to do this using cron jobs in wsl. They are worth a look at. This article on [powershell](https://learn.microsoft.com/en-us/powershell/module/scheduledtasks/new-scheduledtask?view=windowsserver2022-ps) with windows server was also helpful.

[^note]: This method is only optimal for desktop sync. To sync across devices obsidian has a paid plan that has some extra features Such as Sync notes across devices, End-to-end encryption, Version history, Priority email support. Consider checking it out at [https://obsidian.md/pricing](https://obsidian.md/pricing)
